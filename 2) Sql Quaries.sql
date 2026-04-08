Create database if not exists health_care;
use health_care;
select * from doctor;
SELECT * FROM labresult;
SELECT * FROM patient;
SELECT * FROM treatments;
SELECT * FROM visit;
DROP table healthcare;

----- TOTAL PATIENT ---------

SELECT DISTINCT(COUNT(Patient_ID)) AS Total_patient
FROM patient;

------ TOTAL DOCTOR ---------
SELECT DISTINCT(COUNT(`Doctor ID`)) AS Total_Doctor
FROM Doctor;

--------- TOTAL VISIT --------
SELECT DISTINCT(COUNT('Visit ID')) AS Total_Visit
FROM visit;

-------- AVERAGE AGE ---------------
SELECT ROUND(AVG(Age),0) AS AVG_AGE 
FROM patient;

-------------- TOP 5 DIAGNOSED CONDITIONS ---------
SELECT Diagnosis AS Diagnosed_Conditions, count(Diagnosis) AS Diagnose_Count
FROM visit
GROUP BY Diagnosis
LIMIT 5;
------- FOLLOW UP RATE  ------------

SELECT 
	ROUND(
        (SUM(CASE 
                WHEN `Follow Up Required` = 'Yes' THEN 1 
                ELSE 0 
             END) 
        / COUNT(*)) * 100, 2
    ) AS follow_up_rate_percentage
FROM Visit;

 -------- AVERAGE TREATMENT COST --------- 
SELECT 
	CONCAT("$",ROUND(
		AVG(`Treatment Cost`),2)) 
        AS AVG_Treatment_cost_Per_visit
FROM treatments;

------------ TOTAL LAB RESULT ----------------
SELECT COUNT(`Lab Result ID`) AS Total_lab_Test
FROM labresult;

----------------- PERCENTAGE OF ABNORMAL LAB RESULT ------------------- 
SELECT 
	CONCAT(ROUND(                                                       # Concat fun will add the value #         
     (SUM(CASE                                                                  
     WHEN `Test Result` = 'Abnormal' THEN 1 ELSE 0 END) / COUNT(*)) *100,2),"%") AS ABnormal_test_result
FROM labresult;

--------- DOCTOR WORKLOAD-------
SELECT d.`Doctor ID`,
	   d.`Doctor Name`,
COUNT(DISTINCT v.`Patient ID`) AS Unique_patients
FROM visit v 
JOIN doctor d 
ON 
d. `Doctor ID` = v. `Doctor ID`
GROUP BY `Doctor ID`,`Doctor Name`
ORDER BY unique_patients;

------ OR --------- 
SELECT 
    ROUND(
        (SELECT COUNT(*) FROM Visit) 
        / 
        (SELECT COUNT(*) FROM Doctor)
    ,2) AS doctor_workload;


-------------- TOTAL REVENUE --------------------
SELECT CONCAT("$",ROUND(SUM(`Treatment Cost`+Cost)/1000000,2),"M") AS Total_Revenue
FROM treatments;

