create table departments (
	id SERIAL PRIMARY KEY,
	demp_no varchar,
	dept_name varchar
);

select * from departments;

create table dept_emp (
	id SERIAL PRIMARY KEY,
	emp_no int,
	emp_title_id varchar,
	birth_date date,
	first_name varchar,
	last_name varchar,
	sex varchar,
	hire_date date
);


-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
	id SERIAL PRIMARY KEY,
    "demp_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL
);

CREATE TABLE "dept_emp" (
	id SERIAL PRIMARY KEY,
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL
);

CREATE TABLE "dept_manager" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" date   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" varch   NOT NULL,
    "title" varchar   NOT NULL
);

ALTER TABLE "departments" ADD CONSTRAINT "fk_departments_demp_no" FOREIGN KEY("demp_no")
REFERENCES "dept_emp" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("demp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_emp" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");