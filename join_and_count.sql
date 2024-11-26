-- if we want to retrive count of books with author's name

SELECT a.name, COUNT(*) from authors as a join books as b on a.id = b.author_id group by a.id; -- Faster as efficient for this type of operation because it directly uses the JOIN to count rows

SELECT a.name, (SELECT COUNT(*) from books as b where b.author_id = a.id) from authors as a; -- Slower as executes the subquery once for every row

# Query 1:

SELECT a.name, COUNT(*)
FROM authors AS a
JOIN books AS b ON a.id = b.author_id
GROUP BY a.id;

/*

Step-by-Step Execution:

JOIN Operation:

The JOIN creates a temporary result set where each row in the authors table (a) is paired with all matching rows in the books table (b) based on the condition a.id = b.author_id.
If an author has multiple books, there will be multiple rows for that author in the result set.

Example Data:

authors (a)	books (b)	Joined Result
id	name	id
1	Alice	101
1	Alice	102
2	Bob	103

For author Alice, there are 2 books, so there are 2 rows in the result for her.

COUNT(*) Aggregation:

The COUNT(*) function counts the number of rows in the grouped result.

After the JOIN, each row represents one book associated with an author.

By grouping these rows using GROUP BY a.id, we group all rows belonging to the same author.

Grouped Data:

a.id	a.name	Count
1	Alice	2
2	Bob	1

Here, the count is determined directly from the number of rows in the grouped result.

Output Result:

The query outputs the author name and the count of rows (books) for each author.

Final Result:

name	COUNT(*)
Alice	2
Bob	1

Why is This Efficient?

Single Scan Over books:
The JOIN leverages the foreign key relationship (author_id in books) and processes rows in bulk, rather than executing multiple queries (as in the subquery approach).

Index Utilization:
If there’s an index on books.author_id, the JOIN can quickly match rows between authors and books, reducing the time to fetch matching rows.

Set-Based Operations:
SQL engines are optimized for set-based operations, where data is processed in batches. The JOIN + GROUP BY approach processes all rows simultaneously, minimizing the need for repetitive calculations.

Reduced Query Overhead:
In Query 2 (with the subquery), the database must execute a subquery for each author, which involves multiple scans over the books table.
Query 1 performs a single scan and aggregation.

Summary:
In Query 1, the JOIN directly links authors to books, and COUNT(*) works on the joined dataset.
This avoids repetitive lookups and efficiently counts rows, making it faster and more scalable than Query 2.

*/