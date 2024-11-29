# LENGTH

SELECT name, LENGTH(name) from users;

# CONCAT 

SELECT CONCAT(id, "-", name) from users;

# CONCAT_WS

SELECT CONCAT_WS("-", id, name, email) from users;

# FIELD

SELECT FIELD(1, 2,3,4,1); -- 4

# FIND_IN_SET

SELECT FIND_IN_SET(4,"2,3,4,1"); -- 3

# INSERT (Replace with specifed string in specifed positions)

SELECT INSERT(name, 1,2, "__") from users; -- Karthick --> __rthick

# INSTR - Return the index of the ﬁrst occurrence of substring

SELECT INSTR(name, "a") from users; -- Karthick --> 2

# LCASE | LOWER

SELECT LCASE(name) from users;
SELECT LOWER(name) from users;

# LEFT 

SELECT LEFT(name, 4) from users; -- Karthick --> Kart

# LOCATE 

SELECT LOCATE("a", name) from users; -- Karthick --> 2

# LPAD

SELECT LPAD(name, LENGTH(name) + 8, "NAME-is-") from users; -- Karthick --> Name-is-Karthick

# LTRIM

SELECT LTRIM("     Karthick"), LENGTH(LTRIM("     Karthick")), LENGTH("     Karthick"); -- Karthick | 8 | 13

# UCASE | UPPER

SELECT UCASE(name) from users;
SELECT UPPER(name) from users;

# MAKE_SET 

/*
    The MAKE_SET() function in MySQL is used to return a string containing the elements of a set that correspond to the bits set in an integer value.
*/

SELECT MAKE_SET(5, "A", "B", "C", "D");

-- 5 <-(BIT)-> 0101
-- 1,3'rd values are set
-- Result : A,C

SELECT MAKE_SET(10, 'Red', 'Green', 'Blue', 'Yellow') AS Colors;

-- 10 <-(BIT)-> 1010
-- 2,4'th values are set
-- Result : Green,Yellow

# SUBSTRING

SELECT SUBSTRING("Karthick", 4); -- thick
SELECT SUBSTRING("Karthick", 4, 2); -- th

SELECT SUBSTRING("Karthick", -4); -- hick
SELECT SUBSTRING("Karthick", -4, 1); -- h

# REPLACE

SELECT REPLACE("Karthick", "art", "ART"); -- KARThick
----------------------------------------------------------------------

# https://www.w3resource.com/mysql/string-functions/mysql-ascii-function.php