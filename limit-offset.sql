Select id, CONCAT(first_name, " ", last_name) as name from users ORDER BY id DESC LIMIT 10; -- Select only 10 rows

-- When a LIMIT clause contains two numbers, it is interpreted as LIMIT offset,count (LIMIT skip,take). So, in this below query skips five records and returns next 10

-- [
	Select id, CONCAT(first_name, " ", last_name) as name from users ORDER BY id DESC LIMIT 0, 10; // (SKIP - 0, TAKE - 10) (ROWS 1-10 Returned)

	Select id, CONCAT(first_name, " ", last_name) as name from users ORDER BY id DESC LIMIT 10, 10; // (SKIP - 10, TAKE - 10) (ROWS 11-20 Returned)
-- ]


-- Notice that when the oﬀset argument is 0, the result set will be equivalent to a one argument LIMIT clause (Both are same) : 

Select id, CONCAT(first_name, " ", last_name) as name from users ORDER BY id DESC LIMIT 0, 10;

Select id, CONCAT(first_name, " ", last_name) as name from users ORDER BY id DESC LIMIT 10;


-- An alternative syntax for the LIMIT clause with two arguments consists in the usage of the OFFSET keyword after the ﬁrst argument in the following manner:

SELECT * FROM users ORDER BY id ASC LIMIT 10 OFFSET 0 /*-*/ SELECT * FROM users ORDER BY id ASC LIMIT 0,10;

SELECT * FROM users ORDER BY id ASC LIMIT 10 OFFSET 10 /*-*/ SELECT * FROM users ORDER BY id ASC LIMIT 10,10;



