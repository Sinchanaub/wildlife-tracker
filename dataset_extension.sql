-- ============================================
-- WILDLIFE CONSERVATION TRACKER
-- Extended Indian Wildlife Dataset
-- Real species, reserves & coordinates
-- ============================================

USE wildlife_db;

-- ============================================
-- ADDITIONAL SPECIES (real Indian wildlife)
-- ============================================

INSERT INTO species (common_name, scientific_name, conservation_status, description) VALUES
('Indian Leopard',        'Panthera pardus fusca',         'Vulnerable',            'Adaptable big cat found across India in forests and scrublands'),
('Asiatic Lion',          'Panthera leo persica',          'Endangered',            'Last wild population survives only in Gir Forest, Gujarat'),
('Indian Pangolin',       'Manis crassicaudata',           'Endangered',            'Heavily trafficked scaly mammal found in Indian subcontinent'),
('Nilgiri Tahr',          'Nilgiris hylocrius',            'Endangered',            'Mountain ungulate endemic to the Western Ghats'),
('Lion-tailed Macaque',   'Macaca silenus',                'Endangered',            'Critically shy primate endemic to Western Ghats rainforests'),
('Indian Bustard',        'Ardeotis nigriceps',            'Critically Endangered', 'One of the heaviest flying birds, nearly extinct due to habitat loss'),
('Fishing Cat',           'Prionailurus viverrinus',       'Vulnerable',            'Wetland specialist cat found in mangroves and marshes'),
('Sloth Bear',            'Melursus ursinus',              'Vulnerable',            'Shaggy insectivorous bear native to Indian subcontinent'),
('Indian Gaur',           'Bos gaurus',                    'Vulnerable',            'Largest wild bovine found in South and Southeast Asia'),
('Nilgiri Langur',        'Trachypithecus johnii',         'Vulnerable',            'Dark-furred leaf monkey endemic to Western Ghats'),
('Smooth-coated Otter',   'Lutrogale perspicillata',       'Vulnerable',            'Semi-aquatic mammal found along rivers and wetlands'),
('Pygmy Hog',             'Porcula salvania',              'Endangered',            'World smallest wild pig, nearly extinct, found in Assam'),
('Malabar Large Spotted Cat', 'Prionailurus rubiginosus',  'Vulnerable',            'Rare small wild cat endemic to Western Ghats'),
('Indian Vulture',        'Gyps indicus',                  'Critically Endangered', 'Critically endangered raptor decimated by veterinary diclofenac'),
('Olive Ridley Turtle',   'Lepidochelys olivacea',         'Vulnerable',            'Mass nesting sea turtle famous for Odisha arribada events');

-- ============================================
-- ADDITIONAL HABITATS (real Indian reserves)
-- ============================================

INSERT INTO habitats (name, location, area_sqkm, habitat_type, threat_level, latitude, longitude) VALUES
('Gir National Park',           'Gujarat, India',           1412.00, 'Forest',    'High',     21.1239, 70.7972),
('Periyar Tiger Reserve',       'Kerala, India',            925.00,  'Forest',    'Medium',   9.4588,  77.1961),
('Bandipur National Park',      'Karnataka, India',         874.00,  'Forest',    'Medium',   11.6711, 76.6341),
('Nagarhole National Park',     'Karnataka, India',         643.00,  'Forest',    'Low',      12.0500, 76.1300),
('Kanha Tiger Reserve',         'Madhya Pradesh, India',    1945.00, 'Forest',    'Low',      22.3375, 80.6117),
('Pench Tiger Reserve',         'Madhya Pradesh, India',    1179.00, 'Forest',    'Medium',   21.7600, 79.3100),
('Tadoba Andhari Tiger Reserve','Maharashtra, India',       1727.00, 'Forest',    'High',     20.2167, 79.3333),
('Chilika Lake Sanctuary',      'Odisha, India',            1100.00, 'Wetland',   'High',     19.7167, 85.3167),
('Bharatpur Bird Sanctuary',    'Rajasthan, India',         29.00,   'Wetland',   'Medium',   27.1744, 77.5144),
('Silent Valley National Park', 'Kerala, India',            237.00,  'Forest',    'Low',      11.0800, 76.4700),
('Manas National Park',         'Assam, India',             950.00,  'Forest',    'Critical', 26.6833, 91.0167),
('Dibru-Saikhowa National Park','Assam, India',             340.00,  'Wetland',   'High',     27.6500, 95.2000);

-- ============================================
-- ADDITIONAL RANGERS
-- ============================================

INSERT INTO rangers (full_name, badge_number, email, phone, assigned_habitat_id, join_date, status) VALUES
('Vijay Nair',        'RNG-007', 'vijay.nair@wctracker.in',      '9845001001', 7,  '2015-04-12', 'Active'),
('Meenakshi Iyer',    'RNG-008', 'meenakshi.iyer@wctracker.in',  '9845001002', 8,  '2017-08-22', 'Active'),
('Suresh Gowda',      'RNG-009', 'suresh.gowda@wctracker.in',    '9845001003', 9,  '2019-11-05', 'Active'),
('Deepa Krishnan',    'RNG-010', 'deepa.krishnan@wctracker.in',  '9845001004', 10, '2016-02-18', 'Active'),
('Rajan Pillai',      'RNG-011', 'rajan.pillai@wctracker.in',    '9845001005', 11, '2020-06-30', 'Active'),
('Tanuja Desai',      'RNG-012', 'tanuja.desai@wctracker.in',    '9845001006', 12, '2018-09-14', 'Active'),
('Bhaskar Rao',       'RNG-013', 'bhaskar.rao@wctracker.in',     '9845001007', 13, '2014-03-25', 'Active'),
('Lakshmi Devi',      'RNG-014', 'lakshmi.devi@wctracker.in',    '9845001008', 14, '2021-01-08', 'Active'),
('Mohan Tripathi',    'RNG-015', 'mohan.tripathi@wctracker.in',  '9845001009', 15, '2013-07-19', 'Active'),
('Chandrika Menon',   'RNG-016', 'chandrika.menon@wctracker.in', '9845001010', 16, '2022-04-03', 'Active'),
('Dilip Borgohain',   'RNG-017', 'dilip.borgohain@wctracker.in', '9845001011', 17, '2015-12-11', 'On Leave'),
('Anita Hazarika',    'RNG-018', 'anita.hazarika@wctracker.in',  '9845001012', 18, '2018-05-27', 'Active');

