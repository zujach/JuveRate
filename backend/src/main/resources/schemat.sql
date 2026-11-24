CREATE TABLE IF NOT EXISTS uzytkownicy (
                                           id INTEGER PRIMARY KEY,
                                           email TEXT NOT NULL COLLATE NOCASE UNIQUE,
                                           haslo_hash TEXT NOT NULL,
                                           rola TEXT NOT NULL DEFAULT 'uzytkownik'
                                           CHECK (rola IN ('uzytkownik', 'administrator')),
    zablokowany INTEGER NOT NULL DEFAULT 0 CHECK (zablokowany IN (0, 1)),
    utworzono TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE IF NOT EXISTS festiwale (
                                         id INTEGER PRIMARY KEY,
                                         nazwa TEXT NOT NULL COLLATE NOCASE,
                                         rok INTEGER NOT NULL CHECK (typeof(rok) = 'integer' AND rok BETWEEN 1900 AND 9999),
    miasto TEXT NOT NULL COLLATE NOCASE,
    UNIQUE (nazwa, rok, miasto)
    );

CREATE TABLE IF NOT EXISTS sceny (
                                     id INTEGER PRIMARY KEY,
                                     festiwal_id INTEGER NOT NULL REFERENCES festiwale(id),
    nazwa TEXT NOT NULL,
    miejsce TEXT NOT NULL,
    UNIQUE (festiwal_id, nazwa)
    );

CREATE TABLE IF NOT EXISTS artysci (
                                       id INTEGER PRIMARY KEY,
                                       nazwa TEXT NOT NULL COLLATE NOCASE UNIQUE
);

CREATE TABLE IF NOT EXISTS koncerty (
                                        id INTEGER PRIMARY KEY,
                                        artysta_id INTEGER NOT NULL REFERENCES artysci(id),
    scena_id INTEGER NOT NULL REFERENCES sceny(id),
    data_koncertu TEXT NOT NULL CHECK (date(data_koncertu, '+0 days') IS data_koncertu),
    godzina TEXT NOT NULL CHECK (
                                    godzina GLOB '[0-2][0-9]:[0-5][0-9]' AND godzina < '24:00'
                                ),
    opis TEXT NOT NULL DEFAULT '',
    UNIQUE (artysta_id, scena_id, data_koncertu, godzina)
    );

CREATE TABLE IF NOT EXISTS recenzje (
                                        id INTEGER PRIMARY KEY,
                                        koncert_id INTEGER NOT NULL REFERENCES koncerty(id) ON DELETE CASCADE,
    uzytkownik_id INTEGER NOT NULL REFERENCES uzytkownicy(id),
    tresc TEXT NOT NULL CHECK (length(trim(tresc)) > 0),
    ocena_wystepu INTEGER NOT NULL CHECK (
                                             typeof(ocena_wystepu) = 'integer' AND ocena_wystepu BETWEEN 1 AND 5
    ),
    ocena_naglosnienia INTEGER NOT NULL CHECK (
                                                  typeof(ocena_naglosnienia) = 'integer' AND ocena_naglosnienia BETWEEN 1 AND 5
    ),
    ocena_atmosfery INTEGER NOT NULL CHECK (
                                               typeof(ocena_atmosfery) = 'integer' AND ocena_atmosfery BETWEEN 1 AND 5
    ),
    widoczna INTEGER NOT NULL DEFAULT 1 CHECK (widoczna IN (0, 1)),
    utworzono TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (koncert_id, uzytkownik_id)
    );

CREATE TABLE IF NOT EXISTS zdjecia (
                                       id INTEGER PRIMARY KEY,
                                       recenzja_id INTEGER NOT NULL REFERENCES recenzje(id) ON DELETE CASCADE,
    klucz_pliku TEXT NOT NULL UNIQUE,
    widoczne INTEGER NOT NULL DEFAULT 1 CHECK (widoczne IN (0, 1))
    );

CREATE TABLE IF NOT EXISTS zgloszenia (
                                          id INTEGER PRIMARY KEY,
                                          zglaszajacy_id INTEGER NOT NULL REFERENCES uzytkownicy(id),
    recenzja_id INTEGER REFERENCES recenzje(id) ON DELETE CASCADE,
    zdjecie_id INTEGER REFERENCES zdjecia(id) ON DELETE CASCADE,
    powod TEXT NOT NULL CHECK (length(trim(powod)) > 0),
    status TEXT NOT NULL DEFAULT 'otwarte'
    CHECK (status IN ('otwarte', 'pozostawiono', 'usunieto')),
    utworzono TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK ((recenzja_id IS NULL) <> (zdjecie_id IS NULL))
    );

CREATE INDEX IF NOT EXISTS idx_koncerty_scena ON koncerty(scena_id);
CREATE INDEX IF NOT EXISTS idx_koncerty_data ON koncerty(data_koncertu, godzina);
CREATE INDEX IF NOT EXISTS idx_recenzje_uzytkownik ON recenzje(uzytkownik_id);
CREATE INDEX IF NOT EXISTS idx_zdjecia_recenzja ON zdjecia(recenzja_id);
CREATE INDEX IF NOT EXISTS idx_zgloszenia_recenzja ON zgloszenia(recenzja_id);
CREATE INDEX IF NOT EXISTS idx_zgloszenia_zdjecie ON zgloszenia(zdjecie_id);

CREATE VIEW IF NOT EXISTS katalog_koncertow AS
SELECT k.id, a.nazwa AS artysta, s.nazwa AS scena, s.miejsce,
       f.rok, f.nazwa AS festiwal, f.miasto,
       k.data_koncertu, k.godzina, k.opis,
       COALESCE(o.liczba_recenzji, 0) AS liczba_recenzji,
       o.srednia_ocena
FROM koncerty k
         JOIN artysci a ON a.id = k.artysta_id
         JOIN sceny s ON s.id = k.scena_id
         JOIN festiwale f ON f.id = s.festiwal_id
         LEFT JOIN (
    SELECT koncert_id,
           COUNT(*) AS liczba_recenzji,
           AVG((ocena_wystepu + ocena_naglosnienia + ocena_atmosfery) / 3.0) AS srednia_ocena
    FROM recenzje
    WHERE widoczna = 1
    GROUP BY koncert_id
) o ON o.koncert_id = k.id;