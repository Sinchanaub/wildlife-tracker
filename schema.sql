-- ============================================
-- WILDLIFE CONSERVATION TRACKER
-- MySQL 8.0 Schema
-- ============================================

DROP DATABASE IF EXISTS wildlife_db;
CREATE DATABASE wildlife_db;
USE wildlife_db;

-- ============================================
-- CORE TABLES
-- ============================================

CREATE TABLE species (
    species_id INT AUTO_INCREMENT PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL UNIQUE,
    conservation_status ENUM('Least Concern','Near Threatened','Vulnerable','Endangered','Critically Endangered','Extinct in Wild','Extinct'),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE habitats (
    habitat_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(200) NOT NULL,
    area_sqkm DECIMAL(10,2),
    habitat_type ENUM('Forest','Grassland','Wetland','Desert','Ocean','Mountain','Savanna'),
    threat_level ENUM('Low','Medium','High','Critical') DEFAULT 'Low',
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE rangers (
    ranger_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    badge_number VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20),
    assigned_habitat_id INT,
    join_date DATE,
    status ENUM('Active','On Leave','Retired') DEFAULT 'Active',
    FOREIGN KEY (assigned_habitat_id) REFERENCES habitats(habitat_id)
);

CREATE TABLE animals (
    animal_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    species_id INT NOT NULL,
    habitat_id INT NOT NULL,
    gender ENUM('Male','Female','Unknown'),
    age_years INT,
    weight_kg DECIMAL(7,2),
    tag_number VARCHAR(30) NOT NULL UNIQUE,
    health_status ENUM('Healthy','Injured','Sick','Under Treatment','Critical','Deceased') DEFAULT 'Healthy',
    is_tagged BOOLEAN DEFAULT TRUE,
    notes TEXT,
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (species_id) REFERENCES species(species_id),
    FOREIGN KEY (habitat_id) REFERENCES habitats(habitat_id)
);

CREATE TABLE gps_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    animal_id INT NOT NULL,
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    altitude_m DECIMAL(7,2),
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (animal_id) REFERENCES animals(animal_id)
);

CREATE TABLE poaching_incidents (
    incident_id INT AUTO_INCREMENT PRIMARY KEY,
    habitat_id INT NOT NULL,
    reported_by INT,
    incident_date DATE NOT NULL,
    description TEXT NOT NULL,
    severity ENUM('Low','Medium','High','Critical'),
    status ENUM('Open','Under Investigation','Resolved','Closed') DEFAULT 'Open',
    animals_affected INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (habitat_id) REFERENCES habitats(habitat_id),
    FOREIGN KEY (reported_by) REFERENCES rangers(ranger_id)
);

CREATE TABLE patrol_logs (
    patrol_id INT AUTO_INCREMENT PRIMARY KEY,
    ranger_id INT NOT NULL,
    habitat_id INT NOT NULL,
    patrol_date DATE NOT NULL,
    start_time TIME,
    end_time TIME,
    area_covered_sqkm DECIMAL(6,2),
    observations TEXT,
    incident_found BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id),
    FOREIGN KEY (habitat_id) REFERENCES habitats(habitat_id)
);

-- ============================================
-- VIEWS
-- ============================================

CREATE VIEW endangered_animals_view AS
SELECT
    a.animal_id, a.name AS animal_name, a.tag_number,
    s.common_name AS species, s.conservation_status,
    h.name AS habitat, h.threat_level,
    a.health_status
FROM animals a
JOIN species s ON a.species_id = s.species_id
JOIN habitats h ON a.habitat_id = h.habitat_id
WHERE s.conservation_status IN ('Endangered','Critically Endangered','Extinct in Wild');

CREATE VIEW habitat_summary_view AS
SELECT
    h.habitat_id, h.name, h.habitat_type, h.threat_level,
    h.area_sqkm,
    COUNT(DISTINCT a.animal_id) AS total_animals,
    COUNT(DISTINCT pi.incident_id) AS total_incidents,
    COUNT(DISTINCT r.ranger_id) AS total_rangers
FROM habitats h
LEFT JOIN animals a ON h.habitat_id = a.habitat_id
LEFT JOIN poaching_incidents pi ON h.habitat_id = pi.habitat_id
LEFT JOIN rangers r ON h.habitat_id = r.assigned_habitat_id
GROUP BY h.habitat_id, h.name, h.habitat_type, h.threat_level, h.area_sqkm;

CREATE VIEW recent_gps_view AS
SELECT g.animal_id, a.name AS animal_name, a.tag_number,
    s.common_name AS species,
    g.latitude, g.longitude, g.recorded_at
FROM gps_logs g
JOIN animals a ON g.animal_id = a.animal_id
JOIN species s ON a.species_id = s.species_id
WHERE g.recorded_at = (
    SELECT MAX(g2.recorded_at) FROM gps_logs g2
    WHERE g2.animal_id = g.animal_id
);

