-- Notes on Result Sets for LEFT JOIN Queries

-- Query 1:
-- Retrieves all rows from the users table regardless of whether they have matching rows in the orders table.
-- If a user has no matching order, the columns from the orders table will have NULL values.
-- Example:
-- user_id | user_name | order_id | order_amount
-- -------------------------------------------------
-- 1       | John      | 101      | 500
-- 2       | Alice     | NULL     | NULL   (no orders)

SELECT * FROM `users` AS u 
LEFT JOIN orders AS o ON u.user_id = o.user_id;

-- Query 2:
-- Retrieves all rows from the users table, but only includes details of orders where order_amount > 1000.
-- If a user has orders but none satisfy order_amount > 1000, the orders columns will have NULL.
-- Example:
-- user_id | user_name | order_id | order_amount
-- -------------------------------------------------
-- 1       | John      | NULL     | NULL   (order < 1000)
-- 2       | Alice     | NULL     | NULL   (no orders)
-- 3       | Bob       | 202      | 1500   (order > 1000)

SELECT * FROM `users` AS u 
LEFT JOIN orders AS o ON u.user_id = o.user_id AND o.order_amount > 1000;

-- Query 3:
-- Filters out rows where order_amount <= 1000 or there are no matching orders.
-- Effectively excludes users without orders or those with orders that don’t satisfy order_amount > 1000.
-- Only users with matching orders having order_amount > 1000 will appear in the result.
-- Example:
-- user_id | user_name | order_id | order_amount
-- -------------------------------------------------
-- 3       | Bob       | 202      | 1500

SELECT * FROM `users` AS u 
LEFT JOIN orders AS o ON u.user_id = o.user_id 
WHERE o.order_amount > 1000;

-- Key Points for Reference:
-- LEFT JOIN Behavior:
-- Ensures all rows from the LEFT table (users) are included, even if there are no matches in the RIGHT table (orders).
-- NULL is returned in the RIGHT table's columns when no match is found.

-- ON Clause vs. WHERE Clause:
-- The ON clause filters rows during the join operation.
-- The WHERE clause filters rows after the join is complete, potentially excluding unmatched rows from the LEFT table.

-- Practical Uses:
-- Query 1: To get all users and their orders, showing NULL for users without orders.
-- Query 2: To get all users, but only include details of orders meeting specific conditions.
-- Query 3: To get only users with orders meeting specific conditions, excluding users without such orders.

-- <------------------------------------------------------------------------------------------------------------>

-- Query 1:
-- Retrieves only users who have at least one order with order_amount > 1000.
-- First, the INNER JOIN retrieves rows where u.user_id = o.user_id (users who have matching orders).
-- After the join, the WHERE o.order_amount > 1000 condition is applied to filter the results.
-- Excludes any rows where order_amount <= 1000.
-- Example:
-- user_id | user_name | order_id | order_amount
-- --------------------------------------------
-- 3       | Bob       | 202      | 1500

SELECT * FROM `users` AS u 
INNER JOIN orders AS o ON u.user_id = o.user_id 
WHERE o.order_amount > 1000;

-- Query 2:
-- Retrieves only users who have at least one order with order_amount > 1000.
-- The INNER JOIN only retrieves rows where both conditions are true:
-- - u.user_id = o.user_id (users with matching orders).
-- - o.order_amount > 1000 (only orders with an amount greater than 1000).
-- Filtering happens during the join process, and rows that don’t satisfy o.order_amount > 1000 are excluded upfront.
-- Example:
-- user_id | user_name | order_id | order_amount
-- --------------------------------------------
-- 3       | Bob       | 202      | 1500

SELECT * FROM `users` AS u 
INNER JOIN orders AS o ON u.user_id = o.user_id AND o.order_amount > 1000;

-- Key Differences:
-- Aspect                 | Query 1 (WHERE Clause)          | Query 2 (ON Clause)
-- ----------------------------------------------------------------------------------
-- Condition Location     | Filters rows after the join.    | Filters rows during the join.
-- Performance            | Slightly less efficient (joins all rows, then filters). | Potentially more efficient (filters before joining).
-- Result Set             | Identical to Query 2 for this case. | Identical to Query 1 for this case.

-- Practical Implications:
-- Query 2 (ON clause) can be better for performance, especially when the condition significantly reduces the number of rows being joined.
-- Query 1 (WHERE clause) is often used when the filtering logic depends on the combined results of the join.
-- Both queries produce the same result for this specific case, but the ON clause is generally preferred for filtering criteria directly related to the join condition.
