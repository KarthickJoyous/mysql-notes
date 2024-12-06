#Link : https://www.w3resource.com/sql-exercises/sql-exercises-quering-on-multiple-table.php

SELECT * FROM salesman;
SELECT * FROM customer;
SELECT * FROM orders;

/*

1. From the following tables, write a SQL query to find the salespeople and customers who live in the same city.
Return customer name, salesperson name and salesperson city.

Sample table: salesman
Sample table: customer

*/

SELECT c.cust_name, s.name, c.city FROM customer AS c JOIN salesman AS s ON c.city = s.city;
SELECT c.cust_name, s.name, c.city FROM customer AS c , salesman AS s WHERE c.city = s.city;

/*

2. From the following tables, write a SQL query to locate all the customers and the salesperson who works for them.
Return customer name, and salesperson name.  

Sample table: salesman
Sample table: customer

*/

SELECT c.cust_name, s.name FROM customer AS c LEFT JOIN salesman AS s ON c.salesman_id = s.salesman_id;

/*

3. From the following tables, write a SQL query to find those salespeople who generated orders for their customers but are not located in the same city.
Return ord_no, cust_name, customer_id (orders table), salesman_id (orders table).  

Sample table: salesman
Sample table: customer
Sample table: order

*/

SELECT o.ord_no, filters.cust_name, o.customer_id, o.salesman_id
FROM orders AS o
JOIN (SELECT c.cust_name, c.customer_id, s.salesman_id FROM customer AS c JOIN salesman AS s ON c.city != s.city) AS filters
ON filters.salesman_id = o.salesman_id AND filters.customer_id = o.customer_id;

WITH filters AS (
    SELECT c.cust_name, c.customer_id, s.salesman_id FROM customer AS c JOIN salesman AS s ON c.city != s.city
)

SELECT o.ord_no, f.cust_name, o.customer_id, o.salesman_id
FROM orders AS o
JOIN filters as f
ON f.salesman_id = o.salesman_id AND f.customer_id = o.customer_id;

SELECT ord_no, cust_name, orders.customer_id, orders.salesman_id FROM salesman, customer, orders WHERE customer.city <> salesman.city AND orders.customer_id = customer.customer_id AND orders.salesman_id = salesman.salesman_id;

/*

4. From the following tables, write a SQL query to locate the orders made by customers.
Return order number, customer name.  

Sample table: orders
Sample table: customer

*/

SELECT o.ord_no, c.cust_name FROM customer AS c JOIN orders AS o ON c.customer_id = o.customer_id;
SELECT orders.ord_no, customer.cust_name FROM orders, customer WHERE orders.customer_id = customer.customer_id;

/*

5. From the following tables, write a SQL query to find those customers where each customer has a grade and is served by a salesperson who belongs to a city.
Return cust_name as "Customer", grade as "Grade".   

Sample table: orders
Sample table: customer

*/

SELECT c.cust_name AS "Customer", c.grade AS "Grade", o.ord_no as "Order No."
FROM orders AS o
JOIN customer AS c ON c.customer_id = o.customer_id
JOIN salesman AS s ON s.salesman_id = o.salesman_id
WHERE c.grade IS NOT NULL AND s.city IS NOT NULL;

SELECT customer.cust_name AS "Customer", customer.grade AS "Grade", orders.ord_no AS "Order No." FROM orders, salesman, customer WHERE orders.customer_id = customer.customer_id AND orders.salesman_id = salesman.salesman_id AND salesman.city IS NOT NULL AND customer.grade IS NOT NULL;

/*

6. From the following table,
Write a SQL query to find those customers who are served by a salesperson and the salesperson earns commission in the range of 12% to 14% (Begin and end included).
Return cust_name AS "Customer", city AS "City". 

Sample table: salesman
Sample table: customer

*/

SELECT c.cust_name AS "Customer", s.name AS "Salesman", c.city AS "City", CONCAT(s.commission * 100, "%") AS "Commission"
FROM customer AS c
JOIN salesman AS s
ON c.salesman_id = s.salesman_id
WHERE (s.commission * 100) BETWEEN 12 AND 14;

SELECT customer.cust_name AS "Customer", customer.city AS "City", salesman.name AS "Salesman", salesman.commission FROM customer,salesman
WHERE customer.salesman_id = salesman.salesman_id AND salesman.commission BETWEEN .12 AND .14;

/*

7. From the following tables, write a SQL query to find all orders executed by the salesperson and ordered by the customer whose grade is greater than or equal to 200.
Compute purch_amt*commission as “Commission”. Return customer name, commission as “Commission%” and Commission.

Sample table: salesman
Sample table: orders

*/

SELECT o.ord_no, c.cust_name AS "Customer Name", s.name AS "Salesman Name", s.commission AS "Commission%", (o.purch_amt * s.commission) AS "Commission"
FROM orders AS o
JOIN salesman AS s ON o.salesman_id = s.salesman_id
JOIN customer AS c ON c.customer_id = o.customer_id
WHERE c.grade >= 200;

SELECT ord_no, cust_name, commission AS "Commission%", purch_amt*commission AS "Commission" FROM salesman,orders,customer WHERE orders.customer_id = customer.customer_id AND orders.salesman_id = salesman.salesman_id AND customer.grade>=200;

/*

8. From the following table, write a SQL query to find those customers who placed orders on October 5, 2012.
Return customer_id, cust_name, city, grade, salesman_id, ord_no, purch_amt, ord_date, customer_id and salesman_id.

Sample table: customer
Sample table: salesman
Sample table: orders

*/

SELECT c.*, o.ord_no, o.purch_amt, o.ord_date, s.name
FROM customer AS c
JOIN orders AS o ON c.customer_id = o.customer_id AND o.ord_date = "2012-10-05"
JOIN salesman AS s ON s.salesman_id = o.salesman_id;