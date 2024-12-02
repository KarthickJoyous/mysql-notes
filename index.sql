/*
 In MySQL, an index is a data structure that improves the speed of data retrieval operations on a database table.
 It allows MySQL to find rows more quickly, instead of scanning the entire table.
 Indexes are similar to the index of a book, where you can look up a keyword and find the pages that mention it rather than reading the whole book.
*/

# CREATE INDEX index_name ON table_name (column_name);

/*
 Types of Indexes:

 Primary Index:
    This is automatically created when you define a PRIMARY KEY on a table.
    A primary key uniquely identifies a record and cannot have NULL values.
    The primary key index ensures fast access to the record using the primary key column(s).
 
 Unique Index:
    Similar to a primary index, but it allows for the column(s) to have NULL values.
    Ensures that the values in the indexed columns are unique.
 
 Regular (Non-Unique) Index:
    This is the most common type of index, created on columns to speed up query performance.
    A regular index does not require unique values, meaning it can have duplicate entries.

Composite Index:
    Regular index on two or more columns.
    Order matters in a composite index
 
 Full-text Index:
    Specialized for full-text searches.
    Useful for matching text-based patterns in CHAR, VARCHAR, and TEXT columns.
 
 Spatial Index:
    Used for spatial data types like POINT, LINESTRING, etc., to optimize spatial queries, especially with geometric data.
*/

/*

Benefits of Indexing:

Faster Data Retrieval: 
    Indexes help the database engine locate data quickly.
    
Improved Performance of Queries:
    Especially those with WHERE, JOIN, and ORDER BY clauses.

Efficiency with Sorting: 
    Indexes help in faster sorting of records when using ORDER BY.

Costs of Indexing:
    Storage Overhead: Indexes consume additional storage space.
    
Insert/Update Performance: 
    When data is inserted, updated, or deleted, MySQL needs to update the index as well, which can slow down these operations.

When to Use Indexes:
    Use indexes on columns that are frequently used in WHERE, ORDER BY, GROUP BY, JOIN, and HAVING clauses.
    Avoid indexing columns with low cardinality (i.e., columns with many repeated values, like a "gender" column) because the index might not provide much performance improvement.

*/

# Dropping Indexes:
    -- If an index is no longer needed, you can drop it to save space and improve write performance:

DROP INDEX index_name ON table_name;

-- In summary, indexes are a crucial tool for optimizing read operations, especially in large datasets. 
    -- However, they come with trade-offs in terms of storage and write performance, 
        -- so it's important to balance their use appropriately based on query patterns.


CREATE TABLE categories (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    description VARCHAR(255),
    category_id INT UNSIGNED
);

DROP TABLE IF EXISTS products;

# 1. Regular Index on One Column

CREATE INDEX idx_name ON products(name);

DROP INDEX idx_name ON products;

SELECT * FROM products WHERE name LIKE '%s%';

# 2. Regular Index on Two Column (Composite index)

-- Creating separate indexes on category_id and price, will not optimize this query fully.
-- Solution : Create Composite Index using these columns.

CREATE INDEX idx_category_price ON products(category_id, price);

DROP INDEX idx_category_price ON products;

SELECT * FROM products WHERE category_id = 10 AND price BETWEEN 100 AND 500 order BY price desc;

/*
    Order matters in a composite index! In this case, category_id should come first because it’s used in the query’s condition (WHERE category_id = 3).
    MySQL will efficiently use this index when the query filters by category_id alone or by both category_id and price.
*/

# 3. Indexes on Columns Used in JOIN

CREATE INDEX idx_products_category ON products (category_id);

SELECT p.name, c.name AS category_name
FROM products p
JOIN categories c ON p.category_id = c.id;

-- MySQL quickly matches p.category_id with c.id using the indexes, drastically speeding up the join.

# 4. Indexes on Columns Used in GROUP BY, HAVING

