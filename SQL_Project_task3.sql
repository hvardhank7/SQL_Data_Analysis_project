select * from locations;
select * from departments;
select * from jobs;
select * from employees;
select * from job_history;
select * from regions;
select * from countries;


-- country wise number of records and state
select country_id,count(*),count(state_province)
from locations
group by country_id
order by country_id;

-- Find department wise number of managers and number of records.
select dep.department_name, count(*) as  "Total_Record", count(emp.manager_id) as "Number_of_Manager"
from employees emp
inner join departments dep
on emp.department_id= dep.department_id
group by dep.department_name;

-- Categorize employees based on hire date
/*
1. before 1990
2. between 1990 to 1995
3. between 1995 to 2000
4. after 90s
*/

select concat(first_name,' ',last_name), hire_date,
case
	WHEN HIRE_DATE < STR_TO_DATE('01-JAN-1990', 'dd-MON-yyyy')
  THEN 'BEFORE 1990'
  WHEN HIRE_DATE >= STR_TO_DATE('01-JAN-1990', 'dd-MON-yyyy') AND HIRE_DATE < STR_TO_DATE('01-JAN-1995', 'dd-MON-yyyy')
  THEN 'BETWEEN 1990 TO 1995'
  WHEN HIRE_DATE >= STR_TO_DATE('01-JAN-1995', 'dd-MON-yyyy') AND HIRE_DATE < STR_TO_DATE('01-JAN-2000', 'dd-MON-yyyy')
  THEN 'BETWEEN 1995 TO 2000'
  WHEN HIRE_DATE >= STR_TO_DATE('01-JAN-2000', 'dd-MON-yyyy') 
  THEN 'AFTER 90s'
  ELSE
    'NOT CATEGORIZED'
END HIRE_CATEGORY
FROM EMPLOYEES
ORDER BY HIRE_DATE;


-- Find all the employee whose salary is more than the average salary of all employees. 
with avg_sal as 
( select avg(salary) as "Avg_Salary"
from employees)
select emp.employee_id,salary,Avg_Salary
from employees emp, avg_sal 
where emp.salary > avg_sal.Avg_Salary;


-- Find all the departments where the total salary of all employee in that department is more than the average of total salary of all employees in the database. 
with dep_wise_total_sal as
(
select department_id,sum(salary) as "Total_Salary"
from employees
group by department_id
),
average_sal as 
(
select avg(salary) as "Average_Salary"
from employees
)
select *
from dep_wise_total_sal, average_sal
where dep_wise_total_sal.Total_Salary > average_sal.Average_Salary;


