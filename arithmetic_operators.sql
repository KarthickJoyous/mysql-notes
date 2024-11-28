-- Addition

SELECT 1+1; -- 2


-- Subtraction

SELECT 10-9; -- 1

-- Multiplication

SELECT 10*10; -- 100

-- Division

SELECT 100/10; -- 10.000
SELECT 1000 DIV 10; -- 100.000
SELECT FORMAT(100/10, 0); -- 10

-- Modulo (Remainder)

SELECT 100 % 3; -- 1

SELECT 99 MOD 3; -- 0

-- If the numbers in your arithmetic are all integers, MySQL uses the BIGINT (signed 64-bit) integer data type to do its work

SELECT (1024 * 1024 * 1024 * 1024 *1024 * 1024) + 1; -- 1152921504606846977

SELECT (1024 * 1024 * 1024 * 1024 *1024 * 1024 * 1024) + 1 -- ERROR : BIGINT value is out of range