CREATE INDEX idx_category_group ON products (category_id);

SELECT category_id, COUNT(*)
FROM products
GROUP BY category_id;

SELECT c.name, COUNT(*)
FROM products p
JOIN categories c ON p.category_id = c.id;
GROUP BY p.category_id;

SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY category_id
HAVING product_count > 10;

# 5. Indexes on Columns Used in ORDER BY

CREATE INDEX idx_price ON products (price);

SELECT * FROM products ORDER BY price ASC;

/*

General Tips for Mastering Index Strategies:

    Use Composite Indexes Carefully:
        Order matters! Index (A, B) can optimize queries like WHERE A = ? or WHERE A = ? AND B = ?, but not WHERE B = ?.

    Avoid Over-Indexing:
        Too many indexes increase storage and slow down INSERT/UPDATE operations.
    
    Analyze Query Patterns:
        Use EXPLAIN to understand how MySQL executes your queries and determine if indexes are being utilized.

    Avoid Indexes on Low-Cardinality Columns:
        Indexing a column like gender (which has only two values: male and female) is usually not effective.
    
    Use Covering Indexes:
        If a query uses only indexed columns, MySQL can fetch results directly from the index without accessing the table, speeding up the query.

    Regularly Monitor and Optimize:
        Use ANALYZE TABLE and tools like MySQL’s Performance Schema to monitor index usage and optimize performance.
*/

/*

1. Index Usage for index(A, B)

    Queries and Behavior:

    WHERE A = 1 AND B = 2:
    ✅ Index fully used (filters both A and B efficiently).

    WHERE A = 1:
    ✅ Index partially used (filters on A alone).

    WHERE B = 1 AND A = 1:
    ✅ Index fully used (MySQL reorders conditions to match the index structure).

    WHERE B = 2:
    ❌ Index not used (leading column A is missing, so MySQL defaults to a table scan).

2. Why WHERE B = 2 Doesn't Use the Index

    The composite index (A, B) requires filtering to start with A because it’s the leading column. Without a condition on A, MySQL cannot traverse the index efficiently.

    Optimization:
        Create a single-column index on B (index(B)) if queries like WHERE B = 2 are frequent.

3. Order of Conditions in WHERE Clause

    MySQL automatically reorders conditions in the WHERE clause to match the index.

    Example: WHERE B = 1 AND A = 1 is treated as WHERE A = 1 AND B = 1.

    Result: The composite index (A, B) is used fully.

4. Composite Index Usability

    For an index (A, B):

    ✅ Used for:

    WHERE A = ...
    WHERE A = ... AND B = ...
    WHERE B = ... AND A = ...

    ❌ Not Used for:

    WHERE B = ... (without filtering on A).

5. Behavior of WHERE A = B or WHERE B = A

    MySQL cannot efficiently use an index for conditions like A = B or B = A.
    These are row-by-row comparisons, and the index is not structured to handle such relational conditions.

    Optimization:
        Consider restructuring data or using generated columns to precompute and index such relationships.

6. Key Insights on Composite Index Design

    Order Matters:

        Always start with the most frequently filtered column or the column with high selectivity.

    Left-to-Right Rule:

        MySQL can only use the index efficiently if filters begin from the leftmost column of the composite index.

    Range Conditions:

        Put equality conditions (=) before range conditions (<, >, BETWEEN).

    Test with EXPLAIN:

        Use EXPLAIN to verify if and how MySQL uses your index.

7. Quick Example Summary

    Query	Index Usage	Notes
    WHERE A = 1 AND B = 2	✅ Fully used	Matches index order fully.
    WHERE A = 1	✅ Partially used	Filters on A alone.
    WHERE B = 1 AND A = 1	✅ Fully used	MySQL reorders to WHERE A = 1 AND B = 1.
    WHERE B = 2	❌ Not used	Missing condition on leading column A.
    WHERE A = B or WHERE B = A	❌ Not used	Indexes can't handle relational conditions.

*/

