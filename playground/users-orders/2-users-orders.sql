/*
1. INNER JOIN
Question: Retrieve records of users who have at least one associated order.
*/

SELECT u.*, o.*
FROM users AS u
INNER JOIN orders AS o ON u.user_id = o.user_id;

# Explanation: The INNER JOIN retrieves only those users and orders where user_id exists in both tables.

/*
2. FULL OUTER JOIN (Alternative in MySQL)
Question: Retrieve all users and orders, including records that do not have a match in the other table.
*/

SELECT u.*, o.*
FROM users AS u
LEFT JOIN orders AS o ON u.user_id = o.user_id
UNION
SELECT u.*, o.*
FROM users AS u
RIGHT JOIN orders AS o ON u.user_id = o.user_id;

# Explanation: Since MySQL does not support FULL JOIN, we use a combination of LEFT JOIN and RIGHT JOIN combined with UNION to achieve the same result. This includes all matching and non-matching rows from both tables.

/*
3. FULL OUTER JOIN with NULL filters (Alternative in MySQL)
Question: Retrieve users and orders that do not have a match in the other table.
*/

SELECT u.*, o.*
FROM users AS u
LEFT JOIN orders AS o ON u.user_id = o.user_id
WHERE o.user_id IS NULL
UNION
SELECT u.*, o.*
FROM users AS u
RIGHT JOIN orders AS o ON u.user_id = o.user_id
WHERE u.user_id IS NULL;

# Explanation: This retrieves rows where a user has no orders (o.user_id IS NULL) and rows where an order has no associated user (u.user_id IS NULL).

/*
4. LEFT JOIN
Question: Retrieve all users and their associated orders, if any.
*/

SELECT u.*, o.*
FROM users AS u
LEFT JOIN orders AS o ON u.user_id = o.user_id;

# Explanation: The LEFT JOIN includes all records from users and their matching rows from orders. If no match exists, the orders columns will contain NULL.

/*
5. LEFT JOIN with NULL filter
Question: Retrieve users who do not have any associated orders.
*/

SELECT u.*, o.*
FROM users AS u
LEFT JOIN orders AS o ON u.user_id = o.user_id
WHERE o.user_id IS NULL;

# Explanation: This query fetches all users for whom no matching row exists in orders.

/*
6. RIGHT JOIN
Question: Retrieve all orders and their associated users, if any.
*/

SELECT u.*, o.*
FROM users AS u
RIGHT JOIN orders AS o ON u.user_id = o.user_id;

# Explanation: The RIGHT JOIN includes all records from orders and their matching rows from users. If no match exists, the users columns will contain NULL.

/*
7. RIGHT JOIN with NULL filter
Question: Retrieve orders that do not have any associated user.
*/

SELECT u.*, o.*
FROM users AS u
RIGHT JOIN orders AS o ON u.user_id = o.user_id
WHERE u.user_id IS NULL;

# Explanation: This query fetches all orders for which no matching row exists in users.

/*

SELECT u.username, o.order_id FROM users AS u JOIN orders AS o ON u.user_id = o.user_id;

SELECT u.username, o.order_id FROM users AS u LEFT JOIN orders AS o ON u.user_id = o.user_id;

SELECT u.username, o.order_id FROM users AS u RIGHT JOIN orders AS o ON u.user_id = o.user_id;

(SELECT u.username, o.order_id FROM users AS u LEFT JOIN orders AS o ON u.user_id = o.user_id) UNION (SELECT u.username, o.order_id FROM users AS u RIGHT JOIN orders AS o ON u.user_id = o.user_id);

*/