-- ============================================
-- ANIMALS (50 total with new + existing species)
-- Covers all 18 habitats
-- ============================================

INSERT INTO animals (name, species_id, habitat_id, gender, age_years, weight_kg, tag_number, health_status, notes) VALUES
-- Gir (habitat 7) — Asiatic Lions (species 10 = Asiatic Lion)
('Akbar',    10, 7,  'Male',   9,  190.0, 'TAG-AL001', 'Healthy',         'Pride male, dominant in Gir eastern zone'),
('Noor',     10, 7,  'Female', 6,  130.0, 'TAG-AL002', 'Healthy',         'Mother of two cubs born 2023'),
('Sultan',   10, 7,  'Male',   4,  160.0, 'TAG-AL003', 'Healthy',         'Sub-adult, recently dispersed from pride'),
('Rani',     10, 7,  'Female', 7,  125.0, 'TAG-AL004', 'Injured',         'Injured left forepaw, under monitoring'),

-- Periyar (habitat 8) — Indian Elephants + Leopard
('Indra',     2, 8,  'Female', 28, 3400.0, 'TAG-E003', 'Healthy',         'Matriarch of Periyar southern herd'),
('Bhima',     2, 8,  'Male',   18, 4800.0, 'TAG-E004', 'Healthy',         'Large tusker, known to rangers'),
('Kamala',    2, 8,  'Female', 12, 2800.0, 'TAG-E005', 'Healthy',         'Youngest adult female in herd'),
('Veera',     9, 8,  'Male',   5,  62.0,   'TAG-L001', 'Healthy',         'Leopard, active near Periyar lake'),

-- Bandipur (habitat 9) — Tiger + Gaur + Sloth Bear
('Aranya',    1, 9,  'Female', 6,  175.0,  'TAG-T004', 'Healthy',         'Tigress with territory near Bandipur core'),
('Nandi',    17, 9,  'Male',   8,  850.0,  'TAG-G001', 'Healthy',         'Large male gaur, dominant bull'),
('Kaveri',   17, 9,  'Female', 5,  600.0,  'TAG-G002', 'Healthy',         'Gaur female part of 12-member herd'),
('Bruno',    16, 9,  'Male',   4,  105.0,  'TAG-SB001','Healthy',         'Sloth bear, range overlaps with tiger'),

-- Nagarhole (habitat 10) — Tiger + Elephant
('Kabini',    1, 10, 'Female', 8,  168.0,  'TAG-T005', 'Healthy',         'Famous tigress, frequently photographed'),
('Tusker',    2, 10, 'Male',   40, 5100.0, 'TAG-E006', 'Healthy',         'Legendary tusker of Nagarhole, 50+ years expected'),
('Revati',    2, 10, 'Female', 15, 3200.0, 'TAG-E007', 'Healthy',         'Leads sub-group of 5 females'),

-- Kanha (habitat 11) — Tiger + Gaur + Leopard
('Munna',     1, 11, 'Male',   10, 235.0,  'TAG-T006', 'Healthy',         'Famous CAT-marked tiger of Kanha'),
('Chingari',  1, 11, 'Female', 5,  155.0,  'TAG-T007', 'Healthy',         'Young tigress establishing territory'),
('Bhavani',  17, 11, 'Female', 7,  620.0,  'TAG-G003', 'Healthy',         'Gaur cow, part of meadow herd'),
('Kanha Leo', 9, 11, 'Male',   6,  58.0,   'TAG-L002', 'Under Treatment', 'Leopard, snare injury on hind leg'),

-- Pench (habitat 12) — Tiger + Wild Dog
('Collarwali', 1, 12, 'Female', 9, 172.0,  'TAG-T008', 'Healthy',         'Most documented tigress in India, 29 cubs'),
('Bagha',     1, 12, 'Male',   7,  210.0,  'TAG-T009', 'Healthy',         'Dominant male, range covers 80 sqkm'),
('Pench Dhole',7, 12, 'Male',  3,  16.0,   'TAG-WD002','Healthy',         'Alpha of 14-member dhole pack'),

-- Tadoba (habitat 13) — Tiger + Leopard
('Maya',      1, 13, 'Female', 11, 180.0,  'TAG-T010', 'Healthy',         'Queen of Tadoba, most photographed tiger'),
('Waghdoh',   1, 13, 'Male',   8,  220.0,  'TAG-T011', 'Healthy',         'Large male, known aggressive territorial behavior'),
('Tadoba Leo',9, 13, 'Male',   4,  55.0,   'TAG-L003', 'Healthy',         'Leopard coexisting with tigers in buffer zone'),

-- Chilika (habitat 14) — Fishing Cat + Smooth Otter
('Neela',    15, 14, 'Female', 3,  8.5,    'TAG-FC001','Healthy',         'Fishing cat near Chilika lake inlet'),
('Tara',     19, 14, 'Female', 4,  7.2,    'TAG-OT001','Healthy',         'Smooth otter, family group of 6'),
('Olive1',   23, 14, 'Female', 12, 42.0,   'TAG-ORT001','Healthy',        'Olive ridley female, nesting season tagged'),

-- Bharatpur (habitat 15) — Fishing Cat
('Bharatpur Leo', 9, 15, 'Male', 5, 52.0, 'TAG-L004', 'Healthy',         'Leopard from buffer forest, occasional visitor'),
('Marsh Cat',    15, 15, 'Female', 2, 7.8, 'TAG-FC002','Healthy',         'Fishing cat near Keoladeo wetland'),

-- Silent Valley (habitat 16) — Lion-tailed Macaque + Nilgiri Langur
('Sita',     13, 16, 'Female', 6,  6.5,    'TAG-LTM001','Healthy',        'Lion-tailed macaque matriarch, troop of 22'),
('Rama',     13, 16, 'Male',   8,  8.2,    'TAG-LTM002','Healthy',        'Dominant male of Silent Valley troop'),
('Shyama',   18, 16, 'Female', 5,  11.0,   'TAG-NL001', 'Healthy',        'Nilgiri langur, feeds on Strobilanthes'),

