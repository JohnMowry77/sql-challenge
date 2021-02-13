--Inspect the CSVs & sketch out an ERD of the tables.
-- http://www.quickdatabasediagrams.com

--Create a table schema for each of the six CSV files
-- Specify data types, primary keys, foreign keys, and other constraints
-- is the column unique? if not, create a composite key.
-- which takes to primary keys in order to uniquel identify a row.
-- *Create tables in the correct order to handle foreign keys

create table departments (
	dept_no varchar not null,
	dept_name varchar not null
);

select * from departments;

create table dept_emp (
	emp_no int, 
	dept_no varchar
);

select * from dept_emp

create table employees (
	emp_no int,
	emp_title_id varchar,
	birth_date data style MDY,
	first_name character varying (50),
	last_name character varying (50),
	sex character varying (50),
	hire_date data style MDY
);
emp_no	emp_title_id	birth_date	first_name	last_name	sex	hire_date
select * from employees





-- import each CSV file into the corresponding SQL table 
-- departments.csv 