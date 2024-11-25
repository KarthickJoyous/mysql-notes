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

/*

These qeries called as *correlated subquery*

(SELECT country_code FROM supported_countries sc2 WHERE sc2.currency = sc1.currency AND sc2.type = sc1.type ORDER BY country_code DESC LIMIT 1) AS country_code,
(SELECT country_name FROM supported_countries sc3 WHERE sc3.currency = sc1.currency AND sc3.type = sc1.type ORDER BY country_code DESC LIMIT 1) AS country_name

-- correlated subquery, which operates by referencing columns from the outer query.
-- They allow dynamically fetching specific related data for each row in the outer query without needing an explicit JOIN.
-- However, they may be less performant than using JOIN for large datasets due to repeated execution for each row.
*/


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

-- 1055 error :

/*

Imagine you're asking MySQL to group data based on some columns and perform calculations, but then you also ask for other details that don't fit within those groups. 
MySQL doesn't know how to handle those extra columns, so it throws error 1055.

Error Query : SELECT customer_name, total_amount, SUM(total_amount) FROM orders GROUP BY customer_name;

CORRECT Query : SELECT customer_name, SUM(total_amount) AS total_spent FROM orders GROUP BY customer_name;

Alternative Solution (if you really need total_amount):

If you want to keep the SQL query without fixing the logic, you can temporarily turn off the ONLY_FULL_GROUP_BY mode, but this is not recommended for long-term solutions:

SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

Note: Modifying SQL modes might lead to unexpected behavior in other queries. Always aim to fix the query logic first.

*/

# -- GROUP BY but get extra columns which are not in group by

SELECT 
    sc.currency, 
    sc.type, 
    sc.country_code, 
    sc.country_name
FROM 
    supported_countries sc
JOIN 
    (SELECT currency, type, MAX(country_code) AS country_code
     FROM supported_countries
     WHERE type IN ('B2B', 'B2C')
     GROUP BY currency, type
     LIMIT 25) AS subquery
ON 
    sc.currency = subquery.currency 
    AND sc.type = subquery.type 
    AND sc.country_code = subquery.country_code;

SELECT item.*, subquery.total_uses from item join (select item_id, COUNT(*) as total_uses from uses GROUP BY item_id) as subquery on item.item_id = subquery.item_id; 

SELECT authors.*, subquery.total_written_books FROM `authors` join (SELECT author_id, COUNT(*) as total_written_books from books group by author_id) as subquery on subquery.author_id = authors.id order by total_written_books desc; 

WITH CTE as (SELECT author_id, COUNT(*) as total_written_books from books group by author_id) 
SELECT authors.*, subquery.total_written_books FROM `authors` join CTE as subquery on subquery.author_id = authors.id order by total_written_books desc; 

CREATE TABLE item (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100),
    description VARCHAR(255),
    price DECIMAL(10, 2)
);

INSERT INTO item (item_name, description, price) VALUES
('Item A', 'Description of Item A', 10.50),
('Item B', 'Description of Item B', 20.00),
('Item C', 'Description of Item C', 15.75);


CREATE TABLE uses (
    use_id INT PRIMARY KEY AUTO_INCREMENT,
    item_id INT,
    used_by VARCHAR(100),
    use_date DATE,
    FOREIGN KEY (item_id) REFERENCES item(item_id)
);

INSERT INTO uses (item_id, used_by, use_date) VALUES
(1, 'User1', '2024-11-01'),
(1, 'User2', '2024-11-02'),
(2, 'User3', '2024-11-03'),
(1, 'User4', '2024-11-04'),
(3, 'User5', '2024-11-05'),
(2, 'User6', '2024-11-06');

/*

FUNCTIONAL DEPENDENT (GROUP BY):

SELECT w1.name AS Worker1, 
       GROUP_CONCAT(w2.id) AS WorkersWithLowerSalary 
FROM workers w1 
LEFT JOIN workers w2 
  ON w1.salary >= w2.salary AND w1.id != w2.id 
GROUP BY w1.id 
ORDER BY w1.id;


This groups the results by w1.id (the worker in question).
Since w1.id is the grouping column, it's okay to use w1.name in the SELECT clause without explicitly adding it to GROUP BY. This is allowed because w1.name is functionally dependent on w1.id — meaning for every unique w1.id, there's only one corresponding w1.name.
This is a standard behavior in SQL. As long as the non-aggregated columns are dependent on the GROUP BY column (here w1.id), they can be included in the SELECT without being part of the GROUP BY clause.

SELECT item.item_name FROM `item` GROUP by item.item_id; (Just for knowledge that this works)

*/