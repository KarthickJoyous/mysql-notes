# Link : https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php

/*

1. Salespeople from Paris or Rome

From the following table, write a SQL query to find the details of those salespeople who come from the 'Paris' City or 'Rome' City.
Return salesman_id, name, city, commission.

Sample table: salesman

*/

SELECT * FROM salesman WHERE city = 'Paris' OR city = 'Rome';
SELECT * FROM salesman WHERE city IN('Paris', 'Rome');

/*

2. Salespeople in Paris or Rome

From the following table, write a SQL query to find the details of the salespeople who come from either 'Paris' or 'Rome'.
Return salesman_id, name, city, commission. 

Sample table: salesman

*/

SELECT * FROM salesman WHERE city = 'Paris' OR city = 'Rome';
SELECT * FROM salesman WHERE city IN('Paris', 'Rome');

/*

3. Salespeople Not in Paris or Rome

From the following table, write a SQL query to find the details of those salespeople who live in cities other than Paris and Rome.
Return salesman_id, name, city, commission.  

Sample table: salesman

*/

SELECT * FROM salesman WHERE city NOT IN('Paris', 'Rome');
SELECT * FROM salesman WHERE NOT (city = 'Paris' OR city = 'Rome');

/*

4. Customers with Specific IDs

From the following table, write a SQL query to retrieve the details of all customers whose ID belongs to any of the values 3007, 3008 or 3009.
Return customer_id, cust_name, city, grade, and salesman_id.  

Sample table: customer

*/

SELECT * FROM customer WHERE customer_id IN(3007, 3008, 3009);

/*

5. Salespeople with Commission 0.12-0.14

From the following table, write a SQL query to find salespeople who receive commissions between 0.12 and 0.14 (begin and end values are included).
Return salesman_id, name, city, and commission.  

Sample table: salesman

*/

SELECT * FROM salesman WHERE commission BETWEEN 0.12 AND 0.14;

/*

6. Orders Between 500-4000 Excluding Specific Amounts

From the following table, write a SQL query to select orders between 500 and 4000 (begin and end values are included).
Exclude orders amount 948.50 and 1983.43.
Return ord_no, purch_amt, ord_date, customer_id, and salesman_id. 

Sample table: orders

*/

SELECT * FROM orders WHERE (purch_amt BETWEEN 500 AND 4000) AND (purch_amt NOT IN (948.50, 1983.43));

/*

7. Salespeople with Names N-O Range

From the following table, write a SQL query to retrieve the details of the salespeople whose names begin with any letter between 'A' and 'L' (not inclusive).
Return salesman_id, name, city, commission. 

Sample table: salesman

*/

SELECT * FROM salesman WHERE LEFT(name, 1) > 'A' AND LEFT(name, 1) < 'L';

SELECT * FROM salesman WHERE name > 'A' AND name < 'L';

/*

8. Salespeople with Names Not A-M Range

From the following table, write a SQL query to find the details of all salespeople except those whose names begin with any letter between 'A' and 'M'.
Return salesman_id, name, city, commission.  

Sample table: salesman

*/

SELECT * FROM salesman WHERE NOT (name REGEXP '^[A-M]');

/*

9. Customers with Names Starting with B

From the following table, write a SQL query to retrieve the details of the customers whose names begins with the letter 'B'.
Return customer_id, cust_name, city, grade, salesman_id.. 

Sample table: customer

*/

SELECT* FROM customer WHERE cust_name REGEXP "^[AB]";

/*

10. Customers with Names Ending with N

From the following table, write a SQL query to find the details of the customers whose names end with the letter 'n'.
Return customer_id, cust_name, city, grade, salesman_id.

Sample table: customer

*/

SELECT* FROM customer WHERE cust_name REGEXP "N$";

/*

11. Salespeople Name Starts 'N' with Fourth 'L'

From the following table, write a SQL query to find the details of those salespeople whose names begin with ‘N’ and the fourth character is 'l'.
Rests may be any character.
Return salesman_id, name, city, commission. 

Sample table : salesman

*/