-- Manas (habitat 17) — Pygmy Hog + Elephant + Tiger
('Manas Pig1', 20, 17, 'Male', 2,  8.5,   'TAG-PH001', 'Healthy',         'Pygmy hog, critically rare, reintroduced individual'),
('Manas Pig2', 20, 17, 'Female',2, 7.8,   'TAG-PH002', 'Healthy',         'Breeding female, part of reintroduction program'),
('Manas Tigress', 1, 17, 'Female',7, 162.0,'TAG-T012', 'Healthy',         'Tigress recolonizing Manas after insurgency'),
('Manas Tusker', 2, 17, 'Male', 30, 4600.0,'TAG-E008', 'Healthy',         'Lone tusker in Manas northern range'),

-- Dibru-Saikhowa (habitat 18) — Feral Horse + Otter + Fishing Cat
('Dibru Otter', 19, 18, 'Male', 3,  6.9,  'TAG-OT002', 'Healthy',         'Smooth otter, riverine forest specialist'),
('Dibru FC',   15, 18, 'Male',  4,  9.1,  'TAG-FC003', 'Sick',            'Fishing cat, suspected respiratory infection'),

-- Additional Sundarbans (habitat 1)
('Bon Bibi',  1, 1, 'Female', 6,  160.0,  'TAG-T013',  'Healthy',         'Tigress adapted to tidal swimming in Sundarbans'),
('Dokkhin',   1, 1, 'Male',   9,  205.0,  'TAG-T014',  'Healthy',         'Dominant male, known to patrol 3 islands'),

-- Additional Kaziranga (habitat 2)
('Brahma',    4, 2, 'Male',  18,  2200.0, 'TAG-R002',  'Healthy',         'One-horned rhino, large territory near Diphlu river'),
('Parvati',   4, 2, 'Female',14,  1850.0, 'TAG-R003',  'Healthy',         'Rhino cow with calf born 2023'),
('Kazi',     20, 2, 'Male',   3,   8.2,   'TAG-PH003', 'Healthy',         'Pygmy hog reintroduced to Kaziranga buffer'),

-- Corbett additional (habitat 3)
('Paro',      1, 3, 'Female', 7,  170.0,  'TAG-T015',  'Healthy',         'Tigress with range near Ram Ganga'),
('Corbett Sloth', 16, 3, 'Male', 6, 115.0,'TAG-SB002', 'Healthy',         'Sloth bear using rocky outcrops near Dhikala');

-- ============================================
-- GPS LOGS (~100 entries, realistic coordinates)
-- ============================================

INSERT INTO gps_logs (animal_id, latitude, longitude, altitude_m, recorded_at) VALUES
-- Akbar (Asiatic Lion, Gir)
(11, 21.1200, 70.7920, 95.0,  '2024-11-01 05:30:00'),
(11, 21.1220, 70.7945, 93.0,  '2024-11-01 11:00:00'),
(11, 21.1190, 70.7960, 91.0,  '2024-11-01 18:30:00'),
(11, 21.1175, 70.7935, 94.0,  '2024-11-02 06:00:00'),

-- Noor (Asiatic Lioness, Gir)
(12, 21.1250, 70.8010, 96.0,  '2024-11-01 06:00:00'),
(12, 21.1270, 70.8030, 97.0,  '2024-11-01 14:00:00'),
(12, 21.1245, 70.8055, 95.0,  '2024-11-02 08:00:00'),

-- Indra (Elephant, Periyar)
(15, 9.4600,  77.2000, 910.0, '2024-11-01 07:00:00'),
(15, 9.4620,  77.2025, 915.0, '2024-11-01 13:00:00'),
(15, 9.4580,  77.1985, 908.0, '2024-11-02 07:30:00'),
(15, 9.4560,  77.1960, 905.0, '2024-11-02 15:00:00'),

-- Aranya (Tiger, Bandipur)
(19, 11.6750, 76.6400, 820.0, '2024-11-01 04:00:00'),
(19, 11.6780, 76.6430, 825.0, '2024-11-01 09:00:00'),
(19, 11.6720, 76.6380, 815.0, '2024-11-01 20:00:00'),
(19, 11.6700, 76.6350, 810.0, '2024-11-02 05:00:00'),

-- Kabini (Tiger, Nagarhole)
(23, 12.0520, 76.1320, 780.0, '2024-11-01 05:00:00'),
(23, 12.0550, 76.1360, 785.0, '2024-11-01 11:00:00'),
(23, 12.0490, 76.1290, 775.0, '2024-11-01 22:00:00'),
(23, 12.0470, 76.1260, 770.0, '2024-11-02 06:00:00'),

-- Munna (Tiger, Kanha)
(26, 22.3400, 80.6150, 620.0, '2024-11-01 05:30:00'),
(26, 22.3430, 80.6180, 625.0, '2024-11-01 10:30:00'),
(26, 22.3380, 80.6120, 618.0, '2024-11-01 19:00:00'),
(26, 22.3360, 80.6100, 615.0, '2024-11-02 04:30:00'),
(26, 22.3390, 80.6140, 622.0, '2024-11-02 12:00:00'),

-- Collarwali (Tiger, Pench)
(30, 21.7620, 79.3120, 440.0, '2024-11-01 04:00:00'),
(30, 21.7650, 79.3150, 445.0, '2024-11-01 09:30:00'),
(30, 21.7590, 79.3090, 438.0, '2024-11-01 17:00:00'),
(30, 21.7570, 79.3060, 435.0, '2024-11-02 05:00:00'),
(30, 21.7600, 79.3110, 441.0, '2024-11-02 14:00:00'),

-- Maya (Tiger, Tadoba)
(33, 20.2200, 79.3360, 320.0, '2024-11-01 05:00:00'),
(33, 20.2230, 79.3390, 325.0, '2024-11-01 12:00:00'),
(33, 20.2180, 79.3330, 318.0, '2024-11-01 21:00:00'),
(33, 20.2160, 79.3300, 315.0, '2024-11-02 06:30:00'),

-- Waghdoh (Tiger, Tadoba)
(34, 20.2150, 79.3280, 310.0, '2024-11-01 04:30:00'),
(34, 20.2180, 79.3310, 312.0, '2024-11-01 11:00:00'),
(34, 20.2120, 79.3250, 308.0, '2024-11-01 20:30:00'),
(34, 20.2100, 79.3220, 305.0, '2024-11-02 07:00:00'),

-- Neela (Fishing Cat, Chilika)
(36, 19.7200, 85.3200, 5.0,   '2024-11-01 06:30:00'),
(36, 19.7220, 85.3230, 5.0,   '2024-11-01 19:00:00'),
(36, 19.7180, 85.3180, 4.0,   '2024-11-02 07:00:00'),

