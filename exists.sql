/*

In MySQL, the EXISTS() function is a logical operator used to test for the existence of rows returned by a subquery.
It evaluates to TRUE if the subquery returns any rows and FALSE if it does not.
It's commonly used in conditions within WHERE or HAVING clauses to filter results based on the presence of related data.

SELECT column1, column2, ...
FROM table
WHERE EXISTS (subquery);

Performance:

EXISTS() stops evaluating as soon as the subquery returns the first row.
This makes it efficient for certain cases where you only care about the presence of rows, not the actual data.

Behavior:

The subquery doesn't need to select specific columns.
A common practice is to use SELECT 1 or SELECT NULL in the subquery, as the returned value doesn't matter—only the existence of rows is checked.

Example: Filtering based on related data
Suppose you have two tables: employees and departments, and you want to find employees who belong to a department.

Tables:

employees: employee_id, name, department_id
departments: department_id, department_name
Query:

SELECT name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM departments d
    WHERE d.department_id = e.department_id
);

Here:

The subquery checks if a matching department exists for each employee.
If a match is found, the outer query includes that employee in the result.

*/

-- Select author's who written a book with pages more than or equals 1000:

SELECT authors.name FROM authors WHERE EXISTS (SELECT 1 FROM books WHERE authors.id = books.author_id AND pages >= 1000);

-- Select author's who not written a book with pages more than or equals 1000:

SELECT authors.name FROM authors WHERE NOT EXISTS (SELECT 1 FROM books WHERE authors.id = books.author_id AND pages >= 1000);

-- Select author's id, author's name, COUNT of books having more than 500 pages, and has atleast 3 books :

SELECT a.id as author_id, a.name as author_name, COUNT(*) as books_count
FROM authors AS a 
JOIN books AS b ON a.id = b.author_id 
WHERE b.pages > 500 GROUP BY a.id 
HAVING books_count >= 3
ORDER BY books_count DESC;

/*

IGNORE : 

Select author's id, author's name, b.title, b.pages, whose books having more than 800 pages, and has atleast 5 books :

SELECT b1.author_id, COUNT(b1.id) as bc FROM books AS b1 JOIN authors as a1 ON b1.author_id = a1.id GROUP BY b1.author_id HAVING bc > 5 ORDER BY 1 DESC;

SELECT 
    a.id as author_id, a.name as author_name,
    b.id as book_id, b.pages, b.title as book_name
FROM authors AS a 
JOIN books AS b ON a.id = b.author_id 
WHERE b.pages > 600 AND EXISTS (SELECT COUNT(b1.id) as bc FROM books AS b1 JOIN authors as a1 ON b1.author_id = a1.id GROUP BY b1.author_id HAVING bc > 5 ORDER BY 1 DESC)
ORDER BY 1 DESC;

*/