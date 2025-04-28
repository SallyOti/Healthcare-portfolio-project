--Exploratory Data Analysis

SELECT *
FROM patient_dataset;


SELECT COUNT(*) AS num_deaths,YEAR(DEATHDATE) as death_year
FROM patient_dataset
WHERE YEAR(DEATHDATE) IS NOT NULL
GROUP BY YEAR(DEATHDATE);


SELECT patient_dataset.`ï»¿Id`,ENCOUNTERCLASS,`START`,ENCOUNTERCLASS
FROM patient_dataset JOIN encounters ON patient_dataset.`ï»¿Id`=encounters.PATIENT;


SELECT COUNT(*) AS Total_patient,ENCOUNTERCLASS
FROM encounters
GROUP BY ENCOUNTERCLASS;


SELECT PATIENT,COUNT(*) AS num_timeforsame_procedure,`CODE`,`DESCRIPTION`
FROM procedures
GROUP BY PATIENT,`CODE`,`DESCRIPTION`
ORDER BY 2;


SELECT PATIENT,SUM(BASE_COST) AS total_cost_onprocedue,`description`
FROM procedures
GROUP BY PATIENT,`description`
ORDER BY 2 DESC;


SELECT DISTINCT encounters.patient,CONCAT(patient_dataset.`FIRST`," ",patient_dataset.`LAST`) AS Full_name,payers.`NAME`
FROM encounters JOIN payers ON encounters.PAYER=payers.ï»¿Id JOIN patient_dataset ON encounters.patient=patient_dataset.ï»¿Id;



SELECT DISTINCT COUNT(encounters.patient) AS totalpatient_inthis_insurance,payers.`NAME`
FROM encounters JOIN payers ON encounters.PAYER=payers.ï»¿Id JOIN patient_dataset ON encounters.patient=patient_dataset.ï»¿Id
GROUP BY payers.`NAME`;


SELECT DISTINCT encounters.patient
FROM encounters JOIN payers ON encounters.PAYER=payers.ï»¿Id
WHERE payers.ï»¿Id IS NULL;


SELECT PATIENT,SUM(TOTAL_CLAIM_COST), SUM(PAYER_COVERAGE),(SUM(TOTAL_CLAIM_COST)-SUM(PAYER_COVERAGE)) AS paid_patient
FROM encounters
GROUP BY PATIENT;


SELECT DISTINCT encounters.patient,CONCAT(patient_dataset.`FIRST`," ",patient_dataset.`LAST`) AS Full_name,payers.`NAME`AS insurance_name,SUM(PAYER_COVERAGE) as Insurance_paid,SUM(TOTAL_CLAIM_COST)-SUM(PAYER_COVERAGE) AS paid_by_patient
FROM encounters JOIN payers ON encounters.PAYER=payers.ï»¿Id JOIN patient_dataset ON encounters.patient=patient_dataset.ï»¿Id
GROUP BY ENCOUNTERS.PATIENT,Full_name,payers.`NAME`
ORDER BY Insurance_paid desc;

SELECT DISTINCT`NAME`,ENCOUNTERCLASS,
CASE WHEN PAYER_COVERAGE=0 THEN 'Not paid' ELSE 'paid' END AS Insurance_cover
FROM encounters JOIN payers ON encounters.PAYER=payers.ï»¿Id
ORDER BY 1,3 DESC;


CREATE VIEW Insurance_coverage AS (SELECT DISTINCT`NAME`,ENCOUNTERCLASS,
CASE WHEN PAYER_COVERAGE=0 THEN 'Not paid' ELSE 'paid' END AS Insurance_cover
FROM encounters JOIN payers ON encounters.PAYER=payers.ï»¿Id
ORDER BY 1,3 DESC);



CREATE VIEW Insurance_VS_patient AS (SELECT DISTINCT COUNT(encounters.patient) AS totalpatient_inthis_insurance,payers.`NAME`
FROM encounters JOIN payers ON encounters.PAYER=payers.ï»¿Id JOIN patient_dataset ON encounters.patient=patient_dataset.ï»¿Id
GROUP BY payers.`NAME`);



CREATE VIEW totalpatient_encounter AS SELECT COUNT(*) AS Total_patient,ENCOUNTERCLASS
FROM encounters
GROUP BY ENCOUNTERCLASS;


CREATE VIEW total_yearly_deaths AS SELECT COUNT(*) AS num_deaths,YEAR(DEATHDATE) as death_year
FROM patient_dataset
WHERE YEAR(DEATHDATE) IS NOT NULL
GROUP BY YEAR(DEATHDATE);

