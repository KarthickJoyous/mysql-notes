-- To get unique values & perform aggerate actions.

-- The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns.

-- All the select statements should be in GROUP BY.

/*

General Rules:

Unique Groupings: The columns or expressions in GROUP BY must define unique groups.
Column Order: The order of columns in GROUP BY matters for grouping but not for sorting.
Aggregated Output: Fields not in GROUP BY must be used with aggregate functions.

*/

SELECT COUNT(*) as published_books, author_id FROM `books` GROUP by author_id;

-- Difference between where & having in GROUP BY

-- Where clause is applied & rows are filtered before grouping. (First Filter Rows based on where condition THEN Grouping Rows)

select department,min(salary) as sal from organisation where salary > 8500 group by department;

-- Having clause is applied & rows are filtered after grouping. (First Grouping Rows THEN Filter Rows based on Having condition)

select department,min(salary) as sal from organisation group by department having sal > 8500;

-- Use Having to filter rows by aggerate function.

SELECT COUNT(*) as published_books, author_id FROM `books` GROUP by author_id HAVING published_books > 3;

-- ORDER BY :

SELECT COUNT(*) as published_books, author_id FROM `books` GROUP by author_id HAVING published_books > 3 ORDER BY published_books DESC;

-- LIMIT, OFFSET :

SELECT COUNT(*) as published_books, author_id FROM `books` GROUP by author_id HAVING published_books > 3 ORDER BY published_books DESC LIMIT 0,1;

--

-- GROUP BY & Get all values of an column in each group using GROUP_CONCAT.

SELECT COUNT(*) as published_books, author_id, GROUP_CONCAT(title ORDER by title asc SEPARATOR ',') FROM `books` GROUP by author_id;
SELECT COUNT(*) as published_books, author_id, GROUP_CONCAT(title) FROM `books` GROUP by author_id;

-- GROUP BY but get extra columns which are not in group by

SELECT COUNT(*) AS published_books, author_id, (SELECT title FROM books AS b WHERE b.author_id = books.author_id ORDER BY published_date ASC LIMIT 1) AS first_book FROM books GROUP BY author_id;

SELECT COUNT(*) AS published_books, author_id, ANY_VALUE(title) as title ,ANY_VALUE(published_date) AS published_date FROM books GROUP BY author_id;


SELECT currency, type, MAX(country_code) as country_code FROM `supported_countries` WHERE type IN('B2B', 'B2C') GROUP BY 1,2;

# -----------------------------------------------------------------------------------------------------------------------------------

SELECT 
    currency, 
    type, 
    ANY_VALUE(country_code) AS country_code, 
    ANY_VALUE(country_name) AS country_name
FROM 
    supported_countries
WHERE 
    type IN ('B2B', 'B2C')
GROUP BY 
    currency, type
LIMIT 25;

# -----------------------------------------------------------------------------------------------------------------------------------

SELECT 
    currency, 
    type, 
    (SELECT country_code FROM supported_countries sc2 WHERE sc2.currency = sc1.currency AND sc2.type = sc1.type LIMIT 1) AS country_code,
    (SELECT country_name FROM supported_countries sc3 WHERE sc3.currency = sc1.currency AND sc3.type = sc1.type LIMIT 1) AS country_name
FROM 
    supported_countries sc1 
WHERE 
    type IN ('B2B', 'B2C') 
GROUP BY 
    currency, type 
LIMIT 0, 25;

/*

Order of country_code and country_name Retrieval

The subqueries in (SELECT country_code ... LIMIT 1) and (SELECT country_name ... LIMIT 1) retrieve the first matching country_code and country_name for each (currency, type) pair. However, the LIMIT 1 does not guarantee a specific order unless you explicitly define it with an ORDER BY clause within the subquery.
Without ORDER BY

If you do not specify an ORDER BY within the subqueries, MySQL may return any country_code and country_name that matches the (currency, type) conditions, depending on factors like:

    Internal row storage order.
    Indexes on currency and type columns.
    Execution plan variations.

This means the result may vary across executions, especially if data or indexes change.
With ORDER BY

To ensure a specific and consistent order, you should add ORDER BY clauses to the subqueries. For example, if you want the alphabetically first country_code and corresponding country_name:

*/

SELECT 
    currency, 
    type, 
    (SELECT country_code FROM supported_countries sc2 WHERE sc2.currency = sc1.currency AND sc2.type = sc1.type ORDER BY country_code LIMIT 1) AS country_code,
    (SELECT country_name FROM supported_countries sc3 WHERE sc3.currency = sc1.currency AND sc3.type = sc1.type ORDER BY country_code LIMIT 1) AS country_name
FROM 
    supported_countries sc1 
WHERE 
    type IN ('B2B', 'B2C') 
GROUP BY 
    currency, type 
LIMIT 0, 25;

# -----------------------------------------------------------------------------------------------------------------------------------

SELECT 
    currency, 
    type, 
    (SELECT country_code FROM supported_countries sc2 WHERE sc2.currency = sc1.currency AND sc2.type = sc1.type ORDER BY country_code DESC LIMIT 1) AS country_code,
    (SELECT country_name FROM supported_countries sc3 WHERE sc3.currency = sc1.currency AND sc3.type = sc1.type ORDER BY country_code DESC LIMIT 1) AS country_name