# Creating a Unique Index

CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(255) UNIQUE
);

CREATE UNIQUE INDEX idx_email ON users(email);

# UNIQUE index on two columns :

CREATE TABLE orders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    UNIQUE(user_id, product_id)
);

# Full text index 

CREATE FULLTEXT INDEX full_text_idx_description ON products(description);

DROP INDEX full_text_idx_description ON products;

SELECT description FROM `products` where description lIKE "%i%" ORDER BY `id` ASC;

SELECT description from products WHERE MATCH(description) AGAINST('i' IN NATURAL LANGUAGE MODE);

SELECT description FROM `products` where description lIKE "%alias%" ORDER BY `id` ASC;

SELECT description from products WHERE MATCH(description) AGAINST('alias' IN NATURAL LANGUAGE MODE);

/*

Key Differences Between LIKE and FULLTEXT:

Feature	LIKE	FULLTEXT
Performance	Slower on large datasets	Faster with large datasets due to indexing
Index Utilization	Cannot use index with %	Requires a FULLTEXT index
Matches	Substrings (e.g., "super" in "supersonic")	Whole words only
Relevance Ranking	Not available	Built-in relevance ranking
Stopwords Ignored	No	Yes (e.g., "the", "is")
Wildcard Support	Yes (%, _)	Limited (requires boolean mode)

*/

/*

When to Use Each:

Use LIKE when:

Searching for partial matches (e.g., "super" in "supersonic").
Your dataset is small, so performance isn’t a big issue.
You need simple, one-off searches without advanced ranking or filtering.

Use FULLTEXT Search when:

You have a large dataset with text-heavy fields.
You need fast searches across many rows.
You want advanced capabilities like relevance ranking or boolean search operators.
Exact word matches are sufficient (no need for substring matching).

Boolean mode in MySQL full-text search allows you to use advanced operators to perform complex search queries. 
Unlike natural language mode, which ranks results by relevance, boolean mode gives you precise control over the search criteria using logical operators.


Operators in Boolean Mode
Here’s a list of commonly used operators in boolean mode and what they do:

Operator	Description	Example	Result
+	Word must be present in the results.	+super +advanced	Returns rows with both "super" and "advanced".
-	Word must not be present in the results.	+super -basic	Returns rows with "super" but not "basic".
( )	Group expressions for precedence.	+super +(advanced basic)	Returns rows with "super" and either "advanced" or "basic".
*	Wildcard for words starting with a prefix.	super*	Returns rows with words like "superior", "superman", etc.
"	Double quotes for exact phrases.	"super advanced"	Returns rows with the exact phrase "super advanced".
> / <	Increase (>) or decrease (<) the importance of a word in the results ranking.	+super >advanced	Results prioritize rows with "advanced".
~	Decreases the importance of a word without excluding it completely.	+super ~basic	"Basic" is optional but deprioritized.
`	`	Logical OR (matches either word).	`super
no operator	Default: The word is optional, but results with it are ranked higher.	super advanced	Returns rows with either word, ranked by relevance.


Examples of Boolean Mode Queries

-- Find rows containing both words "super" and "advanced":
    SELECT * FROM products WHERE MATCH(description) AGAINST('+super +advanced' IN BOOLEAN MODE);


-- Find rows containing "super" but not "basic":
    SELECT * FROM products WHERE MATCH(description) AGAINST('+super -basic' IN BOOLEAN MODE);


-- Find rows containing either "super" or "advanced":
    SELECT * FROM products WHERE MATCH(description) AGAINST('super | advanced' IN BOOLEAN MODE);


-- Find rows with the exact phrase "super advanced":
    SELECT * FROM products WHERE MATCH(description) AGAINST('"super advanced"' IN BOOLEAN MODE);


-- Find rows where words start with "super":
    SELECT * FROM products WHERE MATCH(description) AGAINST('super*' IN BOOLEAN MODE);


*/

