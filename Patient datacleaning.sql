--Data cleaning

SELECT * FROM hospital_dataset.patients;

--Check for duplicates
--standardize the dataset
--Remove any unwanted columns/rows


CREATE TABLE patient_dataset
LIKE patients;


SELECT * FROM hospital_dataset.patient_dataset;



INSERT INTO patient_dataset
SELECT * FROM patients;


---Check for duplicates


SELECT *,ROW_NUMBER() OVER(PARTITION BY ï»¿Id,`FIRST`,`LAST`,BIRTHDATE,DEATHDATE,BIRTHPLACE) AS row_num
FROM patient_dataset;


WITH duplicate_dataset AS (
SELECT *,ROW_NUMBER() OVER(PARTITION BY ï»¿Id,`FIRST`,`LAST`,BIRTHDATE,DEATHDATE,BIRTHPLACE) AS row_num
FROM patient_dataset)
SELECT *
FROM duplicate_dataset
WHERE row_num>1;



--standardize data

SELECT 
  `FIRST`,`LAST`,MAIDEN,
  REGEXP_SUBSTR(`FIRST`, '^[A-Za-z]+') AS first_name,
  REGEXP_SUBSTR(`LAST`, '^[A-Za-z]+') AS Last_name,
  REGEXP_SUBSTR(MAIDEN, '^[A-Za-z]+') AS maiden_name
FROM patient_dataset;



UPDATE patient_dataset
SET `FIRST`= REGEXP_SUBSTR(`FIRST`, '^[A-Za-z]+'),
`LAST`=REGEXP_SUBSTR(`LAST`, '^[A-Za-z]+'),
  MAIDEN=REGEXP_SUBSTR(MAIDEN, '^[A-Za-z]+');



SELECT BIRTHDATE,DATE_FORMAT(BIRTHDATE,'%Y-%m-%d')
FROM patient_dataset;


SELECT DEATHDATE,DATE_FORMAT(DEATHDATE,'%Y-%m-%d')
FROM patient_dataset;


UPDATE patient_dataset
SET DEATHDATE=DATE_FORMAT(DEATHDATE,'%Y-%m-%d');

ALTER TABLE patient_dataset
MODIFY BIRTHDATE DATE;

ALTER TABLE patient_dataset
MODIFY DEATHDATE DATE;

--Remove any unwanted columns/rows


ALTER TABLE patient_dataset
DROP COLUMN LAT;

ALTER TABLE patient_dataset
DROP COLUMN LON;


SELECT *
FROM patient_dataset;

