# Link : https://www.w3resource.com/sql-exercises/sorting-and-filtering-hr/index.php

/*

1. From the following table, write a SQL query to find those employees whose salaries are less than 6000.

Return full name (first and last name), and salary.

Sample table: employees

*/

SELECT CONCAT(first_name, " ", last_name) AS full_name, salary FROM employees WHERE salary < 6000;

/*

2. From the following table, write a SQL query to find those employees whose salary is higher than 8000.
Return first name, last name and department number and salary.

Sample table: employees

*/

SELECT first_name, last_name, department_id, salary FROM employees WHERE salary > 8000;

/*

3. From the following table, write a SQL query to find those employees whose last name is "McEwen".
Return first name, last name and department ID.

Sample table: employees

*/

SELECT first_name, last_name, department_id FROM employees WHERE last_name = "McEwen";

/*

4. From the following table, write a SQL query to identify employees who do not have a department number.
Return employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary,commission_pct, manager_id and department_id.

Sample table: employees

*/

SELECT * FROM employees WHERE department_id IS NULL;

/*

5. From the following table, write a SQL query to find the details of 'Marketing' department. Return all fields.

Sample table: departments

*/

SELECT * FROM departments WHERE department_name = "Marketing";

/*

6. From the following table, write a SQL query to find those employees whose first name does not contain the letter ‘M’.
Sort the result-set in ascending order by department ID.
Return full name (first and last name together), hire_date, salary and department_id.

Sample table: employees

*/

# Not Case-sentitive :

SELECT CONCAT(first_name, " ", last_name) AS full_name, hire_date, salary, department_id FROM employees WHERE first_name NOT LIKE "%m%" ORDER BY department_id;

# Case-sentitive (BINARY) :

SELECT CONCAT(first_name, " ", last_name) AS full_name, hire_date, salary, department_id FROM employees WHERE first_name NOT LIKE BINARY "%m%" ORDER BY department_id;

# Using REGEXP :

SELECT CONCAT(first_name, " ", last_name) AS full_name, hire_date, salary, department_id FROM employees WHERE first_name NOT REGEXP "m" ORDER BY department_id;

/*

7. From the following table, write a SQL query to find those employees who earn between 8000 and 12000 (Begin and end values are included.) and get some commission.
These employees joined before ‘2003-06-05’ and were not included in the department numbers 40, 120 and 70.
Return all fields.

Sample table: employees

*/

SELECT * FROM employees
WHERE salary BETWEEN 8000 AND 12000
AND  commission_pct IS NOT NULL
AND hire_date < "2003-06-05"
AND department_id NOT IN (40,120,70);

/*

8. From the following table, write a SQL query to find those employees who do not earn any commission.
Return full name (first and last name), and salary.

Sample table: employees

*/

SELECT CONCAT(first_name, " ", last_name) AS full_name, salary FROM employees WHERE commission_pct IS NULL;

/*

9. From the following table, write a SQL query to find the employees whose salary is in the range 9000,17000 (Begin and end values are included).
Return full name, contact details and salary.

Sample table: employees

*/

SELECT CONCAT(first_name, " ", last_name) AS full_name, email, phone_number, salary FROM employees WHERE salary BETWEEN 9000 AND 17000;

/*

10. From the following table, write a SQL query to find the employees whose first name ends with the letter ‘m’.
Return the first and last name, and salary.

Sample table: employees

*/

SELECT first_name, last_name, salary FROM employees WHERE first_name REGEXP "m$";

SELECT first_name, last_name, salary FROM employees WHERE first_name LIKE "%m";

/*

11. From the following table, write a SQL query to find those employees whose salaries are not between 7000 and 15000 (Begin and end values are included).
Sort the result-set in ascending order by the full name (first and last). Return full name and salary.

Sample table: employees

*/

SELECT CONCAT(first_name, " ", last_name) AS full_name, salary FROM employees WHERE salary NOT BETWEEN 7000 AND 15000 ORDER BY full_name;

/*

12. From the following table, write a SQL query to find those employees who were hired between November 5th, 2007 and July 5th, 2009.
Return full name (first and last), job id and hire date.

Sample table: employees

*/

SELECT CONCAT(first_name, " ", last_name) AS full_name, job_id, hire_date FROM employees WHERE DATE(hire_date) BETWEEN "2007-11-05" AND "2009-07-05";

