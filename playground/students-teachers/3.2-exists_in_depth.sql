-- Query 1
-- Explanation:
-- Outer Query: Selects unique cities from the students table.
-- WHERE Clause: Uses EXISTS to check if there is at least one city in the teachers table that matches the current city from the students table.

-- Behavior:
-- This query will return all cities from the students table that have a corresponding match in the teachers table.
-- Important Note: The condition checks for equality (=), so the EXISTS condition will be satisfied only for those students.city values that exist in the teachers table.

-- Key Insight:
-- Query 1 effectively filters cities in students that are also present in teachers.

SELECT DISTINCT s.city
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM teachers t
    WHERE t.city = s.city
);

-- Result Set Example for Query 1:
-- Given Students Table:
-- City
-- New York
-- Los Angeles
-- Chicago

-- Given Teachers Table:
-- City
-- Chicago
-- Houston
-- Boston

-- Query 1 Result:
-- Chicago

-- <-------------------------------------------------------------------------------------------------------------------------------------------------->

-- Query 2
-- Explanation:
-- Outer Query: Selects unique cities from the students table.
-- WHERE Clause: Uses NOT EXISTS to check if there are no matching cities in the teachers table for the current student's city.

-- Behavior:
-- This query returns cities from the students table that do not appear in the teachers table.
-- It's effectively finding cities in students that are exclusive to students and are not shared with teachers.

-- Key Insight:
-- Query 2 filters for cities that exist in students but are completely absent from teachers.

SELECT DISTINCT s.city
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM teachers t
    WHERE t.city = s.city
);

-- Result Set Example for Query 2:
-- Given Students Table:
-- City
-- New York
-- Los Angeles
-- Chicago

-- Given Teachers Table:
-- City
-- Chicago
-- Houston
-- Boston

-- Query 2 Result:
-- New York
-- Los Angeles

-- <-------------------------------------------------------------------------------------------------------------------------------------------------->

-- Query 3
-- Explanation:
-- Outer Query: Selects unique cities from the students table.
-- WHERE Clause: Uses EXISTS to check if there is at least one city in the teachers table that is not equal to the current city from the students table.

-- Behavior:
-- This query will return all cities from the students table if there is any city in the teachers table that is different from the current student's city.
-- Important Note: The condition checks for inequality (!=), so as long as the teachers table has at least one city that doesn't match, 
-- the EXISTS condition will be satisfied for every students.city.

-- Key Insight:
-- This query isn't strictly filtering cities but more checking if teachers contains a variety of cities. 
-- As long as there's at least one city in teachers that's different, all cities in students will potentially pass the condition.

SELECT DISTINCT s.city
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM teachers t
    WHERE t.city != s.city
);

-- Result Set Example for Query 3:
-- Given Students Table:
-- City
-- New York
-- Los Angeles
-- Chicago

-- Given Teachers Table:
-- City
-- Chicago
-- Houston
-- Boston

-- Query 3 Result:
-- New York
-- Los Angeles
-- Chicago

-- <-------------------------------------------------------------------------------------------------------------------------------------------------->

-- Query 4
-- Explanation:
-- Outer Query: Selects unique cities from the students table.
-- WHERE Clause: Uses NOT EXISTS to check if there is no city in the teachers table that is different from the current city in the students table.

-- Behavior:
-- This query returns all cities from the students table if there are no cities in the teachers table that differ from the current city.
-- Important Note: The condition checks for inequality (!=), so the NOT EXISTS condition will be satisfied if the teachers table does not contain any city different from the current students.city.

-- Key Insight:
-- Query 4 filters cities in students where all cities in teachers are either the same or teachers is empty.

SELECT DISTINCT s.city
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM teachers t
    WHERE t.city != s.city
);

-- Result Set Example for Query 4:
-- Given Students Table:
-- City
-- New York
-- Los Angeles
-- Chicago

-- Given Teachers Table:
-- City
-- Chicago
-- Houston
-- Boston

-- Query 4 Result:
-- No cities from students, as there are cities in teachers that differ from each students.city.
