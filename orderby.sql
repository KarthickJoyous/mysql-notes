SELECT *
FROM books
ORDER BY id; -- Order by id ASC

SELECT *
FROM books
ORDER BY id DESC; -- Order by id DESC

SELECT *
FROM books
ORDER BY published_date ASC,
    id DESC; -- Order by published_date ASC, if books are published on same date, order it by id DESC.

-- TRICKS :

/* 

ORDER BY FIND_IN_SET(card_type, "MASTER-CARD,VISA,DISCOVER") -- sort 'MASTER-CARD' first.

ORDER BY x IS NULL, x -- order by `x`, but put `NULLs` last.

*/

SELECT * FROM `books` ORDER BY CASE WHEN FIND_IN_SET(author_id, '1,3,2') > 0 THEN FIND_IN_SET(author_id, '1,3,2') ELSE 4 END, id; -- Order 1 First, 3 Second, 2 Third, Rest Last.

/*

Visualization of How SQL Sorts:
Suppose the author_id values are [2, 1, 4, 3] in the books table.

author_id	FIND_IN_SET(author_id, '1,3,2')
2	3
1	1
4	0 (not found)
3	2

When sorted by ORDER BY FIND_IN_SET(author_id, '1,3,2'), the rows are reordered by the position values (1, 2, 3, 0), resulting in:

author_id	Order
1	First
3	Second
2	Third
4	Last

Summary:
SQL doesn't "understand" the list directly but uses the numeric positions returned by FIND_IN_SET to determine the sort order. You control the order by how you arrange the values in the comma-separated list provided to FIND_IN_SET.

*/

-- Order by author_id in order of 1,3,2 then order by author_id asc

SELECT * 
FROM `books` 
ORDER BY 
  CASE 
    WHEN FIND_IN_SET(author_id, '1,3,2') > 0 THEN 0 -- Rows in the list are given priority
    ELSE 1 -- Rows not in the list are given lower priority
  END,
  FIND_IN_SET(author_id, '1,3,2'), -- Order by the specified list (1, 3, 2)
  author_id;

/*

    How It Works:
    First CASE Statement:

    CASE assigns a sorting priority:
    Rows with author_id in the list '1,3,2' get a value of 0.
    Rows not in the list get a value of 1.
    This ensures rows in the list come before rows not in the list.
    FIND_IN_SET(author_id, '1,3,2'):

    For rows in the list, they are ordered by their position in the list (1, 3, 2).
    author_id:

    For rows not in the list, this ensures they are sorted in ascending order of author_id.
    Example:
    Data:
    book_id	title	author_id
    1	Book A	1
    2	Book B	2
    3	Book C	3
    4	Book D	4
    5	Book E	5

    Query Result:

    book_id	title	author_id	Priority (CASE)	Position (FIND_IN_SET)
    1	Book A	1	0	1
    3	Book C	3	0	2
    2	Book B	2	0	3
    4	Book D	4	1	0 (not in list)
    5	Book E	5	1	0 (not in list)

    Explanation:
    Rows with author_id in the list '1,3,2':

    Sorted first based on their position in the list.
    1, 3, 2 comes first.
    Remaining rows (author_id not in the list):

    Sorted by ascending author_id.
    4 and 5 come next, in that order.

*/

WITH ranked_books AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY author_id ORDER BY id) AS row_num,
           CASE 
               WHEN author_id NOT IN (1,3,2) THEN 1 -- Non-1,3,2 rows first
               ELSE 2 -- 1,3,2 rows second
           END AS priority
    FROM books
)
SELECT *
FROM ranked_books
ORDER BY 
    priority, -- Non-1,3,2 rows first
    CASE 
        WHEN priority = 2 THEN row_num -- Interleave 1,3,2 rows by row_num
    END,
    FIELD(author_id, 1, 3, 2) -- Ensure order within 1,3,2
LIMIT 0, 100;


SELECT * FROM `books` ORDER BY CASE WHEN FIELD(author_id, 1,3,2) > 0 THEN FIELD(author_id, 1,3,2) ELSE 4 END, author_id; 

-- ORDER By RAND()

SELECT * from users ORDER BY RAND() DESC LIMIT 10; -- It assigns a rand value to each row then sort it by that value.