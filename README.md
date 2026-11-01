# 🌿 Wildlife Conservation Tracker

A database-driven web app for tracking endangered animals, habitats, ranger patrols, poaching incidents and GPS movement. Built as a **DBMS project** with Flask and MySQL 8.0, with the database logic (views, trigger, stored procedure) doing much of the heavy lifting.

🔗 **Live demo:** [add URL if deployed]

![Dashboard](screenshot.png)

## Features

- **Dashboard** with Chart.js charts (incidents, animal status, habitat threat levels), fed by a stored procedure
- **Animals:** list with search and species / health-status filters, add form, and detail pages with a **Leaflet movement map** of recent GPS positions
- **Habitats, Rangers, Patrol logs, Poaching incidents, GPS logs:** list and add forms for each
- **Automatic threat levels:** logging an incident can raise its habitat's threat level via a database trigger
- **Indian wildlife dataset** (real species, reserves and coordinates) and a **GPS movement simulator**
- JSON endpoint `GET /api/gps/<animal_id>` returning an animal's last 50 positions, and `GET /health` for DB connectivity checks

## Database design

| Feature | Details |
|---|---|
| Tables (7) | `species`, `habitats`, `rangers`, `animals`, `gps_logs`, `poaching_incidents`, `patrol_logs` |
| Constraints | Primary and foreign keys, ENUMs, AUTO_INCREMENT; designed to 3NF |
| Views (3) | `endangered_animals_view`, `habitat_summary_view`, `recent_gps_view` |
| Trigger | `trg_update_habitat_threat` runs after each new incident and counts the habitat's open incidents from the last 90 days: 1+ sets threat to Medium, 3+ to High, 5+ to Critical |
| Stored procedure | `get_conservation_report()` powers the dashboard |
| Queries | Multi-table JOINs on every page, plus COUNT and GROUP BY aggregates |

## Tech stack

Python · Flask · MySQL 8.0 · mysql-connector-python · Jinja2 · Chart.js · Leaflet · Gunicorn

## Project structure

```
app.py                   Flask routes and DB helpers
schema.sql               Database, tables, views, trigger, procedure, sample data
dataset_extension.sql    Extended Indian wildlife dataset
generate_gps.py          GPS movement simulator
templates/               Jinja2 pages (dashboard, animals, habitats, ...)
render.yaml, railway.json  Deployment configs
```

## Run locally

1. **Create the database:** in MySQL Workbench, open and run `schema.sql`. This creates `wildlife_db` with all tables, views, the trigger, the procedure and sample data.
2. **(Optional) Load the larger dataset:** run `dataset_extension.sql`.
3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```
4. **Set your database credentials** as environment variables (defaults are `localhost`, `wildlife_db`, `root`, `root`, `3306`):
   ```bash
   export DB_HOST=localhost DB_NAME=wildlife_db DB_USER=root DB_PASSWORD=yourpassword DB_PORT=3306
   ```
5. **(Optional) Generate GPS tracks** for every animal, constrained to its habitat's bounds:
   ```bash
   python generate_gps.py
   ```
   Edit the CONFIG section at the top if your credentials differ.
6. **Run the app:**
   ```bash
   python app.py
   ```
   Open http://localhost:5000.

## Pages

| Page | Route |
|---|---|
| Dashboard | `/` |
| Animals (and detail) | `/animals`, `/animals/<id>` |
| Habitats | `/habitats` |
| Rangers | `/rangers` |
| Patrols | `/patrols` |
| Incidents | `/incidents` |
| GPS logs | `/gps` |

Each section also has an `/add` form.

## Deployment

`render.yaml` and `railway.json` are included. Set `DB_HOST`, `DB_NAME`, `DB_USER`, `DB_PASSWORD` and `DB_PORT` in the platform's environment settings and point them at a hosted MySQL instance.

## Future work

- User authentication and role-based access (rangers vs admins)
- Edit and delete operations
- Alerts when an animal leaves its habitat bounds
