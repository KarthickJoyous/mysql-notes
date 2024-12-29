-- Step 1: Create Schema and Tables for Examples

-- Create the schema
CREATE TABLE SalesData;

-- Use the schema
USE SalesData;

-- Create a table
CREATE TABLE EmployeeSales (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Region VARCHAR(20),
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);

-- Insert sample data
INSERT INTO EmployeeSales (EmployeeID, EmployeeName, Region, SalesAmount, SaleDate) VALUES
(1, 'Alice', 'North', 5000.00, '2024-12-01'),
(2, 'Bob', 'North', 7000.00, '2024-12-02'),
(3, 'Charlie', 'North', 5000.00, '2024-12-03'),
(4, 'Diana', 'South', 8000.00, '2024-12-01'),
(5, 'Eve', 'South', 8000.00, '2024-12-02'),
(6, 'Frank', 'South', 6000.00, '2024-12-03'),
(7, 'Grace', 'West', 7000.00, '2024-12-01'),
(8, 'Hank', 'West', 9000.00, '2024-12-02'),
(9, 'Ivy', 'West', 7000.00, '2024-12-03');

-- Step 2: Explain and Demonstrate Concepts

-- 1. ROW_NUMBER() Example
-- Assign a unique row number to each row in the result set based on the SalesAmount
SELECT 
    EmployeeID,
    EmployeeName,
    Region,
    SalesAmount,
    ROW_NUMBER() OVER (ORDER BY SalesAmount DESC) AS RowNumber
FROM EmployeeSales;

-- 2. RANK() Example
-- Assign a rank to each row based on SalesAmount, with gaps in the ranking for ties
SELECT 
    EmployeeID,
    EmployeeName,
    Region,
    SalesAmount,
    RANK() OVER (ORDER BY SalesAmount DESC) AS r
FROM EmployeeSales;

-- 3. DENSE_RANK() Example
-- Assign a rank to each row based on SalesAmount, without gaps in the ranking for ties
SELECT 
    EmployeeID,
    EmployeeName,
    Region,
    SalesAmount,
    DENSE_RANK() OVER (ORDER BY SalesAmount DESC) AS DenseRank
FROM EmployeeSales;

-- 4. Using PARTITION BY
-- Partition the data by Region and rank SalesAmount within each region
SELECT 
    EmployeeID,
    EmployeeName,
    Region,
    SalesAmount,
    ROW_NUMBER() OVER (PARTITION BY Region ORDER BY SalesAmount DESC) AS RowNumber,
    RANK() OVER (PARTITION BY Region ORDER BY SalesAmount DESC) AS r,
    DENSE_RANK() OVER (PARTITION BY Region ORDER BY SalesAmount DESC) AS DenseRank
FROM EmployeeSales;

-- Explanation:
-- 1. ROW_NUMBER(): Assigns a unique sequential integer to rows within the result set or partition. Ties are ignored.
-- 2. RANK(): Assigns a rank to rows based on the ORDER BY clause, leaving gaps for ties.
-- 3. DENSE_RANK(): Assigns a rank to rows based on the ORDER BY clause, without gaps for ties.
-- 4. PARTITION BY: Divides the result set into partitions to apply the window function separately to each partition.

-- Query the partitioned ranking data for specific analysis
-- Example: Find the top salesperson in each region
WITH RankedSales AS (
    SELECT 
        EmployeeID,
        EmployeeName,
        Region,
        SalesAmount,
        RANK() OVER (PARTITION BY Region ORDER BY SalesAmount DESC) AS r
    FROM EmployeeSales
)
SELECT *
FROM RankedSales
WHERE r = 1;