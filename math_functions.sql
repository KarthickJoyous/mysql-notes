# ROULD, FLOOR, CEIL / CEILING

-- ROUND :

SELECT ROUND(10); -- 10
SELECT ROUND(10.45); -- 10
SELECT ROUND(10.80); -- 11
SELECT ROUND(-10.45); -- -10
SELECT ROUND(-10.80); -- -11

-- FLOOR

SELECT FLOOR(10); -- 10
SELECT FLOOR(10.45); -- 10
SELECT FLOOR(10.80); -- 10

/*
    Result for below values is -11, because -10 > -11
*/

SELECT FLOOR(-10.45); -- -11
SELECT FLOOR(-10.80); -- -11
SELECT -10 > -11; -- 1

-- CEIL :

SELECT CEIL(10); -- 10
SELECT CEIL(10.00001); -- 11
SELECT CEIL(10.45); -- 11
SELECT CEIL(10.80); -- 11

/*
    Result for below values is -10, because -10 > -10.45
*/

SELECT CEIL(-10.45); -- -10
SELECT CEIL(-10.80); -- -10
SELECT -10 > -10.45; -- 1

/*

    Difference between CEIL() & CEILING() :

    There is no difference between CEIL and CEILING. Both are interchangeable and perform the exact same operation.

    The reason for having two names is primarily for compatibility and readability:

        -- Some developers prefer CEIL because it's shorter.
        -- Others might find CEILING more descriptive and intuitive.

*/

# POW / POWER

/*

    Difference between POW() & POWER() :

    There is no difference between POW and POWER. Both are interchangeable and perform the exact same operation.

    The reason for having two names is primarily for compatibility and readability:

        -- Some developers prefer POW because it's shorter.
        -- Others might find POWER more descriptive and intuitive.

*/

SELECT POW(2, 3); -- 8
SELECT POWER(2, 3); -- 8

# SQRT

SELECT SQRT(4); -- 2

# RAND (To generate a pseudo random ﬂoating point number between 0 and 1, use the RAND())

SELECT RAND();

-- Order By using RAND

SELECT name from users ORDER BY RAND() DESC; -- Get name in random order

SELECT name from users ORDER BY RAND() DESC LIMIT 1; -- Get one random name

# Find random value between 2 numbers

/*
    Formula FLOOR(a + RAND() * (b - a + 1));
*/

SELECT FLOOR(100 + RAND() * (1000 - 100 + 1));

# ABS :

SELECT ABS(2); -- 2
SELECT ABS(-98.87); -- 98.87

# SIGN (The function will return: 1 if the number is positive. 0 if the number is zero. -1 if the number is negative.)

SELECT SIGN(19); -- 1
SELECT SIGN(0); -- 0
SELECT SIGN(-19); -- -1