/*

13. From the following table, write a SQL query to find those employees who work either in department 70 or 90.
Return full name (first and last name), department id.

Sample table: employees

*/

SELECT CONCAT(first_name, " ", last_name) AS full_name, department_id FROM employees WHERE department_id IN (70,90);

SELECT CONCAT(first_name, " ", last_name) AS full_name, department_id FROM employees WHERE department_id = 70 OR department_id = 90;

/*

14. From the following table, write a SQL query to find those employees who work under a manager.
Return full name (first and last name), salary, and manager ID.

Sample table: employees

*/

SELECT CONCAT(first_name, " ", last_name) AS full_name, salary, manager_id FROM employees WHERE manager_id IS NOT NULL;

/*

15. From the following table, write a SQL query to find the employees who were hired before June 21st, 2002.
Return all fields.

Sample table: employees

*/

SELECT * FROM employees WHERE hire_date < "2002-06-21";

/*

16. From the following table, write a SQL query to find the employees whose managers hold the ID 120, 103, or 145.
Return first name, last name, email, salary and manager ID.

Sample table: employees

*/

SELECT first_name, last_name, email, salary, manager_id FROM employees WHERE manager_id IN (120,103,145);

/*

17. From the following table, write a SQL query to find employees whose first names contain the letters D, S, or N.
Sort the result-set in descending order by salary.
Return all fields.

Sample table: employees

*/

SELECT * FROM employees WHERE first_name REGEXP "[D,S,N]" ORDER BY salary DESC;

SELECT * FROM employees WHERE first_name LIKE "%D%" OR first_name LIKE "%S%" OR first_name LIKE "%N%" ORDER BY salary DESC;

/*

18. From the following table, write a SQL query to find those employees who earn above 11000 or the seventh character in their phone number is 3.
Sort the result-set in descending order by first name.
Return full name (first name and last name), hire date, commission percentage, email, and telephone separated by '-', and salary.

Sample table: employees

*/

SELECT CONCAT(first_name, " ", last_name) AS full_name, hire_date, commission_pct, email, REPLACE(phone_number, ".", "-") FROM employees WHERE salary > 11000 OR SUBSTRING(phone_number, 7, 1) = 3 ORDER BY first_name ASC;

SELECT CONCAT(first_name, " ", last_name) AS full_name, hire_date, commission_pct, email, REPLACE(phone_number, ".", "-") FROM employees WHERE salary > 11000 OR phone_number LIKE "______3%" ORDER BY first_name ASC;

/*

19. From the following table, write a SQL query to find those employees whose first name contains a character 's' in the third position.
Return first name, last name and department id.

Sample table: employees

*/

SELECT first_name, last_name, department_id FROM employees WHERE first_name LIKE "__s%";

/*

20. From the following table, write a SQL query to find those employees work in the departments that are not part of the department 50 or 30 or 80.
Return employee_id, first_name,job_id, department_id.

Sample table: employees

*/

SELECT employee_id, first_name, job_id, department_id FROM employees WHERE department_id NOT IN (50,30,80);

/*

21. From the following table, write a SQL query to find the employees whose department numbers are included in 30, 40, or 90.
Return employee id, first name, job id, department id.

Sample table: employees

*/

SELECT employee_id, first_name, job_id, department_id FROM employees WHERE department_id IN (30,40,90);

/*

22. From the following table, write a SQL query to find those employees who worked more than or equal two jobs in the past.
Return employee id.

*/

SELECT e.employee_id FROM employees as e
JOIN job_history AS jh
ON e.employee_id = jh.employee_id
GROUP BY jh.employee_id
HAVING COUNT(*) >= 2;

SELECT employee_id FROM job_history GROUP BY employee_id HAVING COUNT(*) >= 2;

/*

23. From the following table,
write a SQL query to count the number of employees, the sum of all salary, and difference between the highest salary and lowest salaries by each job id.
Return job_id, count, sum, salary_difference.

Sample table: employee

*/

SELECT job_id, COUNT(job_id) AS count, SUM(salary) AS sum, MAX(salary) - MIN(salary) AS salary_difference FROM employee GROUP BY job_id;

/*

24. From the following table, write a SQL query to find each job ids where two or more employees worked for more than 300 days.
Return job id.

Sample table: job_history

*/

