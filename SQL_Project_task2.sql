select * from locations;
select * from departments;
select * from jobs;
select * from employees;
select * from job_history;
select * from regions;
select * from countries;


-- Find all the departments where employees are tagged to it.
select distinct dep.department_id,dep.department_name
from employees emp
inner join departments dep
on emp.department_id = dep.department_id;


-- Find employee details who belongs to marketing department and has salary less then or equal to 6000
-- and working as 'Marketing Representative'.
select * 
from employees
where department_id = 
(
select department_id 
from departments
where department_name = 'Marketing'
)
and job_id = 
(
select job_id 
from jobs
where job_title = 'Marketing Representative'
)
and salary <= 60000;

-- List down only those employees along with department name and city where city is 'Roma' or 'Venice' or 'Southlake'.
select emp.employee_id, emp.first_name,dep.department_name,loc.city
from employees emp
left join departments dep
on emp.department_id=dep.department_id
left join locations loc
on dep.location_id = loc.location_id
and city in ('Roma','Venice','Southlake')
order by emp.employee_id;

-- Find max salary of an employee.
select max(salary) as 'Max_Salary'
from employees;

-- List down the employees who are getting maximum salary.
select * from employees
where salary =
(select max(salary)
from employees);

-- List down the employees who are getting minimum salary.
select * from employees
where salary=
(select min(salary) from employees);

-- Find total salary given to employees.
select sum(salary) as "Total_Salary" from employees;

-- Find average salary of employees.
select round(avg(salary),2) as "Avg_Salary" from employees;

-- List down the employees who are getting more than average salary.
select * from employees
where salary>
(select round(avg(salary),2) as "Avg_Salary" from employees);

-- Find total number of employees.
select count(*) from employees;

-- Find maximum salary and number of employees who are working in IT department and hired after 29-Nov-1990.
select max(salary) as "Max_Salary", count(*) as "Total_Employees"
from employees
where department_id=
(select department_id
from departments
where department_name="IT")
and hire_date > str_to_date('1990-11-29','yyyy-mm-dd');

-- Show department wise number of employees, maximum salary
select dep.department_name, max(salary) as "Max_Salary",count(*)
from employees emp
inner join departments dep
on emp.department_id=dep.department_id
group by dep.department_name
order by dep.department_name;

-- Show location wise number of department
select loc.city,count(*) as "Number_of_Department"
from departments dep ,locations loc
where loc.location_id=dep.location_id
group by loc.city
order by loc.city;

-- Show number of employees working under each manager along with manager's employee id
select m.employee_id as "Manager_id",concat(m.first_name,' ',m.last_name) as "Manager_Name",
count(*) as "Number of_employee_working_Under"
from employees e
inner join employees m
on e.employee_id=m.employee_id
group by m.employee_id;

-- Show department wise resignation number in an ordered way
select jobhis.department_id,dep.department_name,
count(*) as "Number_of_employee_resigned"
from job_history jobhis
inner join departments dep
on jobhis.department_id=dep.department_id
group by jobhis.department_id,dep.department_name
having count(*)>1
order by Number_of_employee_resigned desc;

-- Find all the employees who has resigned.
select * from employees emp
where exists(select emp.job_id from job_history jobhis where emp.job_id= jobhis.job_id);