-- Sita (Lion-tailed Macaque, Silent Valley)
(40, 11.0820, 76.4720, 1200.0,'2024-11-01 07:00:00'),
(40, 11.0840, 76.4750, 1210.0,'2024-11-01 13:00:00'),
(40, 11.0800, 76.4690, 1195.0,'2024-11-02 08:30:00'),

-- Manas Tigress
(46, 26.6850, 91.0200, 95.0,  '2024-11-01 05:00:00'),
(46, 26.6880, 91.0230, 98.0,  '2024-11-01 11:30:00'),
(46, 26.6820, 91.0170, 92.0,  '2024-11-01 22:00:00'),
(46, 26.6800, 91.0140, 90.0,  '2024-11-02 06:00:00'),

-- Bon Bibi (Tiger, Sundarbans)
(50, 21.9520, 89.1860, 3.0,   '2024-11-01 05:30:00'),
(50, 21.9550, 89.1900, 3.0,   '2024-11-01 13:00:00'),
(50, 21.9490, 89.1830, 3.0,   '2024-11-01 21:00:00'),
(50, 21.9470, 89.1800, 4.0,   '2024-11-02 07:00:00'),

-- Dokkhin (Tiger, Sundarbans)
(51, 21.9480, 89.1780, 3.0,   '2024-11-01 04:00:00'),
(51, 21.9510, 89.1820, 3.0,   '2024-11-01 10:00:00'),
(51, 21.9460, 89.1750, 4.0,   '2024-11-01 19:30:00'),

-- Brahma (Rhino, Kaziranga)
(52, 26.6660, 93.3720, 78.0,  '2024-11-01 07:30:00'),
(52, 26.6690, 93.3760, 79.0,  '2024-11-01 14:00:00'),
(52, 26.6630, 93.3690, 77.0,  '2024-11-02 08:00:00'),
(52, 26.6610, 93.3660, 76.0,  '2024-11-02 16:00:00'),

-- Parvati (Rhino, Kaziranga)
(53, 26.6680, 93.3740, 78.0,  '2024-11-01 08:00:00'),
(53, 26.6700, 93.3770, 80.0,  '2024-11-01 15:00:00'),
(53, 26.6650, 93.3710, 77.0,  '2024-11-02 09:00:00'),

-- Paro (Tiger, Corbett)
(55, 29.5320, 78.7770, 410.0, '2024-11-01 05:00:00'),
(55, 29.5350, 78.7800, 415.0, '2024-11-01 11:30:00'),
(55, 29.5290, 78.7740, 408.0, '2024-11-01 20:00:00'),
(55, 29.5270, 78.7710, 405.0, '2024-11-02 06:30:00'),

-- Bhima (Elephant, Periyar)
(16, 9.4640,  77.2040, 920.0, '2024-11-01 08:00:00'),
(16, 9.4660,  77.2060, 925.0, '2024-11-01 16:00:00'),
(16, 9.4620,  77.2020, 918.0, '2024-11-02 09:00:00'),

-- Tusker (Elephant, Nagarhole)
(24, 12.0540, 76.1340, 782.0, '2024-11-01 07:00:00'),
(24, 12.0570, 76.1380, 788.0, '2024-11-01 15:00:00'),
(24, 12.0510, 76.1300, 778.0, '2024-11-02 08:00:00'),

-- Bagha (Tiger, Pench)
(31, 21.7640, 79.3140, 443.0, '2024-11-01 04:30:00'),
(31, 21.7670, 79.3170, 448.0, '2024-11-01 10:00:00'),
(31, 21.7610, 79.3110, 440.0, '2024-11-01 18:30:00'),

-- Manas Tusker (Elephant, Manas)
(47, 26.6860, 91.0220, 97.0,  '2024-11-01 06:00:00'),
(47, 26.6890, 91.0250, 100.0, '2024-11-01 14:00:00'),
(47, 26.6830, 91.0190, 94.0,  '2024-11-02 07:30:00');

-- ============================================
-- POACHING INCIDENTS (30 total)
-- ============================================

INSERT INTO poaching_incidents (habitat_id, reported_by, incident_date, description, severity, status, animals_affected) VALUES
-- Gir
(7,  7,  '2024-09-05', 'Cattle poisoning near pride territory, suspected retaliatory killing attempt', 'Critical', 'Under Investigation', 2),
(7,  7,  '2024-10-12', 'Snare traps discovered near water hole used by lion cubs', 'High', 'Resolved', 0),
(7,  7,  '2024-11-01', 'Unauthorized grazing encroachment in core lion habitat', 'Medium', 'Open', 0),

-- Periyar
(8,  8,  '2024-08-18', 'Elephant corridor blocked by illegal fencing, 3 elephants stranded', 'High', 'Resolved', 3),
(8,  8,  '2024-10-25', 'Rosewood logging detected in buffer zone, fresh stumps found', 'High', 'Under Investigation', 0),

-- Bandipur
(9,  9,  '2024-07-14', 'Night poaching attempt on gaur herd, torchlight spotted by patrol', 'Critical', 'Resolved', 0),
(9,  9,  '2024-09-30', 'Leopard snare found near rocky outcrops in buffer zone', 'High', 'Closed', 0),
(9,  9,  '2024-11-03', 'Forest fire of suspicious origin in eastern range', 'Critical', 'Open', 4),

-- Nagarhole
(10, 10, '2024-08-22', 'Ivory poachers tracked near Kabini river; two arrested', 'Critical', 'Resolved', 1),
(10, 10, '2024-10-07', 'Trap camera stolen from monitoring station', 'Low', 'Closed', 0),

-- Kanha
(11, 11, '2024-06-10', 'Tiger carcass found near meadow, suspected poisoning', 'Critical', 'Under Investigation', 1),
(11, 11, '2024-08-28', 'Illegal medicinal plant harvesting in core zone', 'Medium', 'Closed', 0),
(11, 11, '2024-10-15', 'Camera trap images show armed individuals in restricted area', 'High', 'Under Investigation', 0),

-- Pench
(12, 12, '2024-07-20', 'Dhole pack pursued by motorcycles into reserve boundary', 'Medium', 'Resolved', 0),
(12, 12, '2024-09-14', 'Tiger kill site disturbed, skin and bones removed', 'Critical', 'Open', 1),

