# 🌿 Wildlife Conservation Tracker
### DBMS Project | Python Flask + MySQL 8.0

---

## ⚙️ Setup Instructions

### Step 1 — Open MySQL Workbench
Connect using your root user and password.

### Step 2 — Run the schema
- Go to File → Open SQL Script → select `schema.sql`
- Click the ⚡ (Execute) button
- This creates the database, all tables, views, trigger, stored procedure, and sample data

### Step 3 — Install Python dependencies
Open your terminal / command prompt:
```bash
pip install flask mysql-connector-python
```

### Step 4 — Set your MySQL password in app.py
Open `app.py` and find:
```python
password=os.environ.get('DB_PASSWORD', 'your_password'),
```
Replace `your_password` with your actual MySQL root password.

### Step 5 — Run the app
```bash
python app.py
```
Open browser at: **http://localhost:5000**

---

## 🗄️ SQL Features Used

| Feature | Details |
|---|---|
| Tables | 7 tables with Foreign Keys, ENUMs, AUTO_INCREMENT |
| Views | endangered_animals_view, habitat_summary_view, recent_gps_view |
| Trigger | trg_update_habitat_threat — auto-updates threat level on new incident |
| Stored Procedure | get_conservation_report() — used on dashboard |
| JOINs | Multi-table joins on every page |
| Aggregate Functions | COUNT, GROUP BY in habitat summary |
| Normalization | Designed to 3NF |

---

## 📄 Pages

| Page | URL |
|---|---|
| Dashboard | http://localhost:5000/ |
| Animals | http://localhost:5000/animals |
| Habitats | http://localhost:5000/habitats |
| Rangers | http://localhost:5000/rangers |
| GPS Logs | http://localhost:5000/gps |
| Incidents | http://localhost:5000/incidents |