-- ============================================
-- TRIGGER: Auto-update habitat threat level
-- ============================================

DELIMITER $$

CREATE TRIGGER trg_update_habitat_threat
AFTER INSERT ON poaching_incidents
FOR EACH ROW
BEGIN
    DECLARE incident_count INT;

    SELECT COUNT(*) INTO incident_count
    FROM poaching_incidents
    WHERE habitat_id = NEW.habitat_id
      AND status != 'Closed'
      AND incident_date >= DATE_SUB(CURDATE(), INTERVAL 90 DAY);

    IF incident_count >= 5 THEN
        UPDATE habitats SET threat_level = 'Critical' WHERE habitat_id = NEW.habitat_id;
    ELSEIF incident_count >= 3 THEN
        UPDATE habitats SET threat_level = 'High' WHERE habitat_id = NEW.habitat_id;
    ELSEIF incident_count >= 1 THEN
        UPDATE habitats SET threat_level = 'Medium' WHERE habitat_id = NEW.habitat_id;
    END IF;
END$$

DELIMITER ;

-- ============================================
-- STORED PROCEDURE: Conservation Report
-- ============================================

DELIMITER $$

CREATE PROCEDURE get_conservation_report()
BEGIN
    SELECT 'Total Animals Tracked' AS metric, CAST(COUNT(*) AS CHAR) AS value FROM animals
    UNION ALL
    SELECT 'Endangered Animals', CAST(COUNT(*) AS CHAR) FROM animals a
        JOIN species s ON a.species_id = s.species_id
        WHERE s.conservation_status IN ('Endangered','Critically Endangered')
    UNION ALL
    SELECT 'Total Habitats', CAST(COUNT(*) AS CHAR) FROM habitats
    UNION ALL
    SELECT 'Critical Habitats', CAST(COUNT(*) AS CHAR) FROM habitats WHERE threat_level = 'Critical'
    UNION ALL
    SELECT 'Active Rangers', CAST(COUNT(*) AS CHAR) FROM rangers WHERE status = 'Active'
    UNION ALL
    SELECT 'Open Poaching Incidents', CAST(COUNT(*) AS CHAR) FROM poaching_incidents WHERE status = 'Open'
    UNION ALL
    SELECT 'GPS Logs Recorded', CAST(COUNT(*) AS CHAR) FROM gps_logs;
END$$

DELIMITER ;

-- ============================================
-- SAMPLE DATA
-- ============================================

INSERT INTO species (common_name, scientific_name, conservation_status, description) VALUES
('Bengal Tiger', 'Panthera tigris tigris', 'Endangered', 'Largest wild cat native to the Indian subcontinent'),
('Indian Elephant', 'Elephas maximus indicus', 'Endangered', 'Largest land animal in Asia'),
('Snow Leopard', 'Panthera uncia', 'Vulnerable', 'Mountain predator found in Central Asia'),
('Indian Rhinoceros', 'Rhinoceros unicornis', 'Vulnerable', 'One-horned rhino found in Nepal and India'),
('Red Panda', 'Ailurus fulgens', 'Endangered', 'Small mammal native to Himalayas'),
('Gharial', 'Gavialis gangeticus', 'Critically Endangered', 'Critically endangered crocodilian'),
('Indian Wild Dog', 'Cuon alpinus', 'Endangered', 'Pack-hunting canid of South Asia'),
('Blackbuck', 'Antilope cervicapra', 'Least Concern', 'Indian antelope known for speed');

INSERT INTO habitats (name, location, area_sqkm, habitat_type, threat_level, latitude, longitude) VALUES
('Sundarbans Reserve', 'West Bengal, India', 4262.00, 'Forest', 'High', 21.9497, 89.1833),
('Kaziranga National Park', 'Assam, India', 859.00, 'Grassland', 'Medium', 26.6638, 93.3700),
('Jim Corbett Reserve', 'Uttarakhand, India', 1318.00, 'Forest', 'Low', 29.5300, 78.7747),
('Ranthambore National Park', 'Rajasthan, India', 1334.00, 'Forest', 'Medium', 26.0173, 76.5026),
('Hemis National Park', 'Ladakh, India', 4400.00, 'Mountain', 'Low', 33.5000, 77.0000),
('Chambal Sanctuary', 'Madhya Pradesh, India', 435.00, 'Wetland', 'Critical', 26.2906, 78.2000);

