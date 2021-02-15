--Inspect the CSVs & sketch out an ERD of the tables.
-- http://www.quickdatabasediagrams.com

--Create a table schema for each of the six CSV files
-- Specify data types, primary keys, foreign keys, and other constraints

create table departments (
	id SERIAL Primary Key,
	dept_no varchar not null,
	dept_name varchar not null
);

select * from departments;



-- is the column unique? if not, create a composite key.
-- which takes to primary keys in order to uniquel identify a row.

-- *Create tables in the correct order to handle foreign keys

-- import each CSV file into the corresponding SQL table 