FROM 
    supported_countries sc1 
WHERE 
    type IN ('B2B', 'B2C') 
GROUP BY 
    currency, type 
LIMIT 0, 25;

-- correlated subquery, which operates by referencing columns from the outer query.


# -----------------------------------------------------------------------------------------------------------------------------------

/*
1. Single Columns: You can group by a single column to aggregate data based on unique values in that column.
*/

SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department; -- Groups rows by each unique department.

/*
2. Multiple Columns: You can group by multiple columns to create groups based on unique combinations of the values in those columns.
*/

SELECT department, job_title, AVG(salary) AS avg_salary
FROM employees
GROUP BY department, job_title; -- Groups rows by each unique combination of department and job_title.

/*
3. Expressions: You can use expressions in the GROUP BY clause, such as calculated columns, concatenated values, or functions.
*/

-- Example 1: Concatenated Columns
SELECT CONCAT(department, '-', job_title) AS dept_job, COUNT(*) AS total
FROM employees
GROUP BY CONCAT(department, '-', job_title); -- Groups rows by the concatenated string of department and job_title.

-- Example 2: Derived Columns

SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS hires
FROM employees
GROUP BY YEAR(hire_date); -- Groups rows by the year extracted from the hire_date.

/*
4. Aliases (in SELECT Clause):
*/

SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS hires
FROM employees
GROUP BY hire_year;

/*
5. Columns with Functions: You can group by columns with SQL functions that transform the data.
*/

SELECT MONTH(sale_date) AS sale_month, SUM(sale_amount) AS total_sales
FROM sales
GROUP BY MONTH(sale_date); --Groups rows by the month extracted from the sale_date.

/*
6. Constants: Grouping by a constant groups all rows into a single group (rarely useful in practice).
*/

SELECT 'All Departments' AS category, COUNT(*) AS total_employees
FROM employees
GROUP BY 1; -- Groups all rows together since the constant is the same for all rows.

/*
7. Derived Fields (with Subqueries or CTEs): You can use derived fields from subqueries or Common Table Expressions (CTEs).
*/

# Example with Subquery:
SELECT department, SUM(total_sales) AS department_sales
FROM (SELECT department, sale_amount AS total_sales FROM sales) AS subquery
GROUP BY department;

# Example with CTE:
WITH sales_data AS (
    SELECT department, sale_amount
    FROM sales
)
SELECT department, SUM(sale_amount) AS total_sales
FROM sales_data
GROUP BY department;

/*
8. GROUP BY with ORDER BY: You can group by one set of fields and sort the results by other fields.
*/

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

CREATE TABLE organisation (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(255),
    salary INT
);

INSERT INTO organisation (department, salary) VALUES
('HR', 8500),
('IT', 9500),
('Sales', 7500),
('Marketing', 7800),
('IT', 11000),
('HR', 9000),
('Sales', 6500),
('Marketing', 8000),
('Finance', 12000),
('IT', 10500);


CREATE TABLE sales (
    department VARCHAR(50),
    product_id INT,
    sale_amount DECIMAL(10, 2),
    sale_date DATE
);

INSERT INTO sales (department, product_id, sale_amount, sale_date) VALUES
('HR', 1, 100.00, '2023-09-07'),
('IT', 2, 200.00, '2021-05-27'),
('HR', 3, 150.00, '2022-08-01'),
('IT', 4, 300.00, '2022-11-19'),
('IT', 5, 250.00, '2024-10-14'),
('HR', 6, 120.00, '2020-01-02');

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    job_title VARCHAR(50),
    hire_date DATE,
    salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_name, department, job_title, hire_date, salary) VALUES
('Alice', 'HR', 'Manager', '2020-01-15', 50000),
('Bob', 'IT', 'Developer', '2019-02-20', 75000),
('Charlie', 'HR', 'Assistant', '2021-03-10', 40000),
('David', 'IT', 'Developer', '2020-05-05', 80000),
('Eve', 'Sales', 'Manager', '2021-06-25', 55000),
('Frank', 'Sales', 'Sales Representative', '2019-07-18', 45000),
('Grace', 'HR', 'Manager', '2019-11-05', 60000),
('Hannah', 'IT', 'Developer', '2022-01-12', 85000),
('Ivy', 'Sales', 'Sales Representative', '2021-04-03', 42000),
('Jack', 'HR', 'Assistant', '2020-09-17', 38000),
('Kathy', 'IT', 'Developer', '2021-08-21', 79000),
('Leo', 'Sales', 'Manager', '2022-02-14', 57000),
('Mona', 'Sales', 'Sales Representative', '2020-03-05', 46000),
('Nina', 'IT', 'Developer', '2022-07-19', 82000),
('Oscar', 'Sales', 'Sales Representative', '2021-09-22', 48000),
('Paul', 'IT', 'Manager', '2020-06-30', 90000),
('Quincy', 'Sales', 'Sales Representative', '2019-10-12', 47000),
('Rachel', 'HR', 'Assistant', '2022-11-15', 39000),
('Steve', 'Sales', 'Manager', '2020-12-23', 54000);