/*

A Spatial Index in MySQL is a specialized index used for optimizing queries involving spatial (geographical or geometric) data types such as POINT, LINESTRING, and POLYGON.
These data types are part of MySQL's implementation of Spatial Data Types, which allow the storage and querying of data related to geometric shapes and locations.

Use Cases of Spatial Index:
Geographic Applications:

Storing and querying GPS coordinates.
Mapping services (e.g., finding nearby restaurants or ATMs).
Geospatial Analysis:

Analyzing geographic regions like flood zones or city boundaries.
Real Estate Applications:

Locating properties within a specific area or distance.
Logistics and Transportation:

Finding optimal routes or nearest delivery hubs.
Limitations:
Spatial indexes are not suitable for non-spatial queries.
They can only be created on NOT NULL columns.
Limited by the engine compatibility (e.g., MyISAM and InnoDB support).

Scenario:
You are developing a food delivery app, and you need to find all restaurants within a 5-kilometer radius of a user’s current location.

Steps:
1. Create a Table to Store Restaurant Data
Each restaurant has a name and a geographic location stored as a POINT data type.

CREATE TABLE restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    location POINT NOT NULL,
    SPATIAL INDEX (location)
) ENGINE=InnoDB;

2. Insert Data into the Table

Use ST_GeomFromText to insert the latitude and longitude of each restaurant.

INSERT INTO restaurants (name, location)
VALUES 
    ('Pizza Palace', ST_GeomFromText('POINT(77.5946 12.9716)')), -- Bengaluru
    ('Sushi World', ST_GeomFromText('POINT(77.6033 12.9789)')), -- Nearby Bengaluru
    ('Burger Hub', ST_GeomFromText('POINT(77.6156 12.9658)')),  -- Slightly farther
    ('Taco Town', ST_GeomFromText('POINT(78.4867 17.3850)'));   -- Hyderabad

3. User’s Current Location
Suppose the user is located at 77.5946 (Longitude), 12.9716 (Latitude) in Bengaluru.

4. Query Restaurants Within a 5-Kilometer Radius
We’ll use the ST_Distance_Sphere() function to calculate the distance in meters between the user's location and each restaurant.

SELECT 
    name,
    ST_Distance_Sphere(location, ST_GeomFromText('POINT(77.5946 12.9716)')) AS distance_in_meters
FROM restaurants
WHERE 
    ST_Distance_Sphere(location, ST_GeomFromText('POINT(77.5946 12.9716)')) <= 5000; -- 5 km

5. Result
The query will return only restaurants within 5 kilometers of the user's location. For this data:

Name	Distance (meters)
Pizza Palace	0.0
Sushi World	1042.6
Burger Hub	2345.7
How the Spatial Index Helps

Optimized Lookups: Without the spatial index, MySQL would need to calculate the distance for every restaurant in the table, which can be slow for large datasets.

Efficient Filtering: The spatial index pre-selects a smaller subset of candidate points (restaurants) based on proximity, reducing the computational load.
Advanced Real-World Use Cases

Delivery Services: Finding the nearest delivery hub or delivery personnel to a customer’s location.

Ride-Hailing Apps: Matching riders with nearby drivers (Uber, Lyft).

Travel Applications: Listing hotels or attractions within a region.
Environmental Studies: Locating monitoring stations or points of interest within a natural disaster zone.

*/

