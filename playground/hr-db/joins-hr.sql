# Link : https://www.w3resource.com/sql-exercises/joins-hr/index.php

/*

27. From the following tables, write a SQL query to find out the full name (first and last name) of the employee with an ID and the name of the country where he/she is currently employed.

Sample table: countries
Sample table: locations 

*/

SELECT CONCAT(e.first_name, " ", e.last_name) AS full_name, e.employee_id, c.country_name
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
JOIN locations AS l ON d.location_id = l.location_id
JOIN countries AS c ON l.country_id = c.country_id;


# Self-joins :

/*
    Find all employee's manager.
    Check if employee is manager.
*/

SELECT 
    e.employee_id, e.first_name, e.salary AS "EMP_SAL", m.employee_id AS "Manager", m.first_name AS "ManagerID", m.salary AS "MAN_SAL", 
    CASE WHEN (SELECT COUNT(*) FROM employees WHERE e.employee_id = employees.manager_id) >= 1 THEN "YES" ELSE "NO" END AS IS_MANAGER 
FROM `employees` as e 
LEFT JOIN employees AS m
ON e.manager_id = m.employee_id
ORDER BY IS_MANAGER DESC, e.employee_id ASC;

/*
    Find all employee's who is getting more salary than their manager.
*/

SELECT 
    e.employee_id, e.first_name, e.salary AS "EMP_SAL", 
    m.employee_id AS "Manager", m.first_name AS "ManagerID", m.salary AS "MAN_SAL" 
FROM `employees` as e
JOIN employees AS m
ON e.manager_id = m.employee_id AND e.salary > m.salary;

/*
    Find all employee's who is getting more salary than any manager.
*/

SELECT 
    e.employee_id, e.first_name, e.salary AS "EMP_SAL", 
    m.employee_id AS "Manager", m.first_name AS "ManagerID", m.salary AS "MAN_SAL" 
FROM `employees` as e
JOIN employees AS m
ON e.salary > m.salary AND (SELECT COUNT(*) FROM employees WHERE e.employee_id = employees.manager_id) = 0;

/*
    Find employees who joined before their employees
*/

SELECT 
    e.employee_id, e.first_name, e.hire_date AS "EMP_HIREDATE", 
    m.employee_id AS "Manager", m.first_name AS "ManagerID", m.hire_date AS "MAN_HIREDATE" 
FROM `employees` as e
JOIN employees AS m
ON e.manager_id = m.employee_id AND e.hire_date < m.hire_date;

/*
    Select manager and id who are having atleast 2 employees directly reporting to them.
*/

SELECT manager_id, COUNT(*) AS Employees FROM employees GROUP BY manager_id HAVING Employees >= 2;
