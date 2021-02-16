-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
--Use the Diagram db app to manipulate date and assign keys
-- export as postgres into VS Code
-- copy/paste into pgAdmin4

--DROP TABLE IF EXISTS Dept_Emp;

CREATE TABLE "Departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY ("dept_no")
);

CREATE TABLE "Title" (
    "title_id" varchar   NOT NULL,
    "title" varchar   NOT NULL,
    CONSTRAINT "pk_Title" PRIMARY KEY ("title_id")
);

CREATE TABLE "Employees" (
    "emp_no" varchar   NOT NULL,
    "emp_title_id" varchar   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY ("emp_no")
);

CREATE TABLE "Salaries" (
    "emp_no" varchar   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY ("emp_no")
);

--Can you rename table without drop? Due to import- DO NOT DROP
CREATE TABLE dept_emp (
	emp_no varchar   NOT NULL,    
	dept_no VARCHAR   NOT NULL,    
	PRIMARY KEY (emp_no, dept_no)
);
drop table "Dept_Manager";

--Dept_manager is a composite table where dept_no & emp_no are primary keys. emp_no goes to employee_table while dept_no goes to deptartments table
CREATE TABLE "Dept_Manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" varchar   NOT NULL,
	PRIMARY KEY (dept_no, emp_no)
);

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_Dept_Emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

--Run each line to see the imported data
-- Need  assign as alias. Not required
SELECT * FROM "Departments"
SELECT * FROM "Title"
SELECT * FROM "Employees"
SELECT * FROM "Salaries"
SELECT * FROM dept_emp
SELECT * FROM "Dept_Manager"

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
select "Employees".emp_no as employee_number from "Employees"

select "Employees".last_name as last_name from "Employees"

select "Employees".first_name as first_name from "Employees"

select "Employees".sex as sex from "Employees"
/*
--Create a view of salary information with employee number:
Create view salary as
--select "Employees".*, "Salaries".*
select "Employees".emp_no, "Salaries".salary as salary
from "Employees" 
join "Salaries" 
on "Salaries".emp_no="Employees".emp_no
--use first letter alias:
drop view salary;
--drop salary view since not in ReadMe
*/

Create view salary as
select e.emp_no, s.salary as salary
from "Employees" as e
join "Salaries" as s
on s.emp_no=e.emp_no

select * from salary
--drop salary view since not in ReadMe
drop view salary;

/*Save a view called employee_info will all the information requested:
Create view employee_info as
select "Employee".emp_no, "Employee".last_name, "Employee".first_name, "Employee".sex, "Salaries".salary as salary
from "Employees" 
join "Salaries"
on "Salaries".emp_no="Employee".emp_no
*/
--Use first letter alias:
Create view employee_info as
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary as salary
from "Employees" as e
join "Salaries" as s
on s.emp_no=e.emp_no

drop view employee_info;
--Since we saved the view we can call the alias:

select * from employee_info

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
/*
--select "Employees".hire_date from "Employees";
create view hire_year_1986 as
Select "Employees".first_name, "Employees".last_name, "Employees".hire_date FROM "Employees"
--Select * from "Employees"
WHERE hire_date BETWEEN '1986-01-01' and '1986-12-31';

Select *
from hire_year_1986

drop view hire_year_1986
*/

-- use first letter alias:
create view hire_year_1986 as
Select e.first_name, e.last_name, e.hire_date 
FROM "Employees" as e
--Select * from "Employees"
WHERE hire_date BETWEEN '1986-01-01' and '1986-12-31';

Select *
from hire_year_1986

/* 3. List the manager of each department with the following information: 
department number, department name, the manager's employee number, last name, first name.
*/
--SELECT * FROM "Departments"
--SELECT "Departments".dept_no, "Departments".dept_name FROM "Departments"
/*
create view department_manager as
--select "Dept_Manager".*, "Employees".*
select "Dept_Manager".dept_no, "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
from "Dept_Manager"
join "Employees"
on "Employees".emp_no="Dept_Manager".emp_no
join dept_emp
on dept_emp.emp_no="Employees".emp_no
join "Departments"
on "Departments".dept_no="Dept_Manager".dept_no

Select *
from department_manager
drop view department_manager;
*/

--use first letter alias:
create view department_manager as
--select "Dept_Manager".*, "Employees".*
select dm.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
from "Dept_Manager" as dm
join "Employees" as e
on e.emp_no=dm.emp_no
join dept_emp as de
on de.emp_no=e.emp_no
join "Departments" as d
on d.dept_no=dm.dept_no

Select *
from department_manager

--Need to find just the manager now?
SELECT * FROM "Title"
SELECT * FROM "Employees"
SELECT * FROM "Salaries"
SELECT * FROM dept_emp
SELECT * FROM "Dept_Manager"
SELECT * FROM "Departments"

-- 4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
/*
--This is not in order:
select "Departments".dept_name , dept_emp.dept_no, "Employees".emp_no, "Employees".last_name, "Employees".first_name
from "Departments"
join dept_emp
on dept_emp.dept_no="Departments".dept_no
join "Employees"
on "Employees".emp_no=dept_emp.emp_no
*/
/*
Create view employee_department as
select "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
from "Employees"
join dept_emp
on dept_emp.emp_no="Employees".emp_no
join "Departments"
on "Departments".dept_no=dept_emp.dept_no

Select *
from employee_department;
drop view employee_department;
*/

--use first letter alias:

Create view employee_department as
select e.emp_no, e.last_name, e.first_name, d.dept_name
from "Employees" as e
join dept_emp as de
on de.emp_no=e.emp_no
join "Departments" as d
on d.dept_no=de.dept_no

Select *
from employee_department


-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
/*
create view Hercules_B as
select "Employees".first_name, "Employees".last_name, "Employees".sex
from "Employees"
where "Employees".first_name='Hercules'
and "Employees".last_name like'B%';

Select *
From Hercules_B
drop view Hercules_B;
*/
/* This next code is not correct, do not use:
Select *
from "Employees"
where "Employees".first_name='Hercules'
and "Employees".last_name='B%';
*/

--Use first letter alias:
create view Hercules_B as
select e.first_name, e.last_name, e.sex
from "Employees" as e
where e.first_name='Hercules'
and e.last_name like'B%';

Select *
From Hercules_B

SELECT * FROM "Title"
SELECT * FROM "Employees"
SELECT * FROM "Salaries"
SELECT * FROM dept_emp
SELECT * FROM "Dept_Manager"
SELECT * FROM "Departments"

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
/*
select *
from "Departments"
where dept_no='d007'
--Take note Sales dept_no is d007
*/

select *
from employee_department
where dept_name='Sales'

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.



-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
create view frequency_last_names as 
select last_name, count(*) as "name_count"
from "Employees"
group by last_name
order by "name_count" desc;

select *
from frequency_last_names