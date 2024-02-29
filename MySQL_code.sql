-- creata database
CREATE DATABASE olympicsdataset;

USE olympicsdataset;

-- create table for Olympic_Athlete_Event_Results.csv (renamed columns edition_id to olympic_id and country_noc to noc)
CREATE TABLE olymathl (
    edition VARCHAR(255),
    olympic_id INT,
    noc VARCHAR(3),
    sport VARCHAR(255),
    event VARCHAR(255),
    result_id INT,
    athlete VARCHAR(255),
    athlete_id INT,
    pos VARCHAR(255),
    medal VARCHAR(10),
    isTeamSport BOOLEAN
);

LOAD DATA INFILE '/path/to/your/Olympic_Athlete_Event_Results.csv'
INTO TABLE olymathl
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(edition, olympic_id, noc, sport, event, result_id, athlete, athlete_id, pos, medal, @isTeamSport)
SET isTeamSport = CASE WHEN @isTeamSport = 'True' THEN 1 ELSE 0 END;

-- drop columns that won't be used in our visualizations
ALTER TABLE olymathl
DROP COLUMN result_id,
DROP COLUMN pos;

-- delete the 1956 Equestrian Olympics and 1906  Intercalated Games rows, as they won't be used in our visualizations
DELETE FROM olymathl
WHERE edition = '1956 Equestrian Olympics';

DELETE FROM olymathl
WHERE edition = '1906  Intercalated Games';

-- add a new column named Year (will get data from the edition column)
ALTER TABLE olymathl
ADD COLUMN Year INT;

-- update the Year column based on the first four characters of the edition column
UPDATE olymathl
SET Year = SUBSTRING(edition, 1, 4); 

-- add a new column named Season (will get data from the edition column)
ALTER TABLE olymathl
ADD COLUMN Season VARCHAR(10); 

-- update the Season column based on the contents of the edition column
UPDATE olymathl
SET Season =
    CASE
        WHEN edition LIKE '%Summer%' THEN 'Summer'
        WHEN edition LIKE '%Winter%' THEN 'Winter'
        ELSE NULL
    END;

-- add a new column named sex (will get data from the event column)
ALTER TABLE olymathl
ADD COLUMN sex VARCHAR(10);

-- update the sex column based on the contents of the event column
UPDATE olymathl
SET sex =
    CASE
        WHEN event LIKE '%, Men%' THEN 'M'
        WHEN event LIKE '%, Women%' THEN 'W'
        WHEN event LIKE '%Mixed%' OR event LIKE '%Open%' THEN 'Mix/Open'
        ELSE NULL
    END;

-- check for nulls before dropping the edition and event columns
SELECT COUNT(*)
FROM olymathl
WHERE Year IS NULL;

SELECT COUNT(*)
FROM olymathl
WHERE Season IS NULL;

SELECT COUNT(*)
FROM olymathl
WHERE Sex IS NULL;   -- gave 326 null rows, because there are some 'Boys'  entries

-- delete rows where the event was Boys
DELETE FROM olymathl
WHERE event LIKE '%, Boys%';

-- drop the edition column
ALTER TABLE olymathl
DROP COLUMN edition;

-- drop the event column
ALTER TABLE olymathl
DROP COLUMN event;

-- rename sports and athlete names that contain special characters to avoid conflicts
UPDATE olymathl
SET sport = 'Glima'
WHERE sport = 'Glíma';

UPDATE olymathl
SET sport = 'Pesapallo'
WHERE sport = 'Pesäpallo';

UPDATE olymathl
SET athlete = REPLACE(REPLACE(REPLACE(athlete, '\\', ' '), '-', ' '), ',', ' ');


-- check some entries of our final olymathl table
SELECT * FROM olymathl
limit 50;


-- backup point - cmd


-- create table for Olympic_Games_Medal_Tally.csv (renamed columns edition_id to olympic_id and country_noc to noc)
CREATE TABLE olymedals (
    edition VARCHAR(255),
    olympic_id INT,
    year INT,
    country VARCHAR(255),
    noc VARCHAR(3),
    gold INT,
    silver INT,
    bronze INT,
    total INT
);

