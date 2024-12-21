# Link : https://www.w3resource.com/sql-exercises/sql-joins-exercises.php

/*

1. From the following tables write a SQL query to find the salesperson and customer who reside in the same city.
Return Salesman, cust_name and city.

Sample table: salesman
Sample table: customer
*/

SELECT s.name AS "Salesman", c.cust_name, c.city FROM salesman AS s
JOIN customer AS c
ON s.city = c.city;

/*

2. From the following tables write a SQL query to find those orders where the order amount exists between 500 and 2000.
Return ord_no, purch_amt, cust_name, city.

Sample table: customer
Sample table: orders

*/

SELECT o.ord_no, o.purch_amt, c.cust_name, c.city
FROM orders AS o
JOIN customer AS c
ON o.customer_id = c.customer_id
WHERE o.purch_amt BETWEEN 500 AND 2000;

/*

3. From the following tables write a SQL query to find the salesperson(s) and the customer(s) he represents.
Return Customer Name, city, Salesman, commission.

Sample table: customer
Sample table: salesman

*/

SELECT c.cust_name AS "Customer Name", c.city, s.name AS "Salesman", s.commission
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id;

/*

4. From the following tables write a SQL query to find salespeople who received commissions of more than 12 percent from the company.
Return Customer Name, customer city, Salesman, commission.  

Sample table: customer
Sample table: salesman

*/

SELECT c.cust_name AS "Customer Name", c.city AS "customer city", s.name AS "Salesman", s.commission
FROM salesman AS s
JOIN customer AS c
ON s.salesman_id = c.salesman_id
WHERE (s.commission * 100) > 12;

/*

5. From the following tables write a SQL query to locate those salespeople who do not live in the same city where their customers live and have received a commission of more than 12% from the company.
Return Customer Name, customer city, Salesman, salesman city, commission.  

Sample table: customer
Sample table: salesman

*/

SELECT c.cust_name AS "Customer Name", c.city AS "customer city", s.name AS "Salesman", s.city AS "salesman city", s.commission
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id AND c.city != s.city
WHERE (s.commission * 100) > 12;

/*

6. From the following tables write a SQL query to find the details of an order.
Return ord_no, ord_date, purch_amt, Customer Name, grade, Salesman, commission. 

Sample table: orders
Sample table: customer

*/

SELECT o.ord_no, o.ord_date, o.purch_amt, c.cust_name AS "Customer Name", c.grade, s.name AS "Salesman", s.commission
FROM orders AS o
JOIN customer AS c
ON o.customer_id = c.customer_id
JOIN salesman AS s
ON o.salesman_id = s.salesman_id;

/*

7. Write a SQL statement to join the tables salesman, customer and orders so that the same column of each table appears once and only the relational rows are returned. 

Sample table: salesman
Sample table: customer
Sample table: orders

*/

SELECT * FROM orders NATURAL JOIN customer NATURAL JOIN salesman;

/*

8. From the following tables write a SQL query to display the customer name, customer city, grade, salesman, salesman city.
The results should be sorted by ascending customer_id.  

Sample table: customer
Sample table: salesman

*/

SELECT c.cust_name AS "customer name", c.city AS "customer city", COALESCE(c.grade, "NO GRADE"), s.name AS "salesman", s.city AS "salesman city"
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
ORDER BY c.customer_id ASC;

/*

9. From the following tables write a SQL query to find those customers with a grade less than 300.
Return cust_name, customer city, grade, Salesman, salesmancity.
The result should be ordered by ascending customer_id. 

Sample table: customer
Sample table: salesman

*/

SELECT c.cust_name, c.city AS "customer city", c.grade, s.name AS "Salesman", s.city AS "salesmancity"
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
WHERE c.grade < 300
ORDER BY c.customer_id ASC;

/*

10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order according to the order date to determine whether any of the existing customers have placed an order or not.

Sample table: orders
Sample table: customer

*/

SELECT c.cust_name AS "customer name", c.city, o.ord_no AS "order number", o.ord_date AS "order date", o.purch_amt AS "order amount"
FROM customer AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
ORDER BY o.ord_date, o.purch_amt ASC;

/*

11. SQL statement to generate a report with customer name, city, order number, order date, order amount, salesperson name, and commission to determine if any of the existing customers have not placed orders or if they have placed orders through their salesman or by themselves.

Sample table: customer
Sample table: orders
Sample table: salesman

*/

SELECT c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt, s.name, s.commission
FROM customer AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
LEFT JOIN salesman AS s
    ON o.salesman_id = s.salesman_id;

/*

12. Write a SQL statement to generate a list in ascending order of salespersons who work either for one or more customers or have not yet joined any of the customers.

Sample table: customer
Sample table: salesman

*/

SELECT s.name AS "salesman", c.cust_name AS "customer"
FROM salesman AS s
LEFT JOIN customer AS c
ON s.salesman_id = c.salesman_id;

/*

13. From the following tables write a SQL query to list all salespersons along with customer name, city, grade, order number, date, and amount.

Condition for selecting list of salesmen : 
    1. Salesmen who works for one or more customer or, 
    2. Salesmen who not yet join under any customer, 
Condition for selecting list of customer : 
    3. placed one or more orders, or 
    4. no order placed to their salesman.

Sample table: customer
Sample table: salesman
Sample table: orders

*/

SELECT s.name, s.commission, c.cust_name, c.city, c.grade, o.ord_no, o.ord_date, o.purch_amt
FROM salesman AS s
LEFT JOIN customer AS c
    ON s.salesman_id = c.salesman_id
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;