INSERT INTO rangers (full_name, badge_number, email, phone, assigned_habitat_id, join_date, status) VALUES
('Arjun Mehta', 'RNG-001', 'arjun.mehta@wctracker.in', '9876543210', 1, '2018-06-01', 'Active'),
('Priya Sharma', 'RNG-002', 'priya.sharma@wctracker.in', '9876543211', 2, '2019-03-15', 'Active'),
('Rahul Verma', 'RNG-003', 'rahul.verma@wctracker.in', '9876543212', 3, '2020-01-10', 'Active'),
('Sneha Patel', 'RNG-004', 'sneha.patel@wctracker.in', '9876543213', 4, '2017-09-20', 'Active'),
('Kiran Das', 'RNG-005', 'kiran.das@wctracker.in', '9876543214', 5, '2021-07-05', 'Active'),
('Amit Tiwari', 'RNG-006', 'amit.tiwari@wctracker.in', '9876543215', 6, '2016-11-30', 'On Leave');

INSERT INTO animals (name, species_id, habitat_id, gender, age_years, weight_kg, tag_number, health_status, notes) VALUES
('Shiva', 1, 4, 'Male', 7, 220.5, 'TAG-T001', 'Healthy', 'Alpha male of Ranthambore zone T1'),
('Durga', 1, 3, 'Female', 5, 185.0, 'TAG-T002', 'Healthy', 'Known for three cubs in 2023'),
('Ganesha', 2, 2, 'Male', 35, 4200.0, 'TAG-E001', 'Healthy', 'Oldest elephant in Kaziranga'),
('Lakshmi', 2, 2, 'Female', 22, 3100.0, 'TAG-E002', 'Healthy', 'Part of main herd'),
('Himgiri', 3, 5, 'Male', 6, 52.0, 'TAG-SL001', 'Healthy', 'Spotted near Hemis peak'),
('Raja', 4, 2, 'Male', 15, 2100.0, 'TAG-R001', 'Under Treatment', 'Recovering from minor injury'),
('Meera', 5, 5, 'Female', 3, 6.2, 'TAG-RP001', 'Healthy', 'Red panda tracked near bamboo groves'),
('Kali', 1, 1, 'Female', 4, 170.0, 'TAG-T003', 'Healthy', 'Tiger in Sundarbans delta region'),
('Aryan', 7, 3, 'Male', 4, 18.5, 'TAG-WD001', 'Healthy', 'Pack leader of Corbett dholes'),
('Cheetah', 8, 4, 'Male', 2, 38.0, 'TAG-BB001', 'Healthy', 'Young blackbuck, fast runner');

INSERT INTO gps_logs (animal_id, latitude, longitude, altitude_m, recorded_at) VALUES
(1, 26.0200, 76.5100, 350.0, '2024-03-01 06:00:00'),
(1, 26.0250, 76.5200, 355.0, '2024-03-01 10:00:00'),
(1, 26.0300, 76.5150, 360.0, '2024-03-01 14:00:00'),
(2, 29.5350, 78.7800, 420.0, '2024-03-01 07:00:00'),
(2, 29.5400, 78.7850, 425.0, '2024-03-01 11:00:00'),
(3, 26.6700, 93.3750, 80.0,  '2024-03-01 08:00:00'),
(3, 26.6650, 93.3800, 78.0,  '2024-03-01 12:00:00'),
(5, 33.5050, 77.0050, 4200.0,'2024-03-01 09:00:00'),
(5, 33.5100, 77.0100, 4210.0,'2024-03-01 13:00:00'),
(8, 21.9550, 89.1900, 5.0,   '2024-03-01 06:30:00'),
(8, 21.9600, 89.1950, 5.0,   '2024-03-01 10:30:00');

INSERT INTO poaching_incidents (habitat_id, reported_by, incident_date, description, severity, status, animals_affected) VALUES
(1, 1, '2024-02-10', 'Illegal fishing nets found near tiger territory', 'Medium', 'Resolved', 0),
(2, 2, '2024-02-18', 'Rhino horn poachers spotted near eastern boundary', 'Critical', 'Under Investigation', 1),
(4, 4, '2024-02-25', 'Trap found near water source in zone T2', 'High', 'Open', 0),
(6, 6, '2024-03-01', 'Gharial eggs stolen from nesting site', 'Critical', 'Open', 0),
(3, 3, '2024-03-05', 'Unauthorized vehicle tracks found in restricted zone', 'Low', 'Closed', 0);

INSERT INTO patrol_logs (ranger_id, habitat_id, patrol_date, start_time, end_time, area_covered_sqkm, observations, incident_found) VALUES
(1, 1, '2024-03-01', '06:00:00', '12:00:00', 15.5, 'Tiger tracks spotted near delta. All clear.', FALSE),
(2, 2, '2024-03-01', '07:00:00', '13:00:00', 20.0, 'Rhino herd of 6 spotted. One injured.', TRUE),
(3, 3, '2024-03-02', '05:30:00', '11:30:00', 18.0, 'Dhole pack active near river. No threats.', FALSE),
(4, 4, '2024-03-02', '06:00:00', '14:00:00', 25.0, 'Trap found and removed near zone T2.', TRUE),
(5, 5, '2024-03-03', '08:00:00', '15:00:00', 30.0, 'Snow leopard tracks at 4200m altitude.', FALSE);