/*

1. What is an Index?
An index is a data structure that MySQL uses to speed up data retrieval. Think of it like a book’s index: instead of scanning the entire book for a topic, you go directly to the relevant page.

2. Backend Data Structure
MySQL uses B-trees or hash tables as the underlying data structures for indexes, depending on the storage engine and index type:

B-tree Index (Default in InnoDB)
A self-balancing tree structure.
Data is stored hierarchically, making it faster to traverse.
Example of B-tree operations:
Searching: Instead of scanning all rows, it performs a binary search down the tree.
Insertions/Deletions: Maintain the tree's balance, ensuring consistent performance.
Leaf Nodes: Store pointers to actual table data.
Hash Index (Memory Storage Engine)
Uses key-value pairs.
Ideal for exact-match queries.
Not suitable for range or partial-match queries.

3. How Indexes Speed Up Retrieval

Key Concepts:
Logarithmic Search:

With B-trees, the number of operations grows logarithmically with the number of rows. For example, searching 1,000,000 rows might take only ~20 comparisons.
Reduced I/O:

MySQL reads a fraction of the data pages into memory, thanks to the index, instead of scanning the entire table.
Pointer-Based Navigation:

Leaf nodes in the B-tree contain pointers to the actual data rows. Once the desired key is found in the index, MySQL uses this pointer to directly fetch the row.

4. Clustered vs Non-Clustered Indexes
Clustered Index:
The primary key in InnoDB is a clustered index.
Stores table data directly in the leaf nodes of the index.
Benefits:
Faster range queries because the data is physically close.
Only one clustered index per table.
Non-Clustered Index:
Separate structure that contains pointers to the data in the table.
Can have multiple non-clustered indexes.

5. Caching Mechanisms
MySQL uses caching to make indexes even faster:

Buffer Pool (InnoDB):
Frequently accessed index pages are stored in memory.
Query Cache:
Results of queries are cached to avoid recomputation.

6. Optimizing Queries with Indexes
Indexes shine when queries are designed to take advantage of them:

Equality Conditions (WHERE column = value).
Range Conditions (BETWEEN, <, >, etc.).
Sorting (ORDER BY) and Grouping (GROUP BY).
7
. Limitations of Indexes
While indexes are powerful, they have trade-offs:

Storage Overhead:
Indexes require additional disk space.
Write Performance Impact:
Insert, update, and delete operations become slower due to index maintenance.
Full-Text Limitations:
Not ideal for partial matches unless using specialized indexes (e.g., FULLTEXT).
Example of Backend Operations

SELECT * FROM employees WHERE emp_id = 1001;

Step 1: Look up emp_id in the B-tree index.

Starts at the root node.
Traverses to the appropriate leaf node.

Step 2: Find the data pointer for emp_id = 1001.

Step 3: Use the pointer to fetch the row from the table.

By understanding these mechanics, you can design better schemas, write optimized queries, and choose the right indexes for your MySQL database!


--

A B-tree (Balanced Tree) is a self-balancing tree data structure used in MySQL (especially with the InnoDB storage engine) to organize and manage indexes efficiently. Here's a detailed explanation:

1. What is a B-Tree?
A B-tree is a generalization of a binary search tree. Unlike binary trees, where each node has up to two children, a B-tree node can have multiple children. This property allows the B-tree to remain balanced and minimizes the depth of the tree, which is critical for optimizing disk I/O and ensuring fast search, insert, and delete operations.

2. Why B-Tree for Indexing?
B-trees are particularly suited for database indexing because:

They minimize the number of disk reads required to find data.
They maintain sorted order, enabling efficient range queries.
They automatically balance themselves to avoid performance degradation.

3. Structure of a B-Tree
Nodes:

Each node contains multiple keys and child pointers.
Keys within a node are stored in sorted order.
Root Node:

The topmost node of the tree.
May also serve as a leaf node if the tree is small.
Leaf Nodes:

Contain pointers to the actual data (or the data itself in clustered indexes).
Linked sequentially in InnoDB, enabling efficient range scans.
Non-Leaf Nodes:

Contain keys that act as guideposts, helping navigate to the correct leaf node.
B-Tree Properties:

All leaves are at the same level (balanced tree).
Keys in a node divide the data into ranges, ensuring sorted order.

4. How B-Tree Indexes Work in MySQL
Search Operation
MySQL starts at the root node.
Compares the target value with the keys in the current node.
Follows the child pointer that corresponds to the range of the target value.
Repeats this process until reaching the leaf node.
Insertion Operation
Finds the appropriate leaf node using the search process.
Inserts the new key in sorted order within the node.
If the node overflows (exceeds the maximum number of keys):
The node splits into two.
The median key is moved up to the parent node.
This process propagates upwards, if necessary, ensuring balance.
Deletion Operation
Deletes the key from the leaf node.
If the node underflows (fewer keys than the minimum allowed):
Attempts to borrow a key from a sibling node.
If borrowing isn’t possible, merges the node with a sibling.
This process propagates upwards, if necessary.
Range Queries
Once the starting leaf node is located, the B-tree's linked structure allows MySQL to traverse the sequentially linked leaf nodes efficiently.

5. Clustered Index vs Non-Clustered Index in B-Trees
Clustered Index (Primary Key Index in InnoDB):

The B-tree’s leaf nodes contain the actual table rows.
The table is stored in the order of the primary key.
Benefit: Efficient for range queries and sequential scans.
Non-Clustered Index:

The B-tree’s leaf nodes contain pointers (row IDs or primary key values) to the actual data.
Additional I/O is required to fetch the full row after finding the index entry.

6. B-Tree Example in MySQL
Example Table:

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    department VARCHAR(50),
    INDEX (name)
) ENGINE=InnoDB;

Primary Key (emp_id):

InnoDB organizes the table as a clustered B-tree, with emp_id as the key.
The leaf nodes contain the full row data.
Secondary Index (name):

Creates a separate B-tree with name as the key.
Leaf nodes contain pointers to the primary key (emp_id), which can then be used to locate the full row.
Query Using Index:

SELECT * FROM employees WHERE name = 'Alice';
The B-tree for the name index is searched.
Once Alice is found, the pointer retrieves the row from the clustered index.

7. Advantages of B-Trees in MySQL
Logarithmic Time Complexity:
Search, insert, and delete operations take 𝑂 (log 𝑛) time.
Efficient Disk Usage:
Minimizes the number of disk reads by keeping the tree shallow.
Range Queries:
Leaf node linking allows for efficient range scans without traversing the tree repeatedly.

8. Limitations of B-Trees
Not Suitable for Exact Matches in Large Datasets:
Hash indexes are better for exact matches.
Overhead for Updates:
Inserting and deleting data require rebalancing the tree, which can impact performance.
Understanding how B-trees function as the backbone of indexes in MySQL enables you to design efficient schemas and optimize queries effectively. Let me know if you'd like more examples or a deeper dive!

Step 1: Start at the Root Node
The root node contains keys that act as guideposts for navigation.
Compare "Alice" with the keys in the root node.
If "Alice" is less than the first key, follow the left child pointer.
If "Alice" falls between two keys, follow the child pointer corresponding to that range.
If "Alice" is greater than the last key, follow the rightmost child pointer.

Step 2: Traverse to the Intermediate Node
At the intermediate node, repeat the comparison process.
Narrow down the range by comparing "Alice" to the keys in this node.
Follow the pointer to the appropriate leaf node.

Step 3: Search in the Leaf Node
The leaf node contains the actual indexed keys in sorted order.
Perform a linear or binary search within this node to locate "Alice."
If "Alice" is found, the leaf node provides a pointer to the actual row in the table.

Step 4: Fetch the Data
Use the pointer from the leaf node to retrieve the full row from the table.
Example in the Diagram:
Assume the root node contains keys like "Brian," "Charles," and "Zara."
"Alice" is less than "Brian," so the search moves to the left child node.
In the left intermediate node, there are keys like "Adam" and "Alice."
"Alice" matches a key in this node, leading to the corresponding leaf node.
The leaf node confirms "Alice" and provides a pointer to fetch her row from the table.
Would you like an annotated diagram to further clarify?

*/