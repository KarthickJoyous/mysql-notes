CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30)
);

-- UNSIGNED

/*

    In MySQL, the unsigned keyword is used to define a column that cannot store negative values.
    It applies only to numeric data types such as INT, BIGINT, SMALLINT, TINYINT, etc.

    When a column is defined as unsigned, 
        its range of possible values shifts entirely to the positive side, 
        effectively doubling the maximum positive value it can store compared to the signed version.

    Example for BIGINT:
        Signed BIGINT:
            Range: -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807

        Unsigned BIGINT:
            Range: 0 to 18,446,744,073,709,551,615
*/

-- Not Exists 
-- Will not create a table called users, if one already exits.
-- if users table already exists, running this create table query will throw an error users table already exists.

CREATE TABLE IF NOT EXISTS users(
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30)
);

-- Creating a table with foreign (No parent-child relational link defined)

CREATE TABLE orders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL
);

DROP table orders;

-- Creating a table with foreign key REFERENCES (parent-child relational link defined)

CREATE TABLE orders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id)
);

/*
    -- If a foreign key defined in the above way, delete users is restricted untill user has 0 orders.
    -- If tries to delete user with orders exists, SQL will throw an error.
        -- The orders table has a column user_id that references the id column in the users table. 
        -- This relationship ensures that every value in user_id in the orders table must correspond to a valid id in the users table.
        -- The constraint prevents you from deleting the parent row in users because it would leave orphan rows in the orders table, violating the foreign key relationship.
    -- If you want to delete user, delete all orders, then delete the user.
*/

-- Another solution with cascade 

CREATE TABLE orders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- With the above Create table scheme, when an user is deleted, his orders will also be deleted automatically.

# Timestamp :

CREATE TABLE orders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- No need to specify value for created_at, updated_at on order creation, SQL will automatically store the timestamp of order creation.
-- No need to specify value for updated_at on order updation, SQL will automatically store the timestamp of order updation.
-- Note : CURRENT_TIMESTAMP will store the timestamp value server's TIMEZONE.

# UNIQUE :

DROP TABLE IF EXISTS workers;

CREATE TABLE workers (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE
);

-- if an row with email(karthick@app.com) exists,
    -- tries to create an another row with email(karthick@app.com),
    -- SQL will throw an error saying duplicate entry.

CREATE TABLE orders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    UNIQUE(user_id, product_id)
);

-- In this case, the combination of user_id and product_id must be unique,
    -- meaning a user can't order the same product more than once, even if they place multiple orders.

DROP TABLE IF EXISTS orders_duplicate, workers_duplicate;

-- CREATE table from existing table (Primary keys and indexes will be preserved when creating tables from tables)

CREATE TABLE orders_duplicate LIKE orders;

-- Create table from select statment (Primary keys and indexes will not be preserved when creating tables from SELECT)

CREATE TABLE workers_duplicate SELECT * from workers;

-- Create table from select statment with primary key :

CREATE TABLE workers_duplicate (PRIMARY KEY(id)) SELECT * from workers;

-- Create table from select statment with specific columns

CREATE TABLE workers_duplicate SELECT email from workers;