# Link : https://www.w3resource.com/sql-exercises/sql-aggregate-functions.php

SELECT * FROM orders;

SELECT * FROM customer;

SELECT * FROM salesman;

SELECT * FROM item_mast;

SELECT * FROM emp_department;

SELECT * FROM emp_details;

CREATE TABLE emp_department (
    DPT_CODE INT NOT NULL,
    DPT_NAME VARCHAR(50) NOT NULL,
    DPT_ALLOTMENT DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (DPT_CODE)
);

INSERT INTO emp_department (DPT_CODE, DPT_NAME, DPT_ALLOTMENT) VALUES
(57, 'IT', 65000.00),
(63, 'Finance', 15000.00),
(47, 'HR', 240000.00),
(27, 'RD', 55000.00),
(89, 'QC', 75000.00);

/*

1. From the following table, write a SQL query to calculate total purchase amount of all orders.
Return total purchase amount.

Sample table: orders

*/

SELECT SUM(purch_amt) FROM orders;

/*

2. From the following table, write a SQL query to calculate the average purchase amount of all orders.
Return average purchase amount. 

Sample table: orders

*/

SELECT AVG(purch_amt) FROM orders;

/*

3. From the following table, write a SQL query that counts the number of unique salespeople.
Return number of salespeople.  

Sample table: orders

*/

SELECT COUNT(DISTINCT salesman_id) FROM orders;

/*

4. From the following table, write a SQL query to count the number of customers.
Return number of customers.  

Sample table: customer

*/

SELECT COUNT(DISTINCT customer_id) FROM orders;

/*

5. From the following table, write a SQL query to determine the number of customers who received at least one grade for their activity.  

Sample table: customer

*/

SELECT COUNT(*) FROM customer WHERE grade IS NOT NULL;

-- These below queries counts the total number of rows where the 'grade' column is not NULL in the 'customer' table.
-- Both queries are same.
-- Since ALL is the default behavior, it is rarely explicitly stated in SQL queries.
-- Including it might only serve to make the intention clear, but it is unnecessary in most cases.

SELECT COUNT(grade) FROM customer;

SELECT COUNT(ALL grade) FROM customer; -- The keyword ALL is redundant and does not change the meaning of the statement.

/*

6. From the following table, write a SQL query to find the maximum purchase amount.  

Sample table: orders

*/

SELECT MAX(purch_amt) FROM orders;

/*

7. From the following table, write a SQL query to find the minimum purchase amount. 

Sample table: orders

*/

SELECT MIN(purch_amt) FROM orders;

/*

8. From the following table, write a SQL query to find the highest grade of the customers in each city.
Return city, maximum grade.  

Sample table: customer

*/

SELECT city, MAX(grade) FROM customer GROUP BY city;

/*

9. From the following table, write a SQL query to find the highest purchase amount ordered by each customer.
Return customer ID, maximum purchase amount. 

Sample table: orders

*/

SELECT customer_id, MAX(purch_amt) FROM orders GROUP BY customer_id;

/*

10. From the following table, write a SQL query to find the highest purchase amount ordered by each customer on a particular date.
Return, order date and highest purchase amount.

Sample table: orders

*/

SELECT customer_id, ord_date, MAX(purch_amt) FROM orders GROUP BY customer_id, ord_date;

/*

11. From the following table, write a SQL query to determine the highest purchase amount made by each salesperson on '2012-08-17'.
Return salesperson ID, purchase amount 

Sample table: orders

*/

SELECT salesman_id, MAX(purch_amt) FROM orders WHERE ord_date = "2012-08-17" GROUP BY salesman_id;

/*

12. From the following table, write a SQL query to find the highest order (purchase) amount by each customer on a particular order date.
Filter the result by highest order (purchase) amount above 2000.00.
Return customer id, order date and maximum purchase amount.

Sample table: orders

*/

SELECT customer_id, ord_date, MAX(purch_amt) as  highest_order FROM orders GROUP BY customer_id, ord_date HAVING highest_order > 2000;

