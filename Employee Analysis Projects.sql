create database Bhardwajpvt_ltd;
use Bhardwajpvt_ltd;
desc company;
create table employee (id int primary key,
Name varchar(50) not null,
Age int,
Email varchar(100),
JoinDate Date ,
Salary int,
Department varchar(50),
Isactive varchar(50),
Lastlogin date,
Score int );
select * from employee;
-- Q1 Write a query to display all employee details.
select * from employee;
-- Retrieve Name and Email of all employees.
select name,email from employee;
-- Show employees whose Age is greater than 30.
select * from employee where age>30;
-- Get employees who work in Finance department.
select * from employee where department='Finance';
-- Display employees with Salary greater than 60,000.
select * from employee where salary>60000;
-- List employees who are Active (IsActive = TRUE).
select * from employee where IsActive = 'TRUE';
-- Show names of employees who joined in 2022.
select name,joindate from employee where year(joindate)='2022';
-- Get employee details sorted by Salary descending. 
select * from employee order by salary desc;
--  Display unique departments.
Select distinct(Department) from employee;
-- Find the employee with highest salary 
Select * from employee order by salary desc limit 1;
-- Count total number of employees. 
select count(*) from employee;
-- Count how many active & inactive employees. 
select count(isactive),isactive from employee group by isactive;
-- Find average salary of all employees.
select avg(salary) from employee ; 
-- Find total employees in each department.
Select count(id),department from employee group by department;
--  Find the minimum and maximum age per department.
select max(age) as max_age ,min(age) as min_age,department from employee group by department; 
-- Retrieve employees whose Score ≥ 85.
select * from employee where score>=85;
-- Show employees who logged in after ‘2024-09-01’.
select id,name,lastlogin from employee where lastlogin >'2024-09-01';
-- Get employees with both Age > 30 AND Salary > 60,000.
select id,name,age,salary from employee where age>30 and salary>60000;
-- Display employees who joined before 2021.
select id,name,joindate from employee where year(joindate) < '2021';  
-- List employees who have NOT logged in in the last 5 days (based on LastLogin).
SELECT * FROM employee WHERE LastLogin < DATE_SUB(CURDATE(), INTERVAL 5 DAY);
-- Find top 3 highest paid employees.
select id,name,salary from employee order by salary desc limit 3 ;
-- Show department-wise average score.
select department,avg(score) from employee  group by department;
-- Find the youngest employee in each department. 
select min(age),department from employee group by department;

-- List employees whose name contains “a”.
select id,name from employee where name like "%a%";  
--  Retrieve employees whose email domain is example.com
 select id,name,email from employee where email like "%.com";  
 -- Find employees who are active but have salary below department average.
SELECT c.id, c.name, c.department, c.salary,c.isactive
FROM employee c
JOIN (
    SELECT department, AVG(salary) AS dept_avg_salary
    FROM employee
    GROUP BY department
) d
ON c.department = d.department
WHERE c.isactive = 'True'
  AND c.salary < d.dept_avg_salary;
  
  --  Rank employees by salary using ROW_NUMBER() window function.
SELECT name, department, salary,
ROW_NUMBER() OVER (ORDER BY salary DESC) AS salary_rank
FROM employee;

-- Rank employees inside each department using RANK()
SELECT name, department, salary,
RANK() OVER (
    PARTITION BY department
    ORDER BY salary DESC
) AS department_rank
FROM employee;
-- Calculate employee experience in years from JoinDate
SELECT name, joindate, TIMESTAMPDIFF(YEAR, joindate, CURDATE()) AS experience_years FROM employee;
-- Write a query to mask emails like:john.doe@example.com → j*****e@example.com
SELECT email,
CONCAT(
    LEFT(email,1),
    '*****',
    SUBSTRING_INDEX(SUBSTRING_INDEX(email,'@',1),'.',-1),
    '@',
    SUBSTRING_INDEX(email,'@',-1)
) AS masked_email
FROM employee;
-- Find percentage of active employees department-wise
SELECT department,
ROUND(SUM(CASE WHEN isactive = TRUE THEN 1 ELSE 0 END)* 100.0 / COUNT(*),2
) AS active_percentage FROM employee GROUP BY department;
-- Performance category using CASE
SELECT name,department,salary,score,
       CASE
           WHEN score >= 85 THEN 'High'
           WHEN score >= 70 THEN 'Medium'
           ELSE 'Low'
       END AS performance_category
FROM employee; 
-- Employees who joined in last 2 years
SELECT * FROM employee
WHERE joindate >= CURDATE() - INTERVAL 2 YEAR;
-- Compare employee salary with department average
SELECT name,department,salary,
       (SELECT AVG(salary)
           FROM employee c2
           WHERE c2.department = c1.department
       ) AS department_avg_salary
FROM employee c1;
-- Identify Departments where average score > 85
SELECT department,
       AVG(score) AS avg_score
FROM employee
GROUP BY department
HAVING AVG(score) > 85; 

