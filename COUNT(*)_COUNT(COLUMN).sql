/*

The difference between COUNT(*) and COUNT(column) in SQL lies in what is being counted:

1. COUNT(*)
-- Counts all rows in the result set, regardless of whether they contain NULL values or not.
-- It includes every row, even if every column in that row has NULL.

*/

# Example:

SELECT COUNT(*) FROM employees; -- This query counts the total number of rows in the employees table.

/*

2. COUNT(column)
-- Counts only non-NULL values in the specified column.
-- Rows where the specified column is NULL are ignored.

*/

#Example:

SELECT COUNT(salary) FROM employees; -- This query counts the number of rows where the salary column is not NULL.

/*

Key Differences:
Feature	COUNT(*)	COUNT(column)
Includes NULL values	Yes	No
Focus	Counts all rows	Counts non-NULL values in the column
Performance	Generally faster (less specific)	Slightly slower (depends on column's indexing)

*/

# Use Case Example:

/*

TABLE:

ID	Name	Salary
1	Alice	5000
2	Bob	(NULL)
3	Charlie	7000
4	(NULL)	6000

*/

#Queries:

SELECT COUNT(*) FROM employees; -- Result: 4 (counts all rows)

SELECT COUNT(Salary) FROM employees; -- Result: 3 (counts only rows where Salary is not NULL)

SELECT COUNT(Name) FROM employees; -- Result: 3 (counts only rows where Name is not NULL)

/*

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    job_title VARCHAR(50),
    hire_date DATE,
    salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_name, department, job_title, hire_date, salary)
VALUES ('Alice Johnson', 'HR', 'HR Manager', '2022-05-01', 75000);

INSERT INTO employees (employee_name, department, job_title, hire_date, salary)
VALUES ('Bob Smith', 'Finance', 'Accountant', '2021-08-15', NULL);

INSERT INTO employees (employee_name, department, job_title, hire_date, salary)
VALUES ('Charlie Brown', 'IT', 'Software Developer', '2020-10-12', 95000);

INSERT INTO employees (employee_name, department, job_title, hire_date, salary)
VALUES ('Diana Prince', 'Marketing', 'Marketing Specialist', '2023-02-20', 67000);

INSERT INTO employees (employee_name, department, job_title, hire_date, salary)
VALUES ('Ethan Hunt', 'IT', 'Network Engineer', '2019-11-01', NULL);

INSERT INTO employees (employee_name, department, job_title, hire_date, salary)
VALUES ('Fiona Gallagher', 'Sales', 'Sales Representative', '2021-04-10', 54000);

INSERT INTO employees (employee_name, department, job_title, hire_date, salary)
VALUES ('George Bailey', 'Finance', 'Financial Analyst', '2020-07-25', NULL);

INSERT INTO employees (employee_name, department, job_title, hire_date, salary)
VALUES ('Hannah Wells', 'Legal', 'Legal Advisor', '2022-12-14', 80000);

INSERT INTO employees (employee_name, department, job_title, hire_date, salary)
VALUES ('Ian Malcolm', 'Research', 'Research Scientist', '2023-01-05', NULL);

INSERT INTO employees (employee_name, department, job_title, hire_date, salary)
VALUES ('Jane Foster', 'Engineering', 'Civil Engineer', '2018-03-21', 72000);

*/