SELECT* FROM salesman WHERE name LIKE "N__l%";

/*

12. Rows with Underscore Character

From the following table, write a SQL query to find those rows where col1 contains the escape character underscore ( _ ).
Return col1.

Sample table: testtable

*/

CREATE TABLE IF NOT EXISTS testtable (
    col1 VARCHAR(50)
);

INSERT INTO testtable (col1) VALUES
('A001/DJ-402\\44_/100/2015'),
('A001_\\DJ-402\\44_/100/2015'),
('A001_DJ-402-2014-2015'),
('A002_DJ-401-2014-2015'),
('A001/DJ_401'),
('A001/DJ_402\\44'),
('A001/DJ_402\\44\\2015'),
('A001/DJ-402%45\\2015/200'),
('A001/DJ_402\\45\\2015%100'),
('A001/DJ_402%45\\2015/300'),
('A001/DJ-402\\44');

SELECT * FROM testtable WHERE col1 LIKE "%/_%" ESCAPE "/";

/*

13. Rows Without Underscore Character

From the following table, write a SQL query to identify those rows where col1 does not contain the escape character underscore ( _ ).
Return col1.

Sample table: testtable

*/

SELECT * FROM testtable WHERE NOT col1 LIKE "%/_%" ESCAPE "/";

/*

14. Rows with Forward Slash Character

From the following table, write a SQL query to find rows in which col1 contains the forward slash character ( / ).

Return col1.

Sample table: testtable

*/

SELECT * FROM testtable WHERE col1 LIKE "%//%" ESCAPE "/";

/*

15. Rows Without Forward Slash Character

From the following table, write a SQL query to identify those rows where col1 does not contain the forward slash character ( / ). Return col1.

Sample table: testtable

*/

SELECT * FROM testtable WHERE NOT col1 LIKE "%//%" ESCAPE "/";

/*

16. Rows with '_/' String

From the following table, write a SQL query to find those rows where col1 contains the string ( _/ ). Return col1.

Sample table: testtable

*/

SELECT * FROM testtable WHERE col1 LIKE "%#_/%" ESCAPE "#";

/*

17. Rows Without '_/' String

From the following table, write a SQL query to find those rows where col1 does not contain the string ( _/ ). Return col1.

Sample table: testtable

*/

SELECT * FROM testtable WHERE NOT col1 LIKE "%#_/%" ESCAPE "#";

/*

18. Rows with Percent Character

From the following table, write a SQL query to find those rows where col1 contains the character percent ( % ). Return col1.

Sample table: testtable

*/

SELECT * FROM testtable WHERE col1 LIKE "%/%%" ESCAPE "/";

/*

19. Rows Without Percent Character

From the following table, write a SQL query to find those rows where col1 does not contain the character percent ( % ). Return col1.

Sample table: testtable

*/

SELECT * FROM testtable WHERE NOT col1 LIKE "%/%%" ESCAPE "/";

/*

20. Customers Without Grade

From the following table, write a SQL query to find all those customers who does not have any grade.

Return customer_id, cust_name, city, grade, salesman_id.

Sample table: customer

*/

SELECT * FROM customer WHERE grade IS NULL;

/*

21. Customers With Grade

From the following table, write a SQL query to locate all customers with a grade value. Return customer_id, cust_name,city, grade, salesman_id.

Sample table: customer

*/

SELECT * FROM customer WHERE grade IS NOT NULL;

/*

22. Employees with Last Name Starting 'D'

From the following table, write a SQL query to locate the employees whose last name begins with the letter 'D'.
Return emp_idno, emp_fname, emp_lname and emp_dept.

Sample table: emp_details

*/

SELECT * FROM emp_details WHERE emp_lname REGEXP "^D";

/*

Use ESCAPE when your pattern contains special characters (such as %, _, [, etc.) that you want to treat as literals.
It allows you to define a custom escape character to make this distinction in your LIKE clause.

*/