SELECT jh.job_id FROM job_history as jh WHERE TIMESTAMPDIFF(DAY, jh.start_date, jh.end_date) > 300 GROUP BY jh.job_id HAVING COUNT(*) >= 2;

/*

25. From the following table, write a SQL query to count the number of cities in each country.
Return country ID and number of cities.

Sample table : locations

*/

SELECT country_id, COUNT(*) FROM locations GROUP BY country_id;

/*

26. From the following table, write a SQL query to count the number of employees worked under each manager.
Return manager ID and number of employees.

Sample table: employees

*/

SELECT manager_id, COUNT(*) FROM employees GROUP BY manager_id;

/*

27. From the following table, write a SQL query to find all jobs.
Sort the result-set in descending order by job title.
Return all fields.

Sample table : jobs

*/

SELECT * FROM jobs ORDER BY job_title DESC;

/*

28. From the following table, write a SQL query to find all those employees who are either Sales Representative or Sales Manager.
Return first name, last name and hire date.

Sample table: employees

*/

SELECT first_name, last_name, hire_date FROM employees WHERE job_id IN (SELECT job_id FROM jobs WHERE job_title IN ("Sales Representative", "Sales Manager"));

/*

29. From the following table, write a SQL query to calculate the average salary of employees who receive a commission percentage for each department.
Return department id, average salary.

Sample table: employees

*/

SELECT department_id, AVG(salary) FROM employees WHERE commission_pct IS NOT NULL GROUP BY department_id;

/*

30. From the following table, write a SQL query to find the departments where any manager manages four or more employees.
Return department_id.

Sample table: employees

*/

SELECT DISTINCT department_id
FROM employees
GROUP BY department_id, manager_id
HAVING COUNT(employee_id) >= 4;

SELECT department_id, manager_id, COUNT(*) FROM employees GROUP BY department_id,manager_id ORDER BY manager_id;

/*

31. From the following table, write a SQL query to find the departments where more than ten employees receive commissions.
Return department id.

Sample table: employees

*/

SELECT department_id FROM employees WHERE commission_pct IS NOT NULL GROUP BY department_id HAVING COUNT(commission_pct) > 10;

/*

    IGNORE
    
    32. From the following table, write a SQL query to find those employees who have completed their previous jobs.
    Return employee ID, end_date.

    Sample table : job_history

*/

SELECT employee_id, end_date FROM job_history AS jh1 WHERE (SELECT COUNT(*) FROM job_history AS jh2 WHERE jh1.employee_id = jh2.employee_id) > 1;

SELECT employee_id, end_date FROM job_history WHERE end_date IS NOT NULL;

/*

33. From the following table, write a SQL query to find those employees who do not have commission percentage and have salaries between 7000, 12000 (Begin and end values are included.) and who are employed in the department number 50.
Return all the fields of employees.

Sample table: employees

*/

SELECT * FROM employees WHERE commission_pct IS NULL AND salary BETWEEN 7000 AND 12000 AND department_id = 50;

/*

34. From the following table, write a SQL query to compute the average salary of each job ID.
Exclude those records where average salary is on or lower than 8000.
Return job ID, average salary.

Sample table: employees

*/

SELECT job_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY job_id
HAVING avg_salary > 8000;

/*

35. From the following table, write a SQL query to find those job titles where maximum salary falls between 12000 and 18000 (Begin and end values are included.).
Return job_title, max_salary-min_salary.

Sample table : jobs

*/

SELECT job_title, max_salary - min_salary FROM jobs WHERE max_salary BETWEEN 12000 AND 18000;

/*

36. From the following table, write a SQL query to find the employees whose first or last name begins with 'D'.
Return first name, last name.

Sample table: employees

*/

SELECT first_name, last_name FROM employees WHERE first_name LIKE "d%" OR last_name LIKE "d%";

/*

37. From the following table, write a SQL query to find details of those jobs where the minimum salary exceeds 9000.
Return all the fields of jobs.

Sample table : jobs

*/

SELECT * FROM jobs WHERE min_salary > 9000;

/*

38. From the following table, write a SQL query to find those employees who joined after 7th September 1987.
Return all the fields.

Sample table: employees

*/

SELECT * FROM employees WHERE hire_date > "1987-09-07";