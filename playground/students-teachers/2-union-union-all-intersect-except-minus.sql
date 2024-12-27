-- Step 1: Explain UNION, UNION ALL, INTERSECT, and EXCEPT
-- 1.1 UNION: Combines the distinct values from both tables
SELECT city FROM students
UNION
SELECT city FROM teachers;

-- Result: A list of unique cities from both `students` and `teachers`.

-- 1.2 UNION ALL: Combines all values (including duplicates) from both tables
SELECT city FROM students
UNION ALL
SELECT city FROM teachers;

-- Result: A list of cities from both tables, including duplicates.

-- 1.3 INTERSECT: Shows the common values between both tables
-- MySQL does not support INTERSECT directly. We can emulate it using INNER JOIN or EXISTS.
SELECT DISTINCT s.city
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM teachers t
    WHERE t.city = s.city
);

-- Result: A list of cities common to both `students` and `teachers`.

-- 1.4 EXCEPT: Shows values in one table that are not in the other
-- MySQL does not support EXCEPT directly. We can emulate it using NOT EXISTS.
-- 1.4.1 Cities in `students` but not in `teachers`
SELECT DISTINCT s.city
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM teachers t
    WHERE t.city = s.city
);

-- 1.4.2 Cities in `teachers` but not in `students`
SELECT DISTINCT t.city
FROM teachers t
WHERE NOT EXISTS (
    SELECT 1
    FROM students s
    WHERE s.city = t.city
);

-- Result: Two queries for EXCEPT, showing exclusive cities from each table.