-- Tadoba
(13, 13, '2024-05-30', 'Tigress Maya darted and GPS collar tampered with', 'Critical', 'Under Investigation', 1),
(13, 13, '2024-08-16', 'Bone crusher mill found near reserve boundary, wildlife remains inside', 'Critical', 'Resolved', 3),
(13, 13, '2024-10-28', 'Spotlighting activity near tiger corridor', 'High', 'Open', 0),

-- Chilika
(14, 14, '2024-03-08', 'Olive ridley nesting beach disturbed by illegal trawlers', 'Critical', 'Resolved', 12),
(14, 14, '2024-09-22', 'Fishing cat trapped by illegal crab net near lagoon', 'High', 'Resolved', 1),
(14, 14, '2024-11-05', 'Mass fishing with dynamite detected near bird nesting zone', 'Critical', 'Open', 6),

-- Bharatpur
(15, 15, '2024-04-11', 'Bird nests ransacked for eggs, migratory crane chicks taken', 'High', 'Resolved', 5),
(15, 15, '2024-10-19', 'Feral dog pack killing birds; origin traced to nearby village', 'Medium', 'Closed', 2),

-- Silent Valley
(16, 16, '2024-06-25', 'Lion-tailed macaque infant found in illegal pet trade network', 'Critical', 'Under Investigation', 1),
(16, 16, '2024-09-08', 'Nilgiri tahr poaching near upper grassland, horn fragments recovered', 'High', 'Under Investigation', 1),

-- Manas
(17, 17, '2024-05-05', 'Pygmy hog burrow destroyed by illegal cultivators', 'Critical', 'Under Investigation', 3),
(17, 17, '2024-07-31', 'Armed poachers crossed Nepal border into northern Manas', 'Critical', 'Open', 0),
(17, 17, '2024-10-12', 'Tiger pugmarks disappear; suspected wire trap area found', 'High', 'Open', 0),

-- Dibru-Saikhowa
(18, 18, '2024-08-09', 'Fishing cat found injured in gill net set in floodplain channel', 'High', 'Resolved', 1),
(18, 18, '2024-11-02', 'Timber floating operation detected inside national park boundary', 'High', 'Open', 0);

-- ============================================
-- PATROL LOGS (extended)
-- ============================================

INSERT INTO patrol_logs (ranger_id, habitat_id, patrol_date, start_time, end_time, area_covered_sqkm, observations, incident_found) VALUES
(7,  7,  '2024-11-01', '05:00:00', '13:00:00', 22.0, 'Akbar and Noor spotted near teak grove. Two sub-adults tracked.', FALSE),
(8,  8,  '2024-11-01', '06:00:00', '14:00:00', 18.5, 'Elephant herd of 9 near Periyar lake. No threats observed.', FALSE),
(9,  9,  '2024-11-01', '05:30:00', '12:30:00', 20.0, 'Tiger pugmarks near stream. Gaur herd counted at 12.', FALSE),
(10, 10, '2024-11-01', '06:00:00', '15:00:00', 28.0, 'Kabini tigress with two cubs confirmed. Tusker sighted at Kabini river.', FALSE),
(11, 11, '2024-11-01', '05:00:00', '13:00:00', 25.0, 'Munna tiger tracks across meadow. Suspicious tyre marks investigated.', TRUE),
(12, 12, '2024-11-01', '05:30:00', '14:00:00', 30.0, 'Collarwali and cubs active near Jamtara hide. Dhole pack heard.', FALSE),
(13, 13, '2024-11-01', '05:00:00', '13:30:00', 24.0, 'Maya and Waghdoh territories checked. No snares found.', FALSE),
(14, 14, '2024-11-01', '06:30:00', '14:00:00', 16.0, 'Fishing cat Neela spotted near inlet. Otter family of 5 near reeds.', FALSE),
(15, 15, '2024-11-01', '07:00:00', '12:00:00', 10.0, 'Migratory birds counted: 840 individuals, 23 species. All clear.', FALSE),
(16, 16, '2024-11-01', '07:00:00', '15:00:00', 14.0, 'Lion-tailed macaque troop of 22 active in canopy. Langur troop healthy.', FALSE),
(17, 17, '2024-11-01', '05:30:00', '14:00:00', 32.0, 'Manas tigress and pygmy hog burrow sites checked. All intact.', FALSE),
(18, 18, '2024-11-01', '06:00:00', '13:00:00', 20.0, 'Dibru otter tracks on sandbar. Fishing cat signs near channel.', FALSE),
(7,  7,  '2024-11-03', '05:00:00', '12:00:00', 20.0, 'Snare found near water hole. Removed immediately. Lion cubs unharmed.', TRUE),
(9,  9,  '2024-11-03', '05:00:00', '14:00:00', 26.0, 'Suspicious vehicle tracks found near fire zone. Reported to control room.', TRUE),
(11, 11, '2024-11-03', '05:30:00', '13:30:00', 22.0, 'Camera trap reviewed: armed intruder confirmed. Police notified.', TRUE);

INSERT INTO species (common_name, scientific_name, conservation_status, description) VALUES

-- ── INDIAN BIRDS ──
('Indian Peafowl',            'Pavo cristatus',               'Least Concern',         'National bird of India, iconic iridescent plumage'),
('Sarus Crane',               'Antigone antigone',            'Vulnerable',            'Worlds tallest flying bird, found in Indian wetlands'),
('Indian Roller',             'Coracias benghalensis',        'Least Concern',         'Brilliant blue bird, state bird of several Indian states'),
('Black-necked Stork',        'Ephippiorhynchus asiaticus',   'Near Threatened',       'Large wading bird found near Indian rivers and lakes'),
('Spot-billed Pelican',       'Pelecanus philippensis',       'Near Threatened',       'Colonial waterbird found in southern Indian wetlands'),
('Forest Owlet',              'Heteroglaux blewitti',         'Endangered',            'Critically rare owl rediscovered in 1997 in central India'),
('Jerdon\'s Courser',         'Rhinoptilus bitorquatus',      'Critically Endangered', 'Nocturnal bird known from only one site in Andhra Pradesh'),
('White-rumped Vulture',      'Gyps bengalensis',             'Critically Endangered', 'Critically endangered scavenger, decimated by diclofenac'),
('Red-headed Vulture',        'Sarcogyps calvus',             'Critically Endangered', 'Solitary vulture once common across Indian subcontinent'),

