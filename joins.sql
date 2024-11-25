# 1. INNER JOIN

/*

-- Combines rows from two tables where a specified condition is met.
-- Returns only matching rows.

Syntax:

SELECT columns 
FROM table1 
INNER JOIN table2 
ON table1.column = table2.column;

Example: Find customers with orders.

*/

# 2. LEFT (OUTER) JOIN

/*

-- Returns all rows from the left table and matching rows from the right table.
-- Non-matching rows in the right table appear as NULL.

Syntax:

SELECT columns 
FROM table1 
LEFT JOIN table2 
ON table1.column = table2.column;

Example: List all customers, including those without orders.

*/

# 3. RIGHT (OUTER) JOIN

/* 

-- Returns all rows from the right table and matching rows from the left table.
-- Non-matching rows in the left table appear as NULL.

Syntax:

SELECT columns 
FROM table1 
RIGHT JOIN table2 
ON table1.column = table2.column;

Example: List all orders, including ones without associated customers.

*/
# 4. FULL (OUTER) JOIN (NOT SUPPORTED IN MYSQL)

/* 

Combines LEFT JOIN and RIGHT JOIN.

Returns all rows when there is a match in either table.
Non-matching rows are filled with NULL.

Syntax:

SELECT columns 
FROM table1 
FULL OUTER JOIN table2 
ON table1.column = table2.column;

#Example: Find all customers and orders, including unmatched entries.

*/

# 5. CROSS JOIN

/*

Produces a Cartesian product of two tables (every row in table1 is joined with every row in table2).

Syntax:

SELECT columns 
FROM table1 
CROSS JOIN table2;

Example: Pair all products with all suppliers.

*/

# 6. SELF JOIN

/*

Joins a table to itself using table aliases.
Useful for hierarchical or comparative data.

Syntax:

SELECT a.column, b.column 
FROM table a 
INNER JOIN table b 
ON a.column = b.column;

Example: Compare employees to their managers.
*/

# Key Points

-- Joins use ON for conditions; 
-- conditions can include multiple columns.
-- Performance depends on indexing and table size.
-- Use appropriate joins to optimize query results and prevent unnecessary data processing.


# FULL OUTER JOIN 

/* 

FULL OUTER JOIN is not supported in some databases like MySQL (as of now).

However, if you're using MySQL and want the equivalent of a FULL OUTER JOIN, you can achieve this using a UNION ALL of a LEFT JOIN and a RIGHT JOIN as follows:

For databases that do not support FULL OUTER JOIN (e.g., MySQL):

SELECT owners.owner, tools.tool
FROM owners
LEFT JOIN tools ON owners.owner_id = tools.owner_id
UNION ALL
SELECT owners.owner, tools.tool
FROM owners
RIGHT JOIN tools ON owners.owner_id = tools.owner_id;

*/

# RIGHT JOIN is equivalent to LEFT JOIN with reversed table positions

# These below queries will end up returing same results by changing postions & join types (left <-> right)

select * from ITEmployees e right join ITDepartment d on e.dept_id = d.dept_id;

select * from ITDepartment d left join ITEmployees e on d.dept_id = e.dept_id;

# These below queries will end up returing same results by changing postions & join types (left <-> right)

SELECT b.id as book_id, b.title as book_name, a.id as author_id, a.name as author_name FROM `books` as b left join authors as a on b.author_id = a.id;

SELECT b.id as book_id, b.title as book_name, a.id as author_id, a.name as author_name FROM `authors` as a right join books as b on a.id=b.author_id;

# These below queries will end up returing same results by changing postions & join types (left <-> right)

SELECT b.id as book_id, b.title as book_name, a.id as author_id, a.name as author_name FROM `books` as b right join authors as a on b.author_id = a.id;

SELECT b.id as book_id, b.title as book_name, a.id as author_id, a.name as author_name FROM `authors` as a left join books as b on a.id=b.author_id;

/*

    Schema : authors has many books, books belong to authors.

    On using left join & right join, 
        -- if primary table is belong_to table then the result count will be same as this tables count.
        -- if primary table us has_many table then the result count will be more, because author will appears X times in result as BOOKS COUNT (X).
            -- if 0 books then 1 time, if 1 book then 1 time, it more than 1 then that many times.

    Revised Statement of above :

    If the primary table is the belongs_to table (e.g., books):

    The result count will always equal the count of the books table.
    This is because each row in books is included, regardless of whether it has a matching author.
    If the primary table is the has_many table (e.g., authors):

    The result count will depend on the relationships:
    Authors with no books appear once.
    Authors with 1 book appear once.
    Authors with multiple books appear once for each book they have.
    So, the result count will generally be greater than or equal to the count of the authors table, depending on how many books exist.

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

-- Create the workers table
CREATE TABLE workers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

-- Insert sample data into the workers table
INSERT INTO workers (name, salary) VALUES ('Alice Johnson', 45000.00);
INSERT INTO workers (name, salary) VALUES ('Bob Smith', 52000.00);
INSERT INTO workers (name, salary) VALUES ('Charlie Brown', 47000.00);
INSERT INTO workers (name, salary) VALUES ('Diana Prince', 60000.00);
INSERT INTO workers (name, salary) VALUES ('Ethan Hunt', 55000.00);
INSERT INTO workers (name, salary) VALUES ('Fiona Gallagher', 48000.00);
INSERT INTO workers (name, salary) VALUES ('George Washington', 62000.00);
INSERT INTO workers (name, salary) VALUES ('Hannah Baker', 51000.00);
INSERT INTO workers (name, salary) VALUES ('Ian Malcolm', 53000.00);
INSERT INTO workers (name, salary) VALUES ('Jane Foster', 58000.00);


SELECT w1.name AS Worker1,  w2.name AS Worker2 FROM workers w1 LEFT JOIN workers w2 ON w1.salary > w2.salary order by w1.name;

SELECT w1.name AS Worker1, GROUP_CONCAT(w2.id) FROM workers w1 LEFT JOIN workers w2 ON w1.salary > w2.salary GROUP BY w1.id order by w1.name;

SELECT w1.name AS Worker1, GROUP_CONCAT(w2.id) FROM workers w1 LEFT JOIN workers w2 ON w1.salary >= w2.salary GROUP BY w1.id order by w1.name;

SELECT w1.name AS Worker1, GROUP_CONCAT(w2.id) AS WorkersWithLowerSalary FROM workers w1 LEFT JOIN workers w2 ON w1.salary >= w2.salary AND w1.id != w2.id GROUP BY w1.id ORDER BY w1.id;

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

SELECT item.item_name FROM `item` GROUP by item.item_id;

*/