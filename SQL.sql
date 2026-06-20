
create database hr_analytics;
use hr_analytics;
create table HR(
Age int(5),
Attrition varchar(5),
BusinessTravel varchar(20),
DailyRate int(10),
Department varchar(100),
DistanceFromHome int(5),
Education int(5),
EducationField varchar(20),
EmployeeCount int(5),
EmployeeNumber int(5),
EnvironmentSatisfaction int(5),
Gender varchar(6),
HourlyRate int(5),
Joblnvolvement int(5),
JobLevel int(5),
JobRole varchar(100),
JobSatisfaction int(5),
MaritalStatus varchar(10),
EmployeeID int(20),
MonthlyIncome int(10),
MonthlyRate int(10),
NumCompaniesWorked int(5),
Over18 char(2),
OverTime char(3),
PercentSalaryHike int(5),
PerformanceRating int(5),
RelationshipSatisfaction int(5),
StandardHours int(5),
StockOptionLevel int(2),
TotalWorkingYears int(5),
TrainingTimesLastYear int(5),
WorkLifeBalance int(5),
YearsAtCompany int(5),
YearsInCurrentRole int(5),
YearsSinceLastPromotion int(5),
YearsWithCurrManager int(5)
);
drop database hr_analytics;
describe hr;
select * from hr;

LOAD DATA LOCAL INFILE 'C:/Users/Vipul/Downloads/HR Analytics-20260512T084205Z-3-001 (1)/HR Analytics/HR_1.csv'
INTO TABLE hr
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# 1 Average Attrition Rate for all Departments
SELECT 
    Department AS Row_Labels,
    SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS No,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Yes,
    COUNT(*) AS Grand_Total,
    ROUND(
        AVG(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100, 
        2
    ) AS Average_attrition_rate
FROM HR
GROUP BY Department;

# 2 Average Hourly rate of Male Research Scientist
SHOW DATABASES;

SHOW COLUMNS FROM HR;

SELECT AVG(HourlyRate) AS Avg_HourlyRate_Of_Male_Research_Scientist
FROM HR
WHERE Gender = 'Male'
AND JobRole = 'Research Scientist';

# 4 KPI Average Working years for each Department
USE hr;
SELECT 
    Department,
    COUNT(*) AS Total_Employees,
    ROUND(AVG(TotalWorkingYears), 2) AS Avg_Working_Years
FROM HR
GROUP BY Department
ORDER BY Avg_Working_Years DESC;

# 5 Job Role vs Work Life Balance
create database hranalytics;
use hranalytics;

select * from hr_analytics;
select jobRole,
 round(avg(worklifebalance),2) as avg_worklifebalance
 from hr_analytics
 group by jobrole
 order by avg_worklifebalance desc;


# 6 Attrition Rate vs Year Since last Promotion relation
USE hr;
SELECT 
    YearsSinceLastPromotion,
    COUNT(*) AS TotalEmployees,
    SUM(
        CASE 
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS AttritionCount,
    ROUND(
        SUM(
            CASE 
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS AttritionRate
FROM HR
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;