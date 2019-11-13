CREATE TABLE aktive_lizenzen (
  last_name text,
  first_name text,
  sex text,
  yob integer,
  nationality text,
  uci_id text,
  region text,
  club text,
  team text,
  category_uci text,
  category_national text,
  issue_date date,
  valid_for_year integer,
  PRIMARY KEY (uci_id, category_national, valid_for_year)
);

CREATE TABLE racetype_groups ( id serial PRIMARY KEY, name text, UNIQUE (name));

INSERT INTO racetype_groups (name) VALUES
('Straße'),
('MTB'),
('Bahn'),
('Paracycling'),
('Querfeldein');

CREATE TABLE racetypes (
  id serial primary key,
  name text,
  racetype_group_id integer references racetype_groups (id),
  UNIQUE (name, racetype_group_id)
);

INSERT INTO racetypes (name, racetype_group_id) VALUES
('Straße', 1),
('Einzelzeitfahren', 1),
('Paarzeitfahren', 1),
('Teamzeitfahren', 1),
('Berg', 1),
('Kriterium', 1),
('Straße MH2', 4),
('Straße MB Tandem', 4),
('Straße WB Tandem', 4),
('Zeitfahren C4', 4),
('Zeitfahren MH2', 4),
('Zeitfahren Tandem Men', 4),
('Zeitfahren Tandem Mixed', 4),
('XCO', 2),
('Omnium', 3),
('Punkterennen', 3),
('Scratch', 3),
('Temporennen', 3),
('Ausscheidungsrennen', 3),
('Einzelverfolgung', 3),
('Sprint', 3),
('Keirin', 3),
('Zeitfahren', 3),
('Querfeldein', 5);
('Straße MH4', 4);
('Zeitfahren MB', 4);
('Zeitfahren WB', 4);
('Zeitfahren MC5', 4);
('MTB Marathon', 2);
('XCE', 2);


CREATE TABLE race_results (
  id SERIAL primary key,
  rider_id text not null,
  pos integer not null,
  racetype_id integer references racetypes(id),
  category_national text not null,
  raceday_date date,
  raceday_year integer not null,
  race_url text,
  race_name text,
  race_longname text,
  FOREIGN KEY ( rider_id, category_national, raceday_year ) REFERENCES aktive_lizenzen ( uci_id, category_national, valid_for_year )
);

COMMENT ON COLUMN race_results.race_name IS 'Short title of the race. E.g. "LM-Wien Bahn Scratch WE"';
COMMENT ON COLUMN race_results.race_longname IS 'Descriptive long title of the race. E.g. "42. Grafenbacher Radsporttage"';
