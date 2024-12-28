SQL Basics, Intermediate, and Advanced Concepts
===============================================

SQL Basics
----------

### **What is DDL and DML? What is the difference?**

*   **DDL (Data Definition Language):** Used to define or modify database structures (e.g., tables, indexes). Commands: `CREATE`, `ALTER`, `DROP`.
*   **DML (Data Manipulation Language):** Used to manage data within tables. Commands: `INSERT`, `UPDATE`, `DELETE`, `SELECT`.
*   **Difference:**
    *   DDL changes the structure/schema of the database.
    *   DML manipulates the actual data stored in the database.

* * *

### **What is the difference between Truncate vs Delete vs Drop?**

*   **Truncate:**
    *   Removes all rows from a table.
    *   Cannot be rolled back.
    *   Faster as it doesn’t log individual row deletions.
*   **Delete:**
    *   Removes specific rows based on a condition.
    *   Can be rolled back.
*   **Drop:**
    *   Deletes the entire table (schema + data).
    *   Irreversible.

* * *

### **When is Group By used?**

*   Used to group rows that have the same values in specified columns.
*   Typically used with aggregate functions like `SUM`, `COUNT`, `AVG`.

* * *

### **What is the difference between Where clause vs. Having clause?**

*   **WHERE Clause:**
    *   Filters rows before aggregation.
    *   Cannot use aggregate functions.
*   **HAVING Clause:**
    *   Filters rows after aggregation.
    *   Works with aggregate functions.

* * *

### **What are Scalar and Aggregate functions in SQL?**

*   **Scalar Functions:**
    *   Operate on individual values and return a single value.
    *   Examples: `UPPER()`, `LOWER()`, `LENGTH()`.
*   **Aggregate Functions:**
    *   Operate on a set of values and return a single summarized value.
    *   Examples: `SUM()`, `COUNT()`, `AVG()`, `MAX()`.

* * *

### **What does the COALESCE function do in SQL?**

*   Returns the first non-null value in a list of arguments.
*   Example:
    
    ```sql
    
    SELECT COALESCE(NULL, 'Default') AS Result; -- Output: 'Default'

    SELECT COALESCE(NULL, 'Default', 'Value') AS Result; -- Output: 'Default'

    SELECT COALESCE("Hello", 'Default') AS Result; -- Output: 'Hello'
    
    ```
    

* * *

SQL Intermediate
----------------

### **What are Constraints? How many Constraints are there?**

*   **Constraints:** Rules enforced on data in a table to maintain integrity.
*   **Types of Constraints:**
    1.  **Primary Key** - Ensures unique, non-null values.
    2.  **Foreign Key** - Establishes relationships between tables.
    3.  **Unique** - Ensures all values in a column are unique.
    4.  **Not Null** - Ensures column cannot have `NULL` values.
    5.  **Check** - Ensures column values satisfy a condition.
    6.  **Default** - Assigns a default value to a column.

* * *

### **How many primary key and unique key can be in a table?**

*   **Primary Key:** Only one per table.
*   **Unique Key:** Multiple unique keys can exist in a table.

* * *

### **What are Joins in SQL? Types of Joins in SQL?**

*   **Joins:** Combine rows from two or more tables based on a related column.
*   **Types of Joins:**
    1.  **Inner Join:** Returns rows with matching values in both tables.
    2.  **Left Join (Outer):** Returns all rows from the left table and matching rows from the right.
    3.  **Right Join (Outer):** Returns all rows from the right table and matching rows from the left.
    4.  **Full Join (Outer):** Returns rows when there’s a match in either table.
    5.  **Cross Join:** Produces the Cartesian product of two tables.
    6.  **Self Join:** Joins a table to itself.

* * *

### **Difference between UNION and UNION ALL?**

*   **UNION:**
    *   Combines results of two queries.
    *   Removes duplicate rows.
*   **UNION ALL:**
    *   Combines results of two queries.
    *   Includes duplicate rows.

* * *

### **What is the order of execution in SQL Code?**

1.  **FROM**
2.  **WHERE**
3.  **GROUP BY**
4.  **HAVING**
5.  **SELECT**
6.  **ORDER BY**

* * *

### **How many joins are required to join 8 tables?**

*   **7 joins** are required to join 8 tables.

* * *

SQL Advanced
------------

### **What are Window Functions or Analytical functions?**

*   Perform calculations across a set of rows related to the current row without collapsing rows.
*   Examples: `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, `LEAD()`, `LAG()`.

* * *

### **What is the difference between Rank & Dense Rank Function?**

*   **RANK():** Assigns a rank to rows, skipping numbers for ties.
*   **DENSE\_RANK():** Assigns a rank to rows without skipping numbers for ties.

* * *

### **What is View? How is it different from Table?**

*   **View:**
    *   A virtual table created using a `SELECT` query.
    *   Doesn’t store data itself; fetches data from underlying tables.
*   **Table:**
    *   Stores data physically in the database.

* * *

### **What is Index?**

*   **Index:** A database object that improves query performance by allowing faster retrieval of rows.
*   Types: **Clustered Index**, **Non-Clustered Index**.

### **Key Differences Between Clustered and Non-Clustered Index**

| **Aspect**                | **Clustered Index**                                      | **Non-Clustered Index**                                |
|---------------------------|----------------------------------------------------------|-------------------------------------------------------|
| **Physical Data Order**   | Rows are physically stored in index order.               | Physical order of rows remains unchanged; uses pointers. |
| **Count Per Table**       | Only one per table.                                      | Multiple allowed per table.                           |
| **Performance**           | Faster for range queries due to physical order.          | Efficient for point lookups. Slower than clustered indexes for range queries.      |
| **Storage Requirement**   | No additional storage needed besides the table.          | Requires extra storage for index structure.           |
| **Creation**              | Implicit with PRIMARY KEY.                               | Explicitly created with INDEX.                        |


```sql
-- Create a clustered index (PRIMARY KEY)
CREATE INDEX idx_clustered ON Employees(EmployeeID);

-- Create a non-clustered index (Any column except PRIMARY KEY)
CREATE INDEX idx_nonclustered ON Employees(EmployeeName); 
```
* * *

### **What is CTE? How is it useful?**

*   **CTE (Common Table Expression):**
    *   Temporary result set used in complex queries.
    *   Simplifies and organizes queries.
    *   Example:
        
    ```sql 
    WITH Sales_CTE AS (
        SELECT ProductID, SUM(Sales) AS TotalSales FROM Sales GROUP BY ProductID
    ) SELECT * FROM Sales_CTE WHERE TotalSales > 1000;
    ```
        

* * *

### **What is the difference between SQL vs. PLSQL?**

*   **SQL:**
    *   Standard query language for managing and manipulating data.
*   **PLSQL:**
    *   Procedural language extension for SQL in Oracle databases.
    *   Includes loops, conditions, and exception handling.

* * *

### **Use case of Cross Join?**

*   Generates combinations of rows from two tables.
*   Example: Calculating all possible product combinations for promotions.

* * *