/*

13. From the following table, 
write a SQL query to find the maximum order (purchase) amount in the range 2000 - 6000 (Begin and end values are included.) by combination of each customer and order date.
Return customer id, order date and maximum purchase amount.

Sample table: orders

*/

SELECT customer_id, ord_date, MAX(purch_amt) as max_amt FROM orders GROUP BY customer_id, ord_date HAVING max_amt BETWEEN 2000 AND 6000;

/*

14. From the following table, write a SQL query to find the maximum order (purchase) amount based on the combination of each customer and order date.
Filter the rows for maximum order (purchase) amount is either 2000, 3000, 5760, 6000.
Return customer id, order date and maximum purchase amount.

Sample table: orders

*/

SELECT customer_id, ord_date, MAX(purch_amt) as max_order FROM orders GROUP BY 1,2 HAVING max_order IN (2000,3000,5760,6000);

/*

15. From the following table, write a SQL query to determine the maximum order amount for each customer.
The customer ID should be in the range 3002 and 3007(Begin and end values are included.).
Return customer id and maximum purchase amount.

Sample table: orders

*/

SELECT customer_id, MAX(purch_amt) as max_amt FROM orders WHERE customer_id BETWEEN 3002 AND 3007 GROUP BY 1;

/*

16. From the following table, write a SQL query to find the maximum order (purchase) amount for each customer.
The customer ID should be in the range 3002 and 3007(Begin and end values are included.).
Filter the rows for maximum order (purchase) amount is higher than 1000.
Return customer id and maximum purchase amount.

Sample table: orders

*/

SELECT customer_id, MAX(purch_amt) as max_amt FROM orders WHERE customer_id BETWEEN 3002 AND 3007 GROUP BY 1 HAVING max_amt > 1000;

/*

17. From the following table, write a SQL query to determine the maximum order (purchase) amount generated by each salesperson.
Filter the rows for the salesperson ID is in the range 5003 and 5008 (Begin and end values are included.).
Return salesperson id and maximum purchase amount.

Sample table: orders

*/

SELECT salesman_id, MAX(purch_amt) FROM orders WHERE salesman_id BETWEEN 5003 AND 5008 GROUP BY 1;

/*

18. From the following table, write a SQL query to count all the orders generated on '2012-08-17'.
Return number of orders.

Sample table: orders

*/

SELECT COUNT(*) FROM orders WHERE ord_date = "2012-08-17";

/*

19. From the following table, write a SQL query to count the number of salespeople in a city.
Return number of salespeople.

Sample table: salesman

*/

SELECT COUNT(city) FROM salesman;

/*

20. From the following table, write a SQL query to count the number of orders based on the combination of each order date and salesperson.
Return order date, salesperson id.

Sample table: orders

*/

SELECT ord_date, salesman_id, COUNT(*) FROM orders GROUP BY 1,2;

/*

21. From the following table, write a SQL query to calculate the average product price. Return average product price.

Sample table: item_mast

*/

SELECT AVG(pro_price) FROM item_mast;

/*

22. From the following table, write a SQL query to count the number of products whose price are higher than or equal to 350.
Return number of products.

Sample table: item_mast

*/

SELECT COUNT(*) FROM item_mast WHERE pro_price >= 350;

/*

23. From the following table, write a SQL query to compute the average price for unique companies.
Return average price and company id.

Sample table: item_mast

*/

SELECT * FROM item_mast;

SELECT pro_com, AVG(pro_price) FROM item_mast GROUP BY 1;

/*

24. From the following table, write a SQL query to compute the sum of the allotment amount of all departments.
Return sum of the allotment amount.

Sample table: emp_department

*/

SELECT SUM(DPT_ALLOTMENT) FROM emp_department;

/*

25. From the following table, write a SQL query to count the number of employees in each department.
Return department code and number of employees.

Sample table: emp_details

*/

SELECT emp_dept, COUNT(*) FROM emp_details GROUP BY 1;