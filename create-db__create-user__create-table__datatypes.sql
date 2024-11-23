/*

The file consists explanations of : 

create & use database;
show & describe tables;

create-user with privileges & grant permission to create user.

create-table-with-datatypes.

Description & Use case of data types.

*/

CREATE DATABASE playground;

use playground;

show tables;

DESCRIBE users;

CREATE USER 'userName'@'localhost' IDENTIFIED BY 'some_password'; -- Connect from only localhost

CREATE USER 'userName'@'%' IDENTIFIED BY 'some_password'; -- Connect from anywhere except localhost

GRANT SELECT, INSERT, UPDATE ON databaseName.* TO 'userName'@'localhost'; -- Give SELECT, INSERT, UPDATE privileges to given DB

GRANT SELECT, INSERT, UPDATE ON *.* TO 'userName'@'localhost'; -- Give SELECT, INSERT, UPDATE privileges to all DB.

GRANT SELECT, INSERT, UPDATE ON *.* TO 'userName'@'localhost' WITH GRANT OPTION; -- Give SELECT, INSERT, UPDATE privileges to all DB with Create New User privilege.

GRANT ALL ON *.* TO 'userName'@'localhost' WITH GRANT OPTION; -- Give all privileges to all DB with Create New User privilege.

/* ---------------------- */

CREATE DATABASE SampleDB;

USE SampleDB;

CREATE TABLE user (
    user_id BIGINT PRIMARY KEY,
    username CHAR(50),
    email VARCHAR(100),
    birth_date DATE,
    registration_datetime DATETIME,
    last_login TIMESTAMP,
    signup_year YEAR,
    login_time TIME,
    status TINYINT,
    age SMALLINT,
    score MEDIUMINT,
    total_logins INT,
    total_points BIGINT,
    balance DECIMAL(10, 2),
    account_limit NUMERIC(12, 2),
    transaction_rate FLOAT,
    discount_rate DOUBLE
);

/* ---------------------- */

INSERT INTO user (user_id, username, email, birth_date, registration_datetime, last_login, signup_year, login_time, status, age, score, total_logins, total_points, balance, account_limit, transaction_rate, discount_rate) 
VALUES 
(1, 'JohnDoe', 'johndoe@example.com', '1990-05-10', '2024-11-10 14:30:00', CURRENT_TIMESTAMP, 2024, '14:30:00', 1, 34, 1200, 50, 5000, 1500.75, 20000.00, 1.5, 0.15),

(2, 'JaneSmith', 'janesmith@example.com', '1985-09-20', '2024-11-11 10:00:00', CURRENT_TIMESTAMP, 2024, '10:00:00', 1, 39, 1300, 60, 7500, 2500.50, 30000.00, 2.0, 0.20),

(3, 'AlexJones', 'alexjones@example.com', '1992-12-01', '2024-11-11 09:00:00', CURRENT_TIMESTAMP, 2024, '09:00:00', 0, 31, 1400, 40, 6000, 1800.00, 15000.00, 1.2, 0.10);

/* ---------------------- */

/* When to use & What are the use case of these DataTypes :

CHAR, VARCHAR

DECIMAL, NUMERIC

FLOAT, DOUBLE

Here’s a brief explanation of each type and their typical use cases:
1. CHAR vs. VARCHAR

    CHAR:
        Use Case: Fixed-length strings, like fixed-length codes, or ISO country codes ('US', 'FR'), where all values have the same length.
        Characteristics: Allocates a fixed amount of storage regardless of the actual string length (padded with spaces if shorter). Faster for fixed-length data but uses more space for variable-length strings.

    VARCHAR:
        Use Case: Variable-length strings, such as names, email addresses, descriptions, or comments where the length may vary.
        Characteristics: Allocates storage only for the actual string length (plus a small overhead). Optimized for data with variable lengths but slightly slower than CHAR for fixed-length strings.

2. DECIMAL vs. NUMERIC

    DECIMAL and NUMERIC are effectively the same in many databases (including MySQL and PostgreSQL).
        Use Case: Precise decimal values, such as currency, financial calculations, or any data where exact precision is crucial (e.g., 123.45, 0.123).
        Characteristics: Allows you to define a fixed precision and scale (number of digits and decimal places), preventing rounding errors typical in floating-point arithmetic. DECIMAL(10,2) would mean 10 total digits, 2 of which are after the decimal.

3. FLOAT vs. DOUBLE

    FLOAT:
        Use Case: Scientific measurements, large datasets, or other scenarios where slight precision loss is acceptable but memory savings are important.
        Characteristics: Uses less storage than DOUBLE but has lower precision (usually around 7 decimal digits). Suitable for values that don’t require high accuracy.

    DOUBLE:
        Use Case: High-precision calculations, such as complex scientific or statistical data, where more precision is needed than FLOAT can offer.
        Characteristics: Offers double the precision of FLOAT (up to about 15 decimal digits), but uses more memory.

Minimum & Maximul length fo these types :

    CHAR: MIN: CHAR(0) | MAX: CHAR(255)
    VARCHAR: MIN: VARCHAR(0) | MAX: VARCHAR(65535)
    DECIMAL / NUMERIC: MIN: DECIMAL(1,0) | MAX: DECIMAL(65,30)
    FLOAT: MIN: FLOAT(~7 decimal digits) | MAX: FLOAT(~7 decimal digits)
    DOUBLE: MIN: DOUBLE(~15 decimal digits) | MAX: DOUBLE(~15 decimal digits)

You said:

FLOAT(2,2) 

DOUBLE(12,12) 

is these are valid?

ChatGPT said:

No, these are not valid definitions for FLOAT or DOUBLE in most SQL databases. Unlike DECIMAL and NUMERIC, which allow you to specify precision and scale (e.g., DECIMAL(10,2)), FLOAT and DOUBLE do not support this syntax for defining precision and scale in SQL standards.

For FLOAT and DOUBLE, specifying (m, d) (precision and scale) is generally unsupported and would throw an error in most SQL implementations. Instead, they automatically handle precision based on their default storage allocation:

    FLOAT typically has a precision of around 7 decimal digits.
    DOUBLE typically has a precision of around 15 decimal digits.

To specify exact precision and scale for decimal values, use DECIMAL or NUMERIC instead.

----------------------

You said:

This is a valid query

CREATE TABLE examples (id BIGINT AUTO_INCREMENT PRIMARY KEY, point FLOAT(255, 30), score DOUBLE(255, 30));

ChatGPT said:

The query you provided is invalid because most SQL databases do not support specifying (m, d) (precision and scale) for FLOAT and DOUBLE types.

In MySQL, for example, the syntax FLOAT(m, d) and DOUBLE(m, d) is deprecated or unsupported in modern versions, as FLOAT and DOUBLE are approximate types rather than fixed-precision types.

If you want to specify precision and scale, you should use DECIMAL or NUMERIC instead, as they are designed for exact decimal representations. Here's a corrected version:
*/

CREATE TABLE examples (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    point DECIMAL(255, 30),
    score DECIMAL(255, 30)
);

-- If you require the use of FLOAT or DOUBLE, you should remove the (m, d) specifications:

CREATE TABLE examples (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    point FLOAT,
    score DOUBLE
);

-- This way, FLOAT and DOUBLE will provide approximate values without the exact precision and scale limitations, following their intended use in SQL.

/*

You said:

any othe these data types includes decimal points, will round any values. Example 9.999 will store as 10.00 by any chance

ChatGPT said:

Yes, certain data types can lead to rounding depending on their precision and scale settings, particularly DECIMAL and NUMERIC types when defined with a limited scale. Here’s how different types handle decimal points and rounding:
1. DECIMAL / NUMERIC

    Behavior: DECIMAL and NUMERIC types round to the nearest value based on the specified scale.
    Example: If you define DECIMAL(4, 2), it can store values with up to two decimal places. So, 9.999 would be stored as 10.00 because it rounds to fit within the (4, 2) precision and scale.

2. FLOAT / DOUBLE

    Behavior: FLOAT and DOUBLE are approximate data types, which means they don’t always store values with exact precision and may lead to slight rounding errors due to floating-point representation.
    Example: Storing 9.999 as a FLOAT or DOUBLE will generally retain the value as close to 9.999 as possible, but minor rounding errors may occur due to how floating-point arithmetic works, not to a fixed scale.

3. INTEGER TYPES (e.g., INT, BIGINT)

    Behavior: Integer types cannot store decimal points, so any decimal values will be truncated (not rounded).
    Example: 9.999 stored as an INT would simply become 9.

To avoid unexpected rounding, always choose a data type and specify the precision and scale that matches your expected data range and accuracy requirements, especially for financial or scientific calculations where exact precision is critical.

*/

CREATE TABLE examples (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    point_float FLOAT,
    score_double DOUBLE,
    decimal_two DECIMAL(30,10),
    decimal_three DECIMAL(30,10)
);

/*

Round will happen means, 
    -> if it exceed the limit and if last digit if [FLOAT, DOUBLT - equals or below 5 | DECIMAL - below 5], that last exceeded digit will be ignored (Ex : 9.999991, remains 9.99999).
    -> if it exceed the limit and if last digit if [FLOAT, DOUBLT - more than 5 | DECIMAL - Equals or more than 5], value will be increased to next higher value (Ex : 9.991998, will be 9.992 | 9.999999 will be 10)

Float (point FLOAT): 

    -> 1.99999 Will be stored as 1.99999, but 1.999999 will be stored as 2 (Single precision -> till 6 no round, if exceeds 6, will round it).
    -> 1.999991 will remains 1.99999, 1.999996 will remains 2.

Double (score DOUBLE): 

    -> 22.29999999999999 Will be stored as 22.29999999999999, but 22.299999999999999 will be stored as 22.3 (Double precision -> till 16 no round, if exceeds 16, will round it).
    -> 22.299999999999991 will remains 22.29999999999999, 22.299999999999999 will remains 22.3
    ---> 22.299999999999993 will not be 22.29999999999999, but 22.299999999999994. Inaccuracy problem. (Decimal don't have this problem)

Decimal (amount DECIMAL(30,10)) : 

    -> 33.3333333333 will be stored as 33.3333333333, but 33.33333333339 will be stored as 33.3333333334 (Exact precision -> so till 10 no round, if exceeds 16, will round it). 33.3333333333933333333333333333999 will be stored as 33.333333333393333333333333333400.
    -> 33.33333333334 will remains 33.3333333333. 33.33333333339 will be 33.3333333334
    -> 22.299999999999994 will remains 22.29999999999999, 22.299999999999995 & 22.299999999999998 will be 22.30000000000000

Note : For float, Double while creating column, no need to set precision.

Note : For Decimal, when the round should happen is based on our input (amount DECIMAL(30,10)). Here 10 is given, so round will happen if it exceeds 10. Max Limit for decimal is -- DECIMAL(65,30).

*/

CREATE TABLE examples (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    point_float FLOAT,
    score_double DOUBLE,
    decimal_two DECIMAL(30,10),
    decimal_three DECIMAL(65,30)
);
