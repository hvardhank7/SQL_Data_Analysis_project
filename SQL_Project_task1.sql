select * from locations;
select * from departments;
select * from jobs;
select * from employees;
select * from job_history;
select * from regions;
select * from countries;

-- Find department details under postal code 98199.
select dep.department_id,dep.department_name, dep.manager_id,dep.location_id
from departments dep
inner join locations loc
on dep.location_id = loc.location_id
and
postal_code='98199';

-- Find department details which does not belong to postal code 98199.
select dep.department_id,dep.department_name, dep.manager_id,dep.location_id
from departments dep
inner join locations loc
on dep.location_id = loc.location_id
and
postal_code <> '98199';

-- find the employees details whose salary is more than 10000
select * from employees
where salary>10000;

-- Find employee details who belongs to marketing department and has salary less then or equal to 6000.
select emp.* from employees emp
inner join departments dep
on emp.department_id = dep.department_id
and
department_name='Marketing'
and
salary <= 6000;

-- Find employees details where commission pct is available.
select * from employees 
where commission_pct is not null;

-- Find employee details where manager is not available.
select * from employees
where manager_id is null;

-- List down employee name in ascending order.
select concat(first_name,' ',last_name) as 'Full_Name' from employees;

-- Find locations of UK country in ascending order of postal code.
select * from locations
where country_id='UK'
order by postal_code;

-- Find all the locations and arrange country in ascending and city in descending order.
SELECT * 
FROM LOCATIONS
ORDER BY COUNTRY_ID ASC, CITY DESC;

-- Find employees who work as President, Administration Vice President and Administration Assistant.
select first_name,last_name,email,job_id from employees
where job_id in
(SELECT job_id 
FROM JOBS 
WHERE JOB_TITLE IN ('President', 'Administration Vice President' ,'Administration Assistant'
));

-- Find employees who does not work as Finance Manager, Accountant and Shipping Clerk.
select first_name,last_name,email,job_id from employees
where job_id in
(SELECT job_id 
FROM JOBS 
WHERE JOB_TITLE IN ('Finance Manager', 'Accountant ','Shipping Clerk'
));

-- Find employees whose job id starts with AD.
select first_name,last_name,email,job_id from employees
where job_id like 'AD%';

-- Find all the employees whose job id does not starts with SA
select first_name,last_name,email,job_id
from employees
where job_id not like 'SA%';

-- Find all the employees whose job id neither starts with SA or SH
select first_name,last_name,email,job_id
from employees
where job_id not like 'SA%' 
and job_id not like 'SH%';

-- Find all the locations which starts with S
select * from locations
where city like 'S%';

-- Find all the locations where street address has Rd in it.
select * from locations
where street_address like '%Rd%';

-- Update COMMISSION_PCT to 0 where COMMISSION_PCT is not available.
update employees
set COMMISSION_PCT =0
where COMMISSION_PCT is null;

select * from employees;




