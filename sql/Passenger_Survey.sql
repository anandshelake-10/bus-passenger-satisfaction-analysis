-- ============================================================
-- Passenger Survey Analysis (MySQL)
-- Data: data/Passenger_Survey_Anonymized.csv  (104 respondents)
-- ============================================================
-- SETUP
-- 1) Run the next two lines.
-- 2) Import the CSV with MySQL Workbench:
--    right-click the google_form schema > Table Data Import Wizard >
--    choose data/Passenger_Survey_Anonymized.csv > new table: passenger_survey
-- Column names are already cleaned in the CSV, so no ALTER TABLE rename
-- step is needed.

CREATE DATABASE IF NOT EXISTS google_form;
USE google_form;

SELECT * FROM passenger_survey;
SELECT COUNT(Respondent_ID) AS Total_Respondents FROM passenger_survey;

-- ============================================================
-- AREAS OF IMPROVEMENT
-- ============================================================

-- Passengers who rated bus condition Poor / Very Poor
SELECT Respondent_ID, Gender, Bus_Condition
FROM Passenger_Survey
WHERE Bus_Condition IN ('Poor', 'Very Poor');

-- Passengers who rated punctuality Poor / Very Poor
SELECT Respondent_ID, Gender, Punctuality
FROM Passenger_Survey
WHERE Punctuality IN ('Poor', 'Very Poor');

-- Count of Poor / Very Poor staff behaviour ratings
SELECT COUNT(Staff_Behavior) AS Poor_Staff_Ratings
FROM Passenger_Survey
WHERE Staff_Behavior IN ('Poor', 'Very Poor');

-- Passengers who rated staff behaviour Poor / Very Poor
SELECT Respondent_ID, Gender, Staff_Behavior
FROM Passenger_Survey
WHERE Staff_Behavior IN ('Poor', 'Very Poor');

-- Count of passengers reporting frequent overcrowding
SELECT COUNT(Overcrowded) AS Frequent_Overcrowding
FROM Passenger_Survey
WHERE Overcrowded IN ('Often', 'Always');

-- ============================================================
-- ONLINE BOOKING PREFERENCE
-- ============================================================
SELECT Online_Booking_Preference, COUNT(*) AS Total_Respondents
FROM Passenger_Survey
GROUP BY Online_Booking_Preference;

-- ============================================================
-- MOST PREFERRED TRAVEL TIME
-- ============================================================
SELECT Time_preference, COUNT(Time_preference) AS Total_Count
FROM Passenger_Survey
GROUP BY Time_preference
ORDER BY Total_Count DESC;

-- ============================================================
-- RESPONDENTS BY AGE GROUP
-- ============================================================
SELECT Age,
       COUNT(Age) AS Respondent_Count,
       COUNT(Age) * 100.0 / (SELECT COUNT(Age) FROM Passenger_Survey) AS Percentage
FROM Passenger_Survey
GROUP BY Age;

-- ============================================================
-- MOST USED PAYMENT METHOD
-- ============================================================
SELECT Way_of_payment, COUNT(*) AS Total_Users
FROM Passenger_Survey
GROUP BY Way_of_payment
ORDER BY Total_Users DESC;

-- ============================================================
-- FACTORS INFLUENCING TRAVEL CHOICE
-- ============================================================
SELECT Factor_influence, COUNT(*) AS Total_Respondents
FROM Passenger_Survey
GROUP BY Factor_influence
ORDER BY Total_Respondents DESC;

-- ============================================================
-- OVERALL SATISFACTION
-- ============================================================
SELECT Overall_Satisfaction,
       COUNT(*) AS Total_Respondents,
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Passenger_Survey) AS Percentage
FROM Passenger_Survey
GROUP BY Overall_Satisfaction
ORDER BY Percentage DESC;