-- ── INDIAN REPTILES & MARINE ──
('Indian Star Tortoise',      'Geochelone elegans',           'Vulnerable',            'Ornate tortoise heavily trafficked in illegal pet trade'),
('King Cobra',                'Ophiophagus hannah',           'Vulnerable',            'World longest venomous snake, found in Indian forests'),
('Indian Softshell Turtle',   'Nilssonia gangetica',          'Vulnerable',            'Large freshwater turtle found in Ganga river system'),
('Hawksbill Sea Turtle',      'Eretmochelys imbricata',       'Critically Endangered', 'Critically endangered sea turtle targeted for its shell'),
('Saltwater Crocodile',       'Crocodylus porosus',           'Least Concern',         'Worlds largest living reptile, found in Andaman islands'),
('Dugong',                    'Dugong dugon',                 'Vulnerable',            'Marine herbivore found in Gulf of Mannar and Andamans'),

-- ── GLOBAL — AFRICA ──
('African Elephant',          'Loxodonta africana',           'Endangered',            'Worlds largest land animal, keystone species of African savanna'),
('Mountain Gorilla',          'Gorilla beringei beringei',    'Endangered',            'Great ape found in Virunga mountains, fewer than 1100 remain'),
('African Wild Dog',          'Lycaon pictus',                'Endangered',            'Highly social painted wolf, one of Africas most endangered carnivores'),
('Black Rhinoceros',          'Diceros bicornis',             'Critically Endangered', 'Critically endangered browser rhino, heavily poached for horn'),
('Cheetah',                   'Acinonyx jubatus',             'Vulnerable',            'Worlds fastest land animal, losing habitat rapidly'),
('Okapi',                     'Okapia johnstoni',             'Endangered',            'Elusive forest giraffe endemic to Democratic Republic of Congo'),
('Ethiopian Wolf',            'Canis simensis',               'Endangered',            'Worlds rarest canid, found only in Ethiopian highlands'),

-- ── GLOBAL — ASIA ──
('Amur Leopard',              'Panthera pardus orientalis',   'Critically Endangered', 'Rarest big cat on Earth, fewer than 100 in the wild'),
('Sumatran Orangutan',        'Pongo abelii',                 'Critically Endangered', 'Great ape found only in Sumatra, critically threatened by deforestation'),
('Irrawaddy Dolphin',         'Orcaella brevirostris',        'Endangered',            'Freshwater dolphin found in Southeast Asian rivers'),
('Philippine Eagle',          'Pithecophaga jefferyi',        'Critically Endangered', 'Worlds largest eagle by weight, endemic to Philippines'),
('Saiga Antelope',            'Saiga tatarica',               'Critically Endangered', 'Migratory antelope of Central Asia, suffered catastrophic die-offs'),

-- ── GLOBAL — AMERICAS ──
('Jaguar',                    'Panthera onca',                'Near Threatened',       'Largest cat in the Americas, apex predator of Amazon basin'),
('Giant Anteater',            'Myrmecophaga tridactyla',      'Vulnerable',            'Unique insectivore of South American grasslands'),
('Harpy Eagle',               'Harpia harpyja',               'Vulnerable',            'Powerful eagle of Amazon, apex aerial predator'),
('Giant Otter',               'Pteronura brasiliensis',       'Endangered',            'Worlds largest otter, found in Amazon river systems'),
('Andean Condor',             'Vultur gryphus',               'Vulnerable',            'Largest flying bird by wingspan, sacred in Andean cultures'),

-- ── GLOBAL — POLAR & MARINE ──
('Polar Bear',                'Ursus maritimus',              'Vulnerable',            'Arctic apex predator, icon of climate change impact'),
('Blue Whale',                'Balaenoptera musculus',        'Endangered',            'Largest animal ever to have lived on Earth'),
('Vaquita',                   'Phocoena sinus',               'Critically Endangered', 'Worlds most critically endangered marine mammal, fewer than 10 remain'),
('Leatherback Sea Turtle',    'Dermochelys coriacea',         'Vulnerable',            'Largest sea turtle, dives deeper than any other reptile');

-- ============================================
-- ANIMALS for new species
-- Species IDs: 24 (Indian Peafowl) → 57 (Leatherback)
-- Using existing habitats 1–18 where appropriate
-- New animals start at ID 57 (after existing 56)
-- ============================================
ALTER TABLE wildlife_db.animals MODIFY weight_kg DECIMAL(10,2);

INSERT INTO animals (name, species_id, habitat_id, gender, age_years, weight_kg, tag_number, health_status, notes) VALUES

-- Indian Birds (habitats: Kaziranga=2, Chilika=14, Bharatpur=15, Kanha=11)
('Mayur',        24, 15, 'Male',   3,   4.5,  'TAG-PF001', 'Healthy',         'Dominant peacock, Bharatpur grassland edge'),
('Saraswati',    25, 14, 'Female', 6,   7.8,  'TAG-SC001', 'Healthy',         'Sarus crane, nesting pair near Chilika inlet'),
('Kiran',        28, 14, 'Female', 2,   6.2,  'TAG-WRV001','Healthy',         'White-rumped vulture, tagged at Chilika colony'),
('Agni',         29, 15, 'Male',   4,   5.4,  'TAG-RHV001','Healthy',         'Red-headed vulture, lone individual at Bharatpur'),

-- Indian Reptiles & Marine
('Tara',         32, 2,  'Female', 18,  9.5,  'TAG-IST001','Healthy',         'Indian star tortoise, found in Kaziranga buffer'),
('Naaga',        33, 3,  'Male',   8,   7.2,  'TAG-KC001', 'Healthy',         'King cobra, tracked near Corbett stream'),
('Varuna',       35, 14, 'Female', 25,  68.0, 'TAG-HT001', 'Under Treatment', 'Hawksbill turtle, entangled in ghost net, recovering'),
('Krodha',       36, 1,  'Male',   30, 520.0, 'TAG-SC001', 'Healthy',         'Saltwater croc, Sundarbans tidal channel'),
('Samudra',      37, 14, 'Female', 12, 270.0, 'TAG-DG001', 'Healthy',         'Dugong, tagged near Gulf of Mannar seagrass bed'),

