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

CREATE TABLE products(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name varchar(200),
	category_id INT DEFAULT NULL
);

INSERT INTO products (name, category_id)
VALUE 
('product 1', 1),
('product 2', 2),
('product 3', 3),
('product 4', 1),
('product 5', 3),
('product 6', 2),
('product 7', 4),
('product 8', 5),
('product 9', 2),
('product 10', 1),
('product 11', 6),
('product 12', NULL),
('product 13', NULL),
('product 14', 3),
('product 15', 6),
('product 16', 4),
('product 17', 2),
('product 18', 4),
('product 19', NULL),
('product 20', NULL);

CREATE TABLE categories(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name varchar(200)	
);

INSERT INTO categories (name)
VALUE 
('Category 1'),
('Category 2'),
('Category 3'),
('Category 4'),
('Category 5'),
('Category 6');

CREATE TABLE order_products(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	order_id INT,
    product_id INT
);

INSERT INTO order_products (order_id, product_id)
VALUES
(1,1),
(1,2),
(1,4),
(1,5),
(2,11),
(3,7),
(4,2),
(4,4),
(4,19),
(5,18),
(5,10),
(5,9),
(5,6),
(5,5),
(6,11),
(6,9),
(6,14),
(7,3),
(7,5),
(7,12),
(7,18),
(8,1),
(8,9),
(8,13),
(8,15),
(9,4),
(9,6),
(9,8),
(9,16),
(10,2),
(10,10),
(10,14),
(10,20),
(11,7),
(11,11),
(11,3),
(11,5),
(12,8),
(12,12),
(12,17),
(12,19),
(13,4),
(13,6),
(13,9),
(13,15),
(14,2),
(14,11),
(14,14),
(14,18),
(15,1),
(15,5),
(15,7),
(15,13);