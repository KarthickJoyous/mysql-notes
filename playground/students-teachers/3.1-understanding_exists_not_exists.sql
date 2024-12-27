-- Query Explanation in SQL Format
-- Query:
-- SELECT DISTINCT s.city
-- FROM students AS s
-- WHERE EXISTS (
--     SELECT 1
--     FROM teachers AS t
--     WHERE t.city = s.city
-- );

-- Step-by-Step Execution:

-- 1. Outer Query:
-- SELECT DISTINCT s.city FROM students AS s
-- This query retrieves all unique cities from the students table. Each city will be processed one by one.

-- 2. Subquery:
-- SELECT 1 FROM teachers AS t WHERE t.city = s.city
-- For each city in the students table (from the outer query), this subquery is executed to check if there exists a matching city in the teachers table.
-- - The subquery uses the `WHERE` clause to compare the current `s.city` (from the outer query) with `t.city` (from the teachers table).
-- - If at least one row in the teachers table satisfies the condition `t.city = s.city`, the subquery returns `1`.

-- 3. EXISTS Clause:
-- The EXISTS keyword checks if the subquery returns any rows (even one row is enough to satisfy EXISTS).
-- If the subquery returns rows, the condition in the WHERE clause of the outer query is satisfied, and the current `s.city` is included in the final result.

-- Execution Details:
-- a. The outer query executes once for each unique city in the students table.
-- b. The subquery executes once for each city in the students table to check for a match in the teachers table.
-- c. The result of the subquery is either TRUE (if a match is found) or FALSE (if no match is found).

-- Example Tables:
-- Students Table:
-- City
-- New York
-- Los Angeles
-- Chicago

-- Teachers Table:
-- City
-- Chicago
-- Houston
-- Boston

-- Execution Trace:
-- i. For `s.city = 'New York'`, the subquery `SELECT 1 FROM teachers WHERE t.city = 'New York'` returns no rows (FALSE).
-- ii. For `s.city = 'Los Angeles'`, the subquery `SELECT 1 FROM teachers WHERE t.city = 'Los Angeles'` returns no rows (FALSE).
-- iii. For `s.city = 'Chicago'`, the subquery `SELECT 1 FROM teachers WHERE t.city = 'Chicago'` returns rows (TRUE).

-- Result Set:
-- City
-- Chicago

-- Summary:
-- - The outer query executes once. (Retrives all unique city)
-- - The subquery executes once for each city in the students table (3 times in this case).
-- - The final result includes cities from the students table that have at least one matching city in the teachers table.


-- <------------------------------------------------------------------------------------------------------------------------>


-- NOTES: Understanding EXISTS and NOT EXISTS in SQL

-- The EXISTS keyword checks if the subquery returns any rows.
-- If the subquery returns at least one row, EXISTS evaluates to TRUE, otherwise FALSE.

-- The NOT EXISTS keyword does the opposite.
-- It checks if the subquery does NOT return any rows.
-- If the subquery does not return any rows, NOT EXISTS evaluates to TRUE, otherwise FALSE.

-- Behavior of EXISTS and NOT EXISTS based on subquery comparison:
-- When comparing with '=': The subquery looks for exact matches.
-- When comparing with '!=': The subquery looks for non-matching rows.

-- Example Queries and Explanations:

-- Query 1: Get distinct cities from students where at least one teacher exists in the same city.
SELECT DISTINCT s.city
FROM students AS s
WHERE EXISTS (
    SELECT 1
    FROM teachers AS t
    WHERE t.city = s.city
);
-- Explanation:
-- EXISTS is TRUE if there is at least one teacher in the same city as the student.
-- This query filters student cities where there is a corresponding teacher city.

-- Query 2: Get distinct cities from students where no teacher exists in the same city.
SELECT DISTINCT s.city
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM teachers t
    WHERE t.city = s.city
);
-- Explanation:
-- NOT EXISTS is TRUE if there is no teacher in the same city as the student.
-- This query filters student cities where there are no corresponding teacher cities.

-- Query 3: Get distinct cities from students where at least one teacher exists in a different city.
SELECT DISTINCT s.city
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM teachers t
    WHERE t.city != s.city
);
-- Explanation:
-- EXISTS is TRUE if there is at least one teacher in a different city from the student.
-- This query filters student cities where teachers exist but in different cities.

-- Query 4: Get distinct cities from students where no teacher exists in a different city.
SELECT DISTINCT s.city
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM teachers t
    WHERE t.city != s.city
);
-- Explanation:
-- NOT EXISTS is TRUE if there are no teachers in any city other than the student's city.
-- This query filters student cities where teachers exist only in the same city.

-- Summary of Behavior:
-- EXISTS and NOT EXISTS behave based on the subquery's logical condition and comparison operator.
-- '=' matches rows with the same attribute value, focusing on equality.
-- '!=' finds rows with differing attribute values, focusing on inequality.

-- Use this file as a reference to understand and revise how EXISTS and NOT EXISTS work in SQL.