-- Africa (using Kanha=11 as proxy savanna, Tadoba=13 as forest)
('Tembo',        38, 11, 'Male',   22, 5800.0,'TAG-AE001', 'Healthy',         'African elephant bull — exchange program specimen data'),
('Silverback',   39, 13, 'Male',   18, 195.0, 'TAG-MG001', 'Healthy',         'Mountain gorilla silverback — reference tracking data'),
('Duma',         45, 11, 'Male',   4,   55.0, 'TAG-CH001', 'Healthy',         'Cheetah — coalition of 3 brothers, savanna reference'),
('Fisi',         40, 11, 'Female', 5,   28.0, 'TAG-AWD001','Healthy',         'African wild dog, alpha female of 8-member pack'),
('Kifaru',       41, 13, 'Male',   12,  900.0,'TAG-BR001', 'Critical',        'Black rhino — critically poached population data'),
('Simba',        44, 11, 'Male',   3,   45.0, 'TAG-ETW001','Healthy',         'Ethiopian wolf, high altitude grassland — reference'),

-- Asia
('Amur',         45, 5,  'Male',   6,   48.0, 'TAG-AL001', 'Healthy',         'Amur leopard — coldest habitat in Hemis proxy'),
('Borneo',       46, 16, 'Male',   12,  72.0, 'TAG-SO001', 'Healthy',         'Sumatran orangutan — Silent Valley rainforest proxy'),
('Irawadi',      47, 14, 'Female', 8,  115.0, 'TAG-ID001', 'Healthy',         'Irrawaddy dolphin — Chilika brackish lagoon'),
('Steppe',       49, 5,  'Female', 4,   35.0, 'TAG-SA001', 'Healthy',         'Saiga antelope — high altitude grassland proxy'),

-- Americas
('El Jefe',      50, 13, 'Male',   7,  105.0, 'TAG-JG001', 'Healthy',         'Jaguar — dense forest proxy, Tadoba'),
('Myra',         51, 2,  'Female', 5,   28.0, 'TAG-GA001', 'Healthy',         'Giant anteater — grassland proxy, Kaziranga'),
('Harpy',        52, 16, 'Male',   6,    7.8, 'TAG-HE001', 'Healthy',         'Harpy eagle — rainforest canopy, Silent Valley proxy'),
('Amazon',       53, 14, 'Female', 4,   22.0, 'TAG-GO001', 'Healthy',         'Giant otter — wetland proxy, Chilika'),

-- Polar & Marine
('Nanuq',        55, 5,  'Male',   8,  480.0, 'TAG-PB001', 'Healthy',         'Polar bear — high altitude cold proxy, Hemis'),
('Balaena',      56, 14, 'Female', 35,152000.0,'TAG-BW001','Healthy',         'Blue whale — marine reference, Chilika open sea'),
('Leatherback1', 58, 14, 'Female', 20,  680.0,'TAG-LT001', 'Healthy',         'Leatherback sea turtle — deep diving, nesting tracked');

-- ============================================
-- GPS LOGS for new animals
-- Animal IDs start at 57 (Mayur) based on
-- 10 original + 46 from dataset_extension = 56
-- ============================================

INSERT INTO gps_logs (animal_id, latitude, longitude, altitude_m, recorded_at) VALUES

-- Mayur (Peacock, Bharatpur - habitat 15)
(57, 27.1750, 77.5160, 180.0, '2024-12-01 06:00:00'),
(57, 27.1770, 77.5180, 182.0, '2024-12-01 12:00:00'),
(57, 27.1740, 77.5150, 179.0, '2024-12-02 07:00:00'),

-- Saraswati (Sarus Crane, Chilika - habitat 14)
(58, 19.7180, 85.3150, 4.0,   '2024-12-01 07:00:00'),
(58, 19.7200, 85.3180, 4.0,   '2024-12-01 14:00:00'),
(58, 19.7160, 85.3120, 3.0,   '2024-12-02 08:00:00'),
(58, 19.7140, 85.3100, 3.0,   '2024-12-02 16:00:00'),

-- Kiran (White-rumped Vulture, Chilika)
(59, 19.7220, 85.3220, 6.0,   '2024-12-01 08:00:00'),
(59, 19.7250, 85.3260, 8.0,   '2024-12-01 15:00:00'),
(59, 19.7190, 85.3200, 5.0,   '2024-12-02 09:00:00'),

-- Agni (Red-headed Vulture, Bharatpur)
(60, 27.1760, 77.5170, 185.0, '2024-12-01 07:30:00'),
(60, 27.1780, 77.5200, 188.0, '2024-12-01 13:00:00'),
(60, 27.1750, 77.5155, 183.0, '2024-12-02 08:30:00'),

-- Tara (Indian Star Tortoise, Kaziranga)
(61, 26.6650, 93.3710, 77.0,  '2024-12-01 09:00:00'),
(61, 26.6660, 93.3720, 77.0,  '2024-12-01 16:00:00'),
(61, 26.6640, 93.3700, 76.0,  '2024-12-02 10:00:00'),

-- Naaga (King Cobra, Corbett)
(62, 29.5310, 78.7760, 408.0, '2024-12-01 05:30:00'),
(62, 29.5330, 78.7785, 412.0, '2024-12-01 11:00:00'),
(62, 29.5295, 78.7740, 405.0, '2024-12-01 20:00:00'),
(62, 29.5280, 78.7720, 403.0, '2024-12-02 06:00:00'),

-- Varuna (Hawksbill Turtle, Chilika)
(63, 19.7100, 85.3050, 2.0,   '2024-12-01 10:00:00'),
(63, 19.7080, 85.3020, 1.0,   '2024-12-01 18:00:00'),
(63, 19.7120, 85.3080, 2.0,   '2024-12-02 11:00:00'),

-- Krodha (Saltwater Croc, Sundarbans)
(64, 21.9530, 89.1870, 2.0,   '2024-12-01 06:00:00'),
(64, 21.9560, 89.1910, 2.0,   '2024-12-01 14:00:00'),
(64, 21.9500, 89.1840, 2.0,   '2024-12-01 22:00:00'),
(64, 21.9480, 89.1810, 2.0,   '2024-12-02 07:00:00'),

-- Samudra (Dugong, Chilika)
(65, 19.7050, 85.2980, 3.0,   '2024-12-01 08:00:00'),
(65, 19.7020, 85.2950, 2.0,   '2024-12-01 16:00:00'),
(65, 19.7080, 85.3010, 3.0,   '2024-12-02 09:00:00'),

-- Tembo (African Elephant proxy, Kanha)
(66, 22.3420, 80.6160, 618.0, '2024-12-01 07:00:00'),
(66, 22.3450, 80.6200, 625.0, '2024-12-01 15:00:00'),
(66, 22.3390, 80.6130, 614.0, '2024-12-02 08:00:00'),
(66, 22.3370, 80.6110, 610.0, '2024-12-02 17:00:00'),

-- Silverback (Mountain Gorilla proxy, Tadoba)
(67, 20.2180, 79.3340, 318.0, '2024-12-01 07:30:00'),
(67, 20.2210, 79.3370, 322.0, '2024-12-01 13:00:00'),
(67, 20.2160, 79.3310, 315.0, '2024-12-02 08:30:00'),

-- Duma (Cheetah proxy, Kanha)
(68, 22.3380, 80.6120, 616.0, '2024-12-01 05:00:00'),
(68, 22.3410, 80.6155, 621.0, '2024-12-01 10:30:00'),
(68, 22.3360, 80.6095, 613.0, '2024-12-01 19:00:00'),
(68, 22.3340, 80.6070, 609.0, '2024-12-02 05:30:00'),

-- Fisi (African Wild Dog proxy, Kanha)
(69, 22.3400, 80.6145, 619.0, '2024-12-01 06:00:00'),
(69, 22.3430, 80.6180, 624.0, '2024-12-01 12:00:00'),
(69, 22.3375, 80.6115, 615.0, '2024-12-01 20:30:00'),

-- Kifaru (Black Rhino proxy, Tadoba)
(70, 20.2200, 79.3360, 320.0, '2024-12-01 08:00:00'),
(70, 20.2230, 79.3395, 326.0, '2024-12-01 15:00:00'),
(70, 20.2175, 79.3325, 314.0, '2024-12-02 09:00:00'),

-- Simba (Ethiopian Wolf proxy, Kanha)
(71, 22.3355, 80.6090, 612.0, '2024-12-01 06:30:00'),
(71, 22.3380, 80.6125, 617.0, '2024-12-01 13:30:00'),
(71, 22.3335, 80.6065, 608.0, '2024-12-02 07:00:00'),

-- Amur (Amur Leopard proxy, Hemis)
(72, 33.5020, 77.0020, 4190.0,'2024-12-01 07:00:00'),
(72, 33.5050, 77.0060, 4205.0,'2024-12-01 14:00:00'),
(72, 33.4990, 76.9990, 4180.0,'2024-12-02 08:00:00'),
(72, 33.4970, 76.9960, 4175.0,'2024-12-02 16:00:00'),

-- Borneo (Sumatran Orangutan proxy, Silent Valley)
(73, 11.0810, 76.4710, 1198.0,'2024-12-01 08:00:00'),
(73, 11.0835, 76.4740, 1208.0,'2024-12-01 14:30:00'),
(73, 11.0790, 76.4685, 1192.0,'2024-12-02 09:00:00'),

-- Irawadi (Irrawaddy Dolphin, Chilika)
(74, 19.7150, 85.3100, 2.0,   '2024-12-01 09:00:00'),
(74, 19.7180, 85.3140, 2.0,   '2024-12-01 17:00:00'),
(74, 19.7120, 85.3060, 1.0,   '2024-12-02 10:00:00'),
(74, 19.7100, 85.3030, 1.0,   '2024-12-02 18:00:00'),

-- Steppe (Saiga Antelope proxy, Hemis)
(75, 33.5030, 77.0040, 4195.0,'2024-12-01 07:30:00'),
(75, 33.5060, 77.0080, 4210.0,'2024-12-01 13:00:00'),
(75, 33.5000, 77.0010, 4185.0,'2024-12-02 08:30:00'),

-- El Jefe (Jaguar proxy, Tadoba)
(76, 20.2190, 79.3350, 319.0, '2024-12-01 04:30:00'),
(76, 20.2220, 79.3385, 324.0, '2024-12-01 10:00:00'),
(76, 20.2165, 79.3315, 313.0, '2024-12-01 21:00:00'),
(76, 20.2145, 79.3285, 308.0, '2024-12-02 05:00:00'),

-- Myra (Giant Anteater proxy, Kaziranga)
(77, 26.6670, 93.3730, 78.0,  '2024-12-01 08:30:00'),
(77, 26.6695, 93.3760, 80.0,  '2024-12-01 16:30:00'),
(77, 26.6645, 93.3700, 76.0,  '2024-12-02 09:30:00'),

-- Harpy (Harpy Eagle proxy, Silent Valley)
(78, 11.0825, 76.4730, 1205.0,'2024-12-01 09:30:00'),
(78, 11.0850, 76.4760, 1215.0,'2024-12-01 16:00:00'),
(78, 11.0800, 76.4700, 1196.0,'2024-12-02 10:30:00'),

-- Amazon (Giant Otter, Chilika)
(79, 19.7130, 85.3070, 3.0,   '2024-12-01 10:30:00'),
(79, 19.7110, 85.3040, 2.0,   '2024-12-01 18:30:00'),
(79, 19.7155, 85.3100, 3.0,   '2024-12-02 11:30:00'),

-- Nanuq (Polar Bear proxy, Hemis - cold/high altitude)
(80, 33.5040, 77.0050, 4200.0,'2024-12-01 06:00:00'),
(80, 33.5070, 77.0090, 4215.0,'2024-12-01 12:30:00'),
(80, 33.5010, 77.0020, 4188.0,'2024-12-02 07:30:00'),
(80, 33.4985, 76.9985, 4178.0,'2024-12-02 15:00:00'),

-- Balaena (Blue Whale, Chilika open water)
(81, 19.6950, 85.2800, 0.0,   '2024-12-01 11:00:00'),
(81, 19.6900, 85.2750, 0.0,   '2024-12-01 19:00:00'),
(81, 19.7000, 85.2850, 0.0,   '2024-12-02 12:00:00'),

-- Leatherback1 (Leatherback Turtle, Chilika)
(82, 19.7060, 85.2990, 1.0,   '2024-12-01 12:00:00'),
(82, 19.7030, 85.2960, 0.0,   '2024-12-01 20:00:00'),
(82, 19.7090, 85.3020, 1.0,   '2024-12-02 13:00:00');
