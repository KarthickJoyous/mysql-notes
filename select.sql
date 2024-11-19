-- Selecting all columns from table :

SELECT * FROM users;

# ------------------------------------------------------------------------------------------------------------------

-- Select name, city from users but unique values, DISTINCT not only applies for name but all columns mentioned in query :

SELECT DISTINCT `name`, `city` FROM users;

-- DISTINCT not supported aggerate functions (COUNT, SUM, AVG, ...)

# ------------------------------------------------------------------------------------------------------------------

-- Select only required columns :

SELECT id, name FROM users;

# ------------------------------------------------------------------------------------------------------------------

-- Select with LIKE :

Select name from users where name LIKE "Karthick"; -- Name equals to "Karthick"

Select name from users where name LIKE "ka%"; -- Name started with "ka"

Select name from users where name LIKE "%ck"; -- Name ends with "ck"

Select name from users where name LIKE "%th%"; -- Name contains "th" in it

Select name from users where name LIKE "_a%"; -- Name contains "a" as second letter

SELECT name FROM `users` WHERE name LIKE "__i__"; -- Name contains "i" as third letter & total length of 5 charaters

SELECT name FROM table_name WHERE CAST(numeric_column AS VARCHAR) LIKE '123%'; -- Using LIKE with numeric values converted to strings

-- NOTE : Learn about ESCAPE characters (SELECT country_name  FROM `supported_countries`  WHERE country_name LIKE '%\%%' ESCAPE "\")

# ------------------------------------------------------------------------------------------------------------------

-- Select with CASE :

Select student_name, marks, CASE WHEN marks >= 35 THEN "PASS" ELSE "FAIL" END as 'result' from subject_marks where s_code = "SCIENCE";

# ------------------------------------------------------------------------------------------------------------------

-- Select with IF :

Select student_name, marks, IF(marks >= 35, "PASS", "FAIL") 'result' from subject_marks where s_code = "SCIENCE";

# ------------------------------------------------------------------------------------------------------------------

-- Select ALIAS (AS) :

Select CONCAT(first_name, " ", last_name) as name from users;

# ------------------------------------------------------------------------------------------------------------------

-- Select with LIMIT :

Select id, CONCAT(first_name, " ", last_name) as name from users ORDER BY id DESC LIMIT 10; -- Select only 10 rows

-- When a LIMIT clause contains two numbers, it is interpreted as LIMIT offset,count (LIMIT skip,take). So, in this below query skips five records and returns next 10

-- [
	Select id, CONCAT(first_name, " ", last_name) as name from users ORDER BY id DESC LIMIT 0, 10; -- (SKIP - 0, TAKE - 10) (ROWS 1-10 Returned)

	Select id, CONCAT(first_name, " ", last_name) as name from users ORDER BY id DESC LIMIT 10, 10; -- (SKIP - 10, TAKE - 10) (ROWS 11-20 Returned)
-- ]

# ------------------------------------------------------------------------------------------------------------------

/* 

Select with BETWEEN :

Between can be used in the case when needed (GREATER THAN EQUALS AND LESS THAN EQUALS) (marks >= 80 AND marks <= 90)

SELECT student_name, marks from subject_marks WHERE marks BETWEEN 80 AND 90 AND s_code = "ENGLISH";

(GET Students who scored marks from 80 to 90) 

*/

-- Select with NOT BETWEEN :

SELECT student_name, marks from subject_marks WHERE marks NOT BETWEEN 35 AND 100 AND s_code = "ENGLISH";

# ------------------------------------------------------------------------------------------------------------------

-- Select with WHERE :

SELECT id, name FROM users WHERE user_type = 2;

/* The WHERE clause can contain any valid SELECT statement to write more complex queries. This is a 'nested' query.

Nested queries are usually used to return single atomic values from queries for comparisons. */

SELECT title FROM books WHERE author_id = (SELECT id FROM authors WHERE last_name = 'Bar' AND first_name = 'Foo');

-- Selects all usernames with no email address :

SELECT * FROM stack WHERE username IN (SELECT username FROM signups WHERE email IS NULL);

-- NOTE: Consider using joins for performance improvements when comparing a whole result set.

SELECT title FROM books WHERE author_id = (SELECT id FROM authors WHERE last_name = 'Bar' AND first_name = 'Foo');
-- Equals To
SELECT b.title FROM books AS b JOIN authors AS a ON b.author_id = a.id WHERE a.last_name = 'Bar' AND a.first_name = 'Foo';

SELECT * FROM stack WHERE username IN (SELECT username FROM signups WHERE email IS NULL);
-- Equals To
SELECT s.* FROM stack AS s JOIN signups AS s_up ON s.username = s_up.username WHERE s_up.email IS NULL;

# ------------------------------------------------------------------------------------------------------------------

-- LEARN DATE RANGE :

SELECT id, name, dob FROM `authors` WHERE dob >= '1983-01-01' AND dob <= '1999-11-19' order by dob desc;

SELECT id, name, dob FROM `authors` where dob BETWEEN '1983-01-01' AND '1999-11-19' order by dob desc;

SELECT id, name, created_at FROM `authors` WHERE created_at BETWEEN '2023-04-01' AND '2024-04-01' ORDER BY created_at DESC;

SELECT id, name, created_at FROM `authors` WHERE created_at BETWEEN '2024-05-01 00:00:00' AND '2024-05-01 19:30:00' ORDER BY created_at DESC;

# ------------------------------------------------------------------------------------------------------------------