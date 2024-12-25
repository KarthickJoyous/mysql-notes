/*
Subqueries in SQL are classified based on their structure, purpose, and relationship with the outer query. Here are the main types:
1. Based on Dependency:
1.1 Correlated Subqueries

    Definition: A subquery that depends on values from the outer query for its execution.
    Execution: Evaluated once for each row processed by the outer query.
    Use Case: When the subquery needs to calculate results for each row in the outer query.
*/
# Example:

SELECT ord_no, purch_amt 
FROM orders AS a
WHERE purch_amt > 
    (SELECT AVG(purch_amt) 
     FROM orders AS b 
     WHERE b.customer_id = a.customer_id);

    # Here, the subquery calculates the average purchase amount for the customer_id of the current row (a.customer_id).

/*
1.2 Non-Correlated Subqueries

    Definition: A subquery that is independent of the outer query; it does not rely on the outer query’s values.
    Execution: Evaluated only once, and the result is reused for the entire outer query.
    Use Case: When the subquery computes a global result or a static set of values.
*/

# Example:

SELECT ord_no, purch_amt 
FROM orders
WHERE purch_amt > (SELECT AVG(purch_amt) FROM orders);

    # The subquery calculates the overall average purchase amount, which is reused for all rows.

/*
2. Based on Number of Returned Rows:
2.1 Single-Row Subqueries

    Definition: A subquery that returns exactly one row and one column.
    Use Case: When the outer query expects a single value as a result.
    Operator Compatibility: Can be used with comparison operators such as =, <, >, etc.
*/

# Example:

SELECT * 
FROM orders
WHERE purch_amt > (SELECT MAX(purch_amt) FROM orders);

# The subquery returns a single value: the maximum purchase amount.

/*
2.2 Multi-Row Subqueries

    Definition: A subquery that returns multiple rows.
    Use Case: When the outer query needs to compare values with a set of results.
    Operator Compatibility: Works with operators like IN, ANY, ALL.
*/

# Examples:

    Using IN:

SELECT ord_no, purch_amt 
FROM orders
WHERE customer_id IN (SELECT customer_id FROM customers WHERE city = 'New York');

    # The subquery returns a list of customer IDs, and the outer query matches them.

# Using ANY:

    SELECT ord_no, purch_amt 
    FROM orders
    WHERE purch_amt > ANY (SELECT purch_amt FROM orders WHERE customer_id = 3005);

        # The outer query compares purch_amt against any value in the subquery result.

/*

2.3 Scalar Subqueries

    Definition: A subquery that returns exactly one value (one row and one column), which can be used in expressions.
    Use Case: When a single computed value is needed in the outer query.
    Common Usage: In the SELECT or WHERE clauses.
*/

# Example:

SELECT ord_no, purch_amt, 
       (SELECT AVG(purch_amt) FROM orders) AS avg_purch_amt
FROM orders;

    #The subquery calculates the average purchase amount and uses it as a column in the outer query.

/*

3. Based on Placement in the Query:
3.1 Subqueries in the WHERE Clause

    The most common use of subqueries.
    Used to filter results based on computed values.
*/
# Example:

SELECT * 
FROM orders
WHERE purch_amt > (SELECT AVG(purch_amt) FROM orders);

/*

3.2 Subqueries in the FROM Clause (Inline Views)

    Used to create a derived table or inline view.
    The result of the subquery is treated as a temporary table.
*/

# Example:

SELECT customer_id, AVG(purch_amt) AS avg_purch_amt
FROM (SELECT * FROM orders WHERE ord_date > '2022-01-01') AS recent_orders
GROUP BY customer_id;

/*

3.3 Subqueries in the SELECT Clause

    Used to compute a value for each row in the result.
*/

# Example:

SELECT ord_no, 
       (SELECT AVG(purch_amt) FROM orders WHERE customer_id = o.customer_id) AS avg_customer_amt
FROM orders o;

    # The subquery calculates the customer-specific average and includes it in the output.

/*
4. Special Subqueries:
4.1 Exists Subqueries

    Definition: Tests for the existence of rows in the subquery.
    Returns: TRUE if the subquery returns any rows; otherwise, FALSE.
    Use Case: To check whether a condition is met.
*/

# Example:

SELECT ord_no 
FROM orders
WHERE EXISTS (SELECT 1 FROM customers WHERE customers.customer_id = orders.customer_id);

/*
4.2 Not Exists Subqueries

    Similar to EXISTS, but returns TRUE if the subquery returns no rows.
*/

# Example:

SELECT ord_no 
FROM orders
WHERE NOT EXISTS (SELECT 1 FROM customers WHERE customers.customer_id = orders.customer_id);
/*

Summary of Subquery Types:

Type	|   Purpose

Correlated Subquery	| Dependent on outer query; executes once per row in the outer query.
Non-Correlated Subquery	| Independent of outer query; executes only once.
Single-Row Subquery	| Returns one row and one column.
Multi-Row Subquery	| Returns multiple rows; used with IN, ANY, or ALL.
Scalar Subquery	| Returns a single value; used in expressions.
Subquery in WHERE Clause	Filters rows based on a condition.
Subquery in FROM Clause	Creates an inline view or temporary table.
Subquery in SELECT Clause	Computes a value for each row.
EXISTS Subquery	| Checks if rows exist in the subquery result.
NOT EXISTS Subquery	| Checks if no rows exist in the subquery result.
*/