-- You can combine the results of two identically structured queries with the UNION keyword.
-- Both select statements should return columns length & name to be same.

SELECT name from users UNION SELECT name from authors; -- Combines both tables.

(SELECT name from users) UNION (SELECT name from authors) ORDER BY name DESC; -- Remove Duplicates. Order BY name DESC.

(SELECT name from users) UNION ALL (SELECT name from authors) ORDER BY name DESC; -- With Duplicate Values. Order BY name DESC.

-- To order use () in queries or else order by clause will be applied to last select statement.

-- Combine two tables with different columns

/*
    -- studensts don't have email, so '' selected on that.
    -- students don't have created_at so added alias as created_at for enrollment_date.
    -- Now both SELECT statements will return same number of columns & same column names.
*/

(SELECT name, email, created_at from users) UNION (SELECT name, '', enrollment_date as created_at from students) order by name desc;

-- Using name as email with SQL string functions

(SELECT name, email, created_at from users) UNION (SELECT name, LOWER(REPLACE(CONCAT(name, '@email.com'), " ", "")), enrollment_date as created_at from students) order by name desc;

-- OFFSET, LIMIT

(SELECT item_name as name FROM `item`) UNION (SELECT tool as name from tools) ORDER BY name DESC;

(SELECT item_name as name FROM `item` ORDER BY name DESC LIMIT 2) UNION (SELECT tool as name from tools ORDER BY name DESC LIMIT 2) ORDER BY name DESC LIMIT 0,2;

(SELECT item_name as name FROM `item` ORDER BY name DESC LIMIT 4) UNION (SELECT tool as name from tools ORDER BY name DESC LIMIT 4) ORDER BY name DESC LIMIT 2,2;

(SELECT item_name as name FROM `item` ORDER BY name DESC LIMIT 6) UNION (SELECT tool as name from tools ORDER BY name DESC LIMIT 6) ORDER BY name DESC LIMIT 4,2;

(SELECT item_name as name FROM `item` ORDER BY name DESC LIMIT 8) UNION (SELECT tool as name from tools ORDER BY name DESC LIMIT 8) ORDER BY name DESC LIMIT 6,2;

(SELECT item_name as name FROM `item` ORDER BY name DESC LIMIT 10) UNION (SELECT tool as name from tools ORDER BY name DESC LIMIT 10) ORDER BY name DESC LIMIT 8,2;

(SELECT item_name as name FROM `item` ORDER BY name DESC LIMIT 12) UNION (SELECT tool as name from tools ORDER BY name DESC LIMIT 12) ORDER BY name DESC LIMIT 10,2;

(SELECT item_name as name FROM `item` ORDER BY name DESC LIMIT 14) UNION (SELECT tool as name from tools ORDER BY name DESC LIMIT 14) ORDER BY name DESC LIMIT 12,2;