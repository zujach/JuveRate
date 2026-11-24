PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

WITH program_scen(miasto, festiwal, scena, miejsce) AS (
    VALUES
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Polibuda PK', 'Dawne lotnisko Rakowice-Czyżyny, ul. Skarżyńskiego'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', 'Miasteczko Studenckie AGH, ul. Józefa Rostafińskiego 7a'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', 'Scena plenerowa przed Klubem Studenckim Żaczek, al. 3 Maja 5'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Zielone AKF', 'Kampus AKF, al. Jana Pawła II 78'),
    ('Kraków', 'jUKENalia', 'Scena koncertowa', 'Stadion WKS Wawel, ul. Podchorążych 3'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', 'Miasteczko Akademickie Politechniki Rzeszowskiej'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', 'Miasteczko Akademickie Politechniki Rzeszowskiej'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', 'Miasteczko Akademickie Politechniki Rzeszowskiej'),
    ('Wrocław', 'Juwenalia Wrocławskie', 'Duża Scena', 'Pola Osobowickie'),
    ('Wrocław', 'Juwenalia #WrocławRazem', 'Scena Główna', 'Tereny zielone przy Tarczyński Arena Wrocław'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', 'Park Jana Pawła II'),
    ('Lublin', 'Lublinalia', 'Scena Główna', 'Tereny zielone Browaru Perła, ul. Bernardyńska 15')
)
INSERT INTO festiwale (nazwa, rok, miasto)
SELECT DISTINCT festiwal, 2026, miasto
FROM program_scen
WHERE 1
ON CONFLICT(nazwa, rok, miasto) DO NOTHING;

WITH program_scen(miasto, festiwal, scena, miejsce) AS (
    VALUES
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Polibuda PK', 'Dawne lotnisko Rakowice-Czyżyny, ul. Skarżyńskiego'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', 'Miasteczko Studenckie AGH, ul. Józefa Rostafińskiego 7a'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', 'Scena plenerowa przed Klubem Studenckim Żaczek, al. 3 Maja 5'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Zielone AKF', 'Kampus AKF, al. Jana Pawła II 78'),
    ('Kraków', 'jUKENalia', 'Scena koncertowa', 'Stadion WKS Wawel, ul. Podchorążych 3'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', 'Miasteczko Akademickie Politechniki Rzeszowskiej'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', 'Miasteczko Akademickie Politechniki Rzeszowskiej'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', 'Miasteczko Akademickie Politechniki Rzeszowskiej'),
    ('Wrocław', 'Juwenalia Wrocławskie', 'Duża Scena', 'Pola Osobowickie'),
    ('Wrocław', 'Juwenalia #WrocławRazem', 'Scena Główna', 'Tereny zielone przy Tarczyński Arena Wrocław'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', 'Park Jana Pawła II'),
    ('Lublin', 'Lublinalia', 'Scena Główna', 'Tereny zielone Browaru Perła, ul. Bernardyńska 15')
)
INSERT INTO sceny (festiwal_id, nazwa, miejsce)
SELECT f.id, p.scena, p.miejsce
FROM program_scen p
JOIN festiwale f ON f.nazwa = p.festiwal AND f.miasto = p.miasto AND f.rok = 2026
WHERE 1
ON CONFLICT(festiwal_id, nazwa) DO NOTHING;

CREATE TEMP TABLE juverate_import_2026 (
    miasto TEXT NOT NULL,
    festiwal TEXT NOT NULL,
    scena TEXT NOT NULL,
    data_koncertu TEXT NOT NULL,
    godzina TEXT NOT NULL,
    artysta TEXT NOT NULL
);

INSERT INTO juverate_import_2026 (miasto, festiwal, scena, data_koncertu, godzina, artysta)
VALUES
    -- Kraków / Juwenalia Krakoskie / Strefa Polibuda PK
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Polibuda PK', '2026-05-15', '17:20', 'Lotta'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Polibuda PK', '2026-05-15', '18:10', 'Łydka Grubasa'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Polibuda PK', '2026-05-15', '19:30', 'Lordofon'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Polibuda PK', '2026-05-15', '21:05', 'Strachy na Lachy'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Polibuda PK', '2026-05-15', '23:00', 'Ich Troje'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Polibuda PK', '2026-05-16', '18:30', 'Asster'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Polibuda PK', '2026-05-16', '19:00', 'Gruby Mielzky'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Polibuda PK', '2026-05-16', '19:50', 'Słoń'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Polibuda PK', '2026-05-16', '21:10', 'Guzior'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Polibuda PK', '2026-05-16', '22:30', 'Żabson'),
    -- Kraków / Juwenalia Krakoskie / Strefa Plaża AGH
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-20', '18:00', 'BSK'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-20', '18:50', 'Zalia'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-20', '20:05', 'Hubert.'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-20', '21:45', 'Kukon'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-20', '23:15', 'Jan-rapowanie'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-21', '18:00', 'Skolim'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-21', '18:50', 'Daj To Głośniej'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-21', '20:10', 'Big Cyc'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-21', '21:30', 'Nocny Kochanek'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-21', '23:20', 'Bracia Figo Fagot'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-22', '18:00', 'Metro'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-22', '19:15', 'LemON'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-22', '22:45', 'Tommy Cash'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-23', '17:30', 'Con Fuoco AGH'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-23', '18:15', 'Orkiestra Reprezentacyjna AGH'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-23', '19:10', 'Golec uOrkiestra'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-23', '20:40', 'Dżem'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Plaża AGH', '2026-05-23', '22:40', 'Pidżama Porno'),
    -- Kraków / Juwenalia Krakoskie / Strefa Żaczek UJ
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-13', '19:00', 'Dezydery'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-13', '20:30', 'Wojtek Szumański'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-13', '22:10', 'ReTo'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-13', '23:15', 'Modelki'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-14', '19:00', 'Miły ATZ'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-14', '20:15', 'CatchUp'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-14', '21:45', 'Kosma Król / Kania / Krzaqu'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-14', '23:15', 'Kacperczyk'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-15', '19:00', 'Nautofon'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-15', '20:15', 'Tymek'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-15', '21:30', 'Sarius x Pawbeats'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-15', '23:00', 'Chivas'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-16', '19:00', 'Miętha'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-16', '20:30', 'Fisz Emade Tworzywo'),
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Żaczek UJ', '2026-05-16', '22:30', 'Happysad'),
    -- Kraków / Juwenalia Krakoskie / Strefa Zielone AKF
    ('Kraków', 'Juwenalia Krakoskie', 'Strefa Zielone AKF', '2026-05-13', '22:00', 'Baciary'),
    -- Kraków / jUKENalia / Scena koncertowa
    ('Kraków', 'jUKENalia', 'Scena koncertowa', '2026-05-29', '18:00', 'Wojciech Baranowski'),
    ('Kraków', 'jUKENalia', 'Scena koncertowa', '2026-05-29', '19:30', 'Major SPZ'),
    ('Kraków', 'jUKENalia', 'Scena koncertowa', '2026-05-29', '20:30', 'Paluch'),
    ('Kraków', 'jUKENalia', 'Scena koncertowa', '2026-05-29', '21:45', 'Kali'),
    ('Kraków', 'jUKENalia', 'Scena koncertowa', '2026-05-29', '23:00', 'Fukaj'),
    -- Rzeszów / Rzeszowskie Juwenalia / Scena Główna PRz
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', '2026-05-08', '18:00', 'Enej'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', '2026-05-08', '19:30', 'Bass Astral'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', '2026-05-08', '20:40', 'Strachy na Lachy'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', '2026-05-08', '22:15', 'Lady Pank'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', '2026-05-08', '23:50', 'Kacperczyk'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', '2026-05-09', '01:05', 'Bracia Figo Fagot'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', '2026-05-09', '18:00', 'Bletka'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', '2026-05-09', '19:15', 'Tom Pigment'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', '2026-05-09', '20:05', 'Maryla Rodowicz'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', '2026-05-09', '21:45', 'Dżem'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', '2026-05-09', '23:40', 'Nocny Kochanek'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Główna PRz', '2026-05-10', '01:05', 'Myslovitz'),
    -- Rzeszów / Rzeszowskie Juwenalia / Scena Brend
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-08', '17:30', 'MIÜ'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-08', '19:00', 'Malik Montana'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-08', '20:30', 'Pezet'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-08', '22:00', 'Kizo'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-08', '23:15', 'Żabson'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-09', '00:45', 'White 2115'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-09', '17:30', 'Zippy Ogar'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-09', '18:25', 'Jacob Crucian'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-09', '19:05', 'Sentino'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-09', '20:05', 'Rów Babicze'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-09', '21:25', 'Bambi'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-09', '22:55', 'PRO8L3M'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Brend', '2026-05-10', '00:25', 'Gibbs'),
    -- Rzeszów / Rzeszowskie Juwenalia / Scena Bunkier
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', '2026-05-08', '19:30', 'BajorSon'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', '2026-05-08', '20:45', 'Baciary'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', '2026-05-08', '22:00', 'Skolim'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', '2026-05-08', '23:15', 'Chwytak & DJ Wiktor & Zuza'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', '2026-05-09', '00:15', 'DJ Killer'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', '2026-05-09', '01:15', 'DJ AVI'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', '2026-05-09', '19:30', 'Majki'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', '2026-05-09', '20:45', 'Zenon Martyniuk'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', '2026-05-09', '21:50', 'Cypis'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', '2026-05-09', '22:30', 'Aptekarze'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', '2026-05-10', '00:15', 'DJ Akun'),
    ('Rzeszów', 'Rzeszowskie Juwenalia', 'Scena Bunkier', '2026-05-10', '01:15', 'DJ AVI'),
    -- Wrocław / Juwenalia Wrocławskie / Duża Scena
    ('Wrocław', 'Juwenalia Wrocławskie', 'Duża Scena', '2026-05-08', '16:15', 'Słysz'),
    ('Wrocław', 'Juwenalia Wrocławskie', 'Duża Scena', '2026-05-08', '17:40', 'O.S.T.R.'),
    ('Wrocław', 'Juwenalia Wrocławskie', 'Duża Scena', '2026-05-08', '18:45', 'Ewelina Lisowska'),
    ('Wrocław', 'Juwenalia Wrocławskie', 'Duża Scena', '2026-05-08', '21:05', 'Zeamsone'),
    ('Wrocław', 'Juwenalia Wrocławskie', 'Duża Scena', '2026-05-08', '22:10', 'Modelki'),
    ('Wrocław', 'Juwenalia Wrocławskie', 'Duża Scena', '2026-05-09', '16:45', 'HBI'),
    ('Wrocław', 'Juwenalia Wrocławskie', 'Duża Scena', '2026-05-09', '17:35', 'Video'),
    ('Wrocław', 'Juwenalia Wrocławskie', 'Duża Scena', '2026-05-09', '19:00', 'BSK'),
    ('Wrocław', 'Juwenalia Wrocławskie', 'Duża Scena', '2026-05-09', '20:50', 'Fukaj'),
    ('Wrocław', 'Juwenalia Wrocławskie', 'Duża Scena', '2026-05-09', '22:00', 'Malik Montana'),
    -- Wrocław / Juwenalia #WrocławRazem / Scena Główna
    ('Wrocław', 'Juwenalia #WrocławRazem', 'Scena Główna', '2026-05-20', '16:40', 'Lor'),
    ('Wrocław', 'Juwenalia #WrocławRazem', 'Scena Główna', '2026-05-20', '18:00', 'WaluśKraksaKryzys'),
    ('Wrocław', 'Juwenalia #WrocławRazem', 'Scena Główna', '2026-05-20', '19:20', 'Guzior'),
    ('Wrocław', 'Juwenalia #WrocławRazem', 'Scena Główna', '2026-05-20', '20:30', 'LemON'),
    ('Wrocław', 'Juwenalia #WrocławRazem', 'Scena Główna', '2026-05-20', '22:00', 'Białas'),
    ('Wrocław', 'Juwenalia #WrocławRazem', 'Scena Główna', '2026-05-21', '17:30', 'Pull The Wire'),
    ('Wrocław', 'Juwenalia #WrocławRazem', 'Scena Główna', '2026-05-21', '19:00', 'Kasia Lins'),
    ('Wrocław', 'Juwenalia #WrocławRazem', 'Scena Główna', '2026-05-21', '20:30', 'Happysad'),
    ('Wrocław', 'Juwenalia #WrocławRazem', 'Scena Główna', '2026-05-21', '22:00', 'Chivas'),
    -- Poznań / Juwenalia Poznań / Duża Scena
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', '2026-05-28', '19:00', 'Sowa'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', '2026-05-28', '21:15', 'Kosma Król'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', '2026-05-28', '22:00', 'Natura 2000'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', '2026-05-28', '22:30', 'Jan-rapowanie'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', '2026-05-29', '19:15', 'Color Blue'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', '2026-05-29', '20:45', 'Zalia'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', '2026-05-29', '22:15', 'Golec uOrkiestra'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', '2026-05-30', '00:00', 'Grubson'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', '2026-05-30', '19:00', 'NLT'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', '2026-05-30', '21:00', 'Hubert.'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', '2026-05-30', '22:30', 'Kacperczyk'),
    ('Poznań', 'Juwenalia Poznań', 'Duża Scena', '2026-05-30', '23:45', 'White 2115'),
    -- Lublin / Lublinalia / Scena Główna
    ('Lublin', 'Lublinalia', 'Scena Główna', '2026-05-15', '16:15', 'Dziewidły'),
    ('Lublin', 'Lublinalia', 'Scena Główna', '2026-05-15', '17:45', 'Oskar Cyms'),
    ('Lublin', 'Lublinalia', 'Scena Główna', '2026-05-15', '19:15', 'T.Love'),
    ('Lublin', 'Lublinalia', 'Scena Główna', '2026-05-15', '20:45', 'Zalia'),
    ('Lublin', 'Lublinalia', 'Scena Główna', '2026-05-15', '22:15', 'Grubson'),
    ('Lublin', 'Lublinalia', 'Scena Główna', '2026-05-15', '23:45', 'Kuqe 2115'),
    ('Lublin', 'Lublinalia', 'Scena Główna', '2026-05-16', '16:15', 'Eryk Moczko'),
    ('Lublin', 'Lublinalia', 'Scena Główna', '2026-05-16', '17:45', 'Tymek'),
    ('Lublin', 'Lublinalia', 'Scena Główna', '2026-05-16', '19:15', 'MIÜ'),
    ('Lublin', 'Lublinalia', 'Scena Główna', '2026-05-16', '20:45', 'Smolasty'),
    ('Lublin', 'Lublinalia', 'Scena Główna', '2026-05-16', '22:15', 'Kukon'),
    ('Lublin', 'Lublinalia', 'Scena Główna', '2026-05-16', '23:45', 'Modelki');

INSERT INTO artysci (nazwa)
SELECT DISTINCT artysta
FROM juverate_import_2026
WHERE 1
ON CONFLICT(nazwa) DO NOTHING;

INSERT INTO koncerty (artysta_id, scena_id, data_koncertu, godzina)
SELECT a.id, s.id, p.data_koncertu, p.godzina
FROM juverate_import_2026 p
JOIN festiwale f ON f.nazwa = p.festiwal AND f.miasto = p.miasto AND f.rok = 2026
JOIN sceny s ON s.festiwal_id = f.id AND s.nazwa = p.scena
JOIN artysci a ON a.nazwa = p.artysta
WHERE 1
ON CONFLICT(artysta_id, scena_id, data_koncertu, godzina) DO NOTHING;

DROP TABLE temp.juverate_import_2026;
COMMIT;