LOAD DATA INFILE '/path/to/your/Olympic_Games_Medal_Tally.csv'
INTO TABLE olymedals
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- delete the 1956 Equestrian and 1906 Intercalated rows, as they won't be used in our visualizations
DELETE FROM olymedals
WHERE edition = '1956 Equestrian';

DELETE FROM olymedals
WHERE edition = '1906 Intercalated';

-- add a new column named Season (will get data from the edition column)
ALTER TABLE olymedals
ADD COLUMN Season VARCHAR(10); 

-- update the Season column based on the contents of the edition column
UPDATE olymedals
SET Season =
    CASE
        WHEN edition LIKE '%Summer%' THEN 'Summer'
        WHEN edition LIKE '%Winter%' THEN 'Winter'
        ELSE NULL
    END;

-- check for nulls before dropping the edition column
SELECT COUNT(*)
FROM olymedals
WHERE Season IS NULL;

-- drop the edition column
ALTER TABLE olymedals
DROP COLUMN edition;

-- rename countries that contain special or extra characters to avoid conflicts
UPDATE olymedals
SET country = 'Turkey'
WHERE noc = 'TUR';

UPDATE olymedals
SET country = 'Cote d Ivoire'
WHERE noc = 'CIV';

UPDATE olymedals
SET country = 'Hong Kong'
WHERE noc = 'HKG';

UPDATE olymedals
SET country = 'Russian Olympic Committee'
WHERE noc = 'ROC';

-- check some entries of our final olymathl table
SELECT * FROM olymedals
limit 50;




-- create table for Olympics_Country.csv (renamed country_noc to noc)
CREATE TABLE olymcountry (
    noc VARCHAR(3),
    country VARCHAR(255)
);

LOAD DATA INFILE '/path/to/your/Olympic_Country.csv'
INTO TABLE olymcountry
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- check our olymcountry table before backing up and moving to tableau
SELECT * FROM olymcountry;


-- final backup - cmd


-- export tables to csv


-- OlympicAthletes.csv
SELECT 'Olympic_ID', 'NOC', 'Sport', 'Athlete', 'Athlete_ID', 'Medal', 'TeamSport', 'Year', 'Season', 'Sex'
UNION ALL
SELECT *
FROM olymathl
INTO OUTFILE '/path/to/your/OlympicAthletes.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';


-- OlympicMedals.csv
SELECT 'Olympic_ID', 'Year', 'Country', 'NOC', 'Gold', 'Silver', 'Bronze', 'Total', 'Season'
UNION ALL
SELECT *
FROM olymedals
INTO OUTFILE '/path/to/your/OlympicMedals.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';


-- OlympicCountries.csv
SELECT 'NOC', 'Country'
UNION ALL
SELECT *
FROM olymcountry
INTO OUTFILE '/path/to/your/OlympicCountries.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';



-- export smaller csvs' to help with visualizations

-- this is used to export UniqueNOCbyOlympicID.csv for a Country-wise Participation Analysis
SELECT olympic_id, Year, Season, COUNT(DISTINCT NOC) AS UniqueNOCcount
FROM olymathl
GROUP BY olympic_id, Year, Season;



-- this is used to export TopAthletesbyMedalCount.csv for a Top 10 Athletes Analysis
SELECT olympic_id,athlete,Medals, Year, Season
FROM (
    SELECT olympic_id, athlete, Medals, Year, Season,
           @row_number := IF(@current_olympic_id = olympic_id, @row_number + 1, 1) AS athlete_rank,
           @current_olympic_id := olympic_id AS dummy
    FROM (
        SELECT olympic_id, athlete, Year, Season, COUNT(*) AS Medals
        FROM olymathl
        WHERE medal IN ('Gold', 'Silver', 'Bronze')
        GROUP BY olympic_id, athlete, Year, Season
        ORDER BY olympic_id, Medals DESC
    ) AS ranked_athletes,
    (SELECT @row_number := 0, @current_olympic_id := '') AS vars
) AS ranked
WHERE athlete_rank <= 10;
