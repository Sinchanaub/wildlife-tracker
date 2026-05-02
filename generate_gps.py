"""
=============================================================
  WildTrack — GPS Movement Simulator
=============================================================
  Generates realistic GPS tracks for every animal in your DB
  and bulk-inserts them into gps_logs.

  Each animal moves in a natural wandering pattern that stays
  within its habitat's geographic bounds. Movement speed and
  range are tuned per species type.

  Usage:
      python generate_gps.py

  Edit the CONFIG section below if your DB credentials differ.
=============================================================
"""

import random
import math
import os
import sys
from datetime import datetime, timedelta
import mysql.connector

# =============================================================
#  CONFIG
# =============================================================

DB = dict(
    host     = os.environ.get('DB_HOST',     'localhost'),
    database = os.environ.get('DB_NAME',     'wildlife_db'),
    user     = os.environ.get('DB_USER',     'root'),
    password = os.environ.get('DB_PASSWORD', 'root'),
    port     = int(os.environ.get('DB_PORT', 3306)),
)

DAYS_OF_HISTORY  = 30       # how many days of GPS history to generate
PINGS_PER_DAY    = 6        # GPS collar pings per day (every 4 hours)
CLEAR_EXISTING   = False    # set True to wipe old logs before inserting

# Movement radius (degrees) per ping — tuned per species
SPECIES_RANGE = {
    'Bengal Tiger'       : 0.025,   # ~2.5 km per ping, large territory
    'Indian Elephant'    : 0.018,   # moves in herds, steady pace
    'Snow Leopard'       : 0.030,   # high altitude wanderer
    'Indian Rhinoceros'  : 0.010,   # stays near water, smaller range
    'Red Panda'          : 0.005,   # tiny territory, bamboo groves
    'Gharial'            : 0.008,   # river-bound
    'Indian Wild Dog'    : 0.022,   # pack hunter, wide range
    'Blackbuck'          : 0.020,   # open grassland sprinter
}
DEFAULT_RANGE = 0.015

# Altitude variation (metres) per ping per species
SPECIES_ALTITUDE = {
    'Snow Leopard' : (3800, 4600),
    'Red Panda'    : (2200, 3000),
    'Bengal Tiger' : (200,  450),
    'Indian Elephant': (60, 120),
    'Indian Rhinoceros': (50, 90),
    'Gharial'      : (40,  80),
    'Indian Wild Dog': (300, 600),
    'Blackbuck'    : (250, 420),
}
DEFAULT_ALT = (100, 400)

# =============================================================

def connect():
    try:
        conn = mysql.connector.connect(**DB)
        print(f"✓ Connected → {DB['database']}")
        return conn
    except mysql.connector.Error as e:
        print(f"✗ DB connection failed: {e}")
        sys.exit(1)


def get_animals(conn):
    cur = conn.cursor(dictionary=True)
    cur.execute("""
        SELECT a.animal_id, a.name, a.tag_number,
               s.common_name AS species,
               h.latitude    AS hab_lat,
               h.longitude   AS hab_lon,
               h.name        AS habitat_name
        FROM animals a
        JOIN species  s ON a.species_id  = s.species_id
        JOIN habitats h ON a.habitat_id  = h.habitat_id
        WHERE h.latitude IS NOT NULL AND h.longitude IS NOT NULL
    """)
    rows = cur.fetchall()
    cur.close()
    return rows


def get_latest_position(conn, animal_id):
    """Return last known (lat, lon) for this animal, or None."""
    cur = conn.cursor(dictionary=True)
    cur.execute("""
        SELECT latitude, longitude FROM gps_logs
        WHERE animal_id = %s
        ORDER BY recorded_at DESC LIMIT 1
    """, (animal_id,))
    row = cur.fetchone()
    cur.close()
    return (float(row['latitude']), float(row['longitude'])) if row else None


def biased_step(lat, lon, step, home_lat, home_lon, home_pull=0.15):
    """
    Move one step in a random direction, with a weak pull back toward
    the habitat centre so the animal doesn't drift off into the ocean.
    """
    angle = random.uniform(0, 2 * math.pi)

    # home pull — nudge angle slightly toward habitat centre
    dx = home_lon - lon
    dy = home_lat - lat
    home_angle = math.atan2(dy, dx)
    blended = angle * (1 - home_pull) + home_angle * home_pull

    new_lat = lat + step * math.sin(blended)
    new_lon = lon + step * math.cos(blended)
    return round(new_lat, 6), round(new_lon, 6)


def generate_track(animal, start_dt):
    """Yield (lat, lon, altitude, timestamp) tuples for one animal."""
    species  = animal['species']
    step     = SPECIES_RANGE.get(species, DEFAULT_RANGE)
    alt_min, alt_max = SPECIES_ALTITUDE.get(species, DEFAULT_ALT)
    home_lat = float(animal['hab_lat'])
    home_lon = float(animal['hab_lon'])

    # Start slightly offset from habitat centre
    lat = home_lat + random.uniform(-step * 2, step * 2)
    lon = home_lon + random.uniform(-step * 2, step * 2)
    alt = random.uniform(alt_min, alt_max)

    ts  = start_dt
    interval_hours = 24 // PINGS_PER_DAY

    total_pings = DAYS_OF_HISTORY * PINGS_PER_DAY

    for _ in range(total_pings):
        yield lat, lon, round(alt, 1), ts

        # Move
        lat, lon = biased_step(lat, lon, step, home_lat, home_lon)

        # Altitude drift
        alt += random.uniform(-30, 30)
        alt = max(alt_min, min(alt_max, alt))

        ts += timedelta(hours=interval_hours)


def simulate(conn):
    animals = get_animals(conn)
    if not animals:
        print("No animals found in DB.")
        return

    cur = conn.cursor()

    if CLEAR_EXISTING:
        print("⚠  Clearing existing GPS logs …")
        cur.execute("DELETE FROM gps_logs")
        conn.commit()

    # Start date = DAYS_OF_HISTORY ago at 06:00
    start_dt = datetime.now().replace(
        hour=6, minute=0, second=0, microsecond=0
    ) - timedelta(days=DAYS_OF_HISTORY)

    total_inserted = 0

    for animal in animals:
        aid  = animal['animal_id']
        name = animal['name']

        # If animal already has logs, start from where it left off
        last_pos = get_latest_position(conn, aid)
        if last_pos:
            print(f"  {name:20s} — already has GPS logs, skipping")
            continue

        rows = list(generate_track(animal, start_dt))

        cur.executemany("""
            INSERT INTO gps_logs (animal_id, latitude, longitude, altitude_m, recorded_at)
            VALUES (%s, %s, %s, %s, %s)
        """, [(aid, lat, lon, alt, ts) for lat, lon, alt, ts in rows])

        conn.commit()
        total_inserted += len(rows)
        print(f"  {name:20s} ({animal['tag_number']})  →  {len(rows)} GPS pings  [{animal['habitat_name']}]")

    cur.close()
    print(f"\n✓ Done — {total_inserted} total GPS records inserted.")
    print(f"  Each animal now has {DAYS_OF_HISTORY * PINGS_PER_DAY} movement points over {DAYS_OF_HISTORY} days.")


if __name__ == '__main__':
    conn = connect()
    simulate(conn)
    conn.close()
