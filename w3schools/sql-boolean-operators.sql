# Link : https://www.w3resource.com/sql-exercises/sql-boolean-operators.php

/*

1. Customers with Grade > 100

From the following table, write a SQL query to locate the details of customers with grade values above 100.
Return customer_id, cust_name, city, grade, and salesman_id. 

Sample table: customer

*/

SELECT * FROM customer WHERE grade > 100;

/*

2. New York Customers with Grade > 100

From the following table, write a SQL query to find all the customers in ‘New York’ city who have a grade value above 100. Return customer_id, cust_name, city, grade, and salesman_id.  
Sample table: customer

*/

SELECT * FROM customer WHERE city = 'New York' AND grade > 100;

/*

3. New York or Grade > 100

From the following table, write a SQL query to find customers who are from the city of New York or have a grade of over 100.
Return customer_id, cust_name, city, grade, and salesman_id.  
Sample table: customer

*/

SELECT * FROM customer WHERE city = 'New York' OR grade > 100;

/*

4. New York or Not Grade > 100

From the following table, write a SQL query to find customers who are either from the city 'New York' or who do not have a grade greater than 100.
Return customer_id, cust_name, city, grade, and salesman_id.  
Sample table: customer

*/

SELECT * FROM customer WHERE city = 'New York' OR NOT grade > 100;
SELECT * FROM customer WHERE city = 'New York' OR grade <= 100;

/*

5. Not New York and Not Grade > 100

From the following table, 
write a SQL query to identify customers who are not from the city of 'New York' and do not have a grade value greater than 100.
Return customer_id, cust_name, city, grade, and salesman_id.
Sample table: customer

*/

SELECT * FROM customer WHERE NOT (city = 'New York' OR grade > 100);
SELECT * FROM customer WHERE city != 'New York' AND grade <= 100;

/*

6. Exclude Specific Orders

From the following table, 
write a SQL query to find details of all orders excluding those with ord_date equal to '2012-09-10' and salesman_id higher than 5005 or purch_amt greater than 1000.
Return ord_no, purch_amt, ord_date, customer_id and salesman_id.  
Sample table : orders

*/

SELECT * FROM orders WHERE NOT ((ord_date = '2012-09-10' AND salesman_id > 5005) OR (purch_amt > 1000));

/*

7. Salespeople with Commission Range 0.10-0.12

From the following table, write a SQL query to find the details of those salespeople whose commissions range from 0.10 to 0.12.
Return salesman_id, name, city, and commission. 
Sample table : salesman

*/

SELECT salesman_id, name, city, commission FROM salesman WHERE commission BETWEEN 0.10 AND 0.12;

/*

8. Orders with Amount < 200 or Exclusions

From the following table, 
write a SQL query to find details of all orders
    with a purchase amount less than 200 or exclude orders with an order date greater than or equal to '2012-02-10' and a customer ID less than 3009.
Return ord_no, purch_amt, ord_date, customer_id and salesman_id.
Sample table : orders

*/

SELECT * FROM orders WHERE purch_amt < 200 OR NOT (ord_date >= '2012-02-10' AND customer_id < 3009);

/*

9. Conditional Orders Exclusions

From the following table, write a SQL query to find all orders that meet the following conditions.
Exclude combinations of order date equal to '2012-08-17' or customer ID greater than 3005 and purchase amount less than 1000.
Sample table : orders

*/

SELECT * FROM orders WHERE NOT ((ord_date = '2012-08-17') OR (customer_id > 3005 AND purch_amt < 1000));

/*

10. Orders with Achieved Percentage > 50%

Write a SQL query that displays order number, purchase amount, and the achieved and unachieved percentage (%) for those orders that exceed 50% of the target value of 6000.  
Sample table: orders

*/

SELECT ord_no, purch_amt, ((purch_amt/6000) * 100) as acheived, 6000 - ((purch_amt/6000) * 100) as unachieved FROM orders WHERE ((purch_amt/6000) * 100) > 50;

/*

11. Employees with Last Name Dosni or Mardy

From the following table, write a SQL query to find the details of all employees whose last name is ‘Dosni’ or ‘Mardy’.
Return emp_idno, emp_fname, emp_lname, and emp_dept.  
Sample table : emp_details

*/

SELECT * FROm emp_details WHERE emp_lname = 'Dosni' OR emp_lname = 'Mardy';
SELECT * FROm emp_details WHERE emp_lname IN('Dosni', 'Mardy');

/*

12. Employees in Department 47 or 63

From the following table, write a SQL query to find the employees who work at depart 47 or 63.
Return emp_idno, emp_fname, emp_lname, and emp_dept.  

Sample table : emp_details

*/

SELECT * FROM emp_details WHERE emp_dept = 47 OR emp_dept = 63;
SELECT * FROM emp_details WHERE emp_dept IN(47,63);

/*
5 % of 60 = (5/100) * 60;
15 is what % of 60 = (15/60) * 100;
*/