/*

One To Many :

*/

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_amount DECIMAL(10,2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, email, created_at) VALUES
('User1', 'user1@example.com', NOW() - INTERVAL FLOOR(1 + RAND() * 100) MONTH),
('User2', 'user2@example.com', NOW() - INTERVAL FLOOR(1 + RAND() * 80) MONTH),
('User3', 'user3@example.com', NOW() - INTERVAL FLOOR(1 + RAND() * 60) MONTH),
('User4', 'user4@example.com', NOW() - INTERVAL FLOOR(1 + RAND() * 40) MONTH),
('User5', 'user5@example.com', NOW() - INTERVAL FLOOR(1 + RAND() * 20) MONTH);

INSERT INTO orders (user_id, order_amount, order_date) VALUES
(2, 100.50, NOW() - INTERVAL FLOOR(1 + RAND() * 10) MONTH);

INSERT INTO orders (user_id, order_amount, order_date) VALUES
(3, 25.00, NOW() - INTERVAL FLOOR(1 + RAND() * 30) MONTH),
(3, 50.75, NOW() - INTERVAL FLOOR(1 + RAND() * 30) MONTH),
(3, 75.20, NOW() - INTERVAL FLOOR(1 + RAND() * 30) MONTH),
(3, 150.00, NOW() - INTERVAL FLOOR(1 + RAND() * 30) MONTH),
(3, 200.00, NOW() - INTERVAL FLOOR(1 + RAND() * 30) MONTH);

INSERT INTO orders (user_id, order_amount, order_date) VALUES
(4, 80.00, NOW() - INTERVAL FLOOR(1 + RAND() * 20) MONTH),
(4, 120.00, NOW() - INTERVAL FLOOR(1 + RAND() * 20) MONTH);

INSERT INTO orders (user_id, order_amount, order_date) VALUES
(5, 45.50, NOW() - INTERVAL FLOOR(1 + RAND() * 15) MONTH),
(5, 60.00, NOW() - INTERVAL FLOOR(1 + RAND() * 15) MONTH),
(5, 75.75, NOW() - INTERVAL FLOOR(1 + RAND() * 15) MONTH);

INSERT INTO orders (user_id, order_amount, order_date) VALUES
(0, 35.00, NOW() - INTERVAL FLOOR(1 + RAND() * 15) MONTH),
(0, 90.30, NOW() - INTERVAL FLOOR(1 + RAND() * 15) MONTH),
(0, 38.85, NOW() - INTERVAL FLOOR(1 + RAND() * 15) MONTH),
(0, 75.39, NOW() - INTERVAL FLOOR(1 + RAND() * 15) MONTH);

/*

This schema creates:

    User1: No orders.
    User2: 1 order.
    User3: Many orders.
    User4: 2 orders.
    User5: 3 orders.
    No User: 4 orders.

*/

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