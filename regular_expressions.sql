-- Starts with (^)
-- select authors name starts with a

SELECT name from authors where name REGEXP "^a" ORDER BY name;

-- Ends with ($)
-- select authors name ends with a

SELECT name from authors where name REGEXP "a$" ORDER BY name;


-- Not Starts with (^)
-- select authors whose name not starts with a

SELECT name from authors where name NOT REGEXP "^a" ORDER BY name;

-- Not Ends with ($)
-- select authors whose name not ends with a

SELECT name from authors where name NOT REGEXP "a$" ORDER BY RIGHT(name, 1);

-- if not ends with alphabets order in last.

SELECT name from authors where name NOT REGEXP "a$" ORDER BY
    CASE 
        WHEN (RIGHT(name, 1) IN("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")) THEN 0
        ELSE 1
    END,
    RIGHT(name, 1);

-- Contains :

SELECT id from profiles where city REGEXP "a" AND state REGEXP "a";

-- Any Character :

SELECT name from authors where name REGEXP "^[abc]" ORDER BY name; -- Starts with a/b/c

SELECT name from authors where name REGEXP "[ijk]$" ORDER BY RIGHT(name, 1); -- Ends with i/j/k

-- Pattern :

SELECT name from authors where name REGEXP "^[abc]|[ijk]$";

-- Count Matching

SELECT COUNT(*) from authors where name REGEXP "^k";

-- Count Not Matching

SELECT COUNT(*) from authors where name NOT REGEXP "^k";

-- Count Matching & Not Matching

SELECT COUNT(*), IF(name REGEXP "^k", "matching", "not matching") as result from authors GROUP BY result;

SELECT COUNT(*), IF(name LIKE "k%", "matching", "not matching") as result from authors GROUP BY result;

-- Difference between LIKE & REGEXP

-- Get author name starts with a|b|c

-- 1. Using LIKE

SELECT name from authors where name LIKE "a%" OR name LIKE "b%" OR name LIKE "c%" ORDER BY name;
SELECT COUNT(*) from authors where name LIKE "a%" OR name LIKE "b%" OR name LIKE "c%" ORDER BY name;

-- 2.Using REGEXP :

SELECT name from authors where name REGEXP "^[abc]" ORDER BY name;
SELECT COUNT(*) from authors where name REGEXP "^[abc]" ORDER BY name;

