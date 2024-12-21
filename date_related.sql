SELECT NOW() + INTERVAL 1 DAY;

SELECT CURDATE() - INTERVAL 4 DAY;

SELECT ABS(TIMESTAMPDIFF(SECOND, '2024-01-01 10:10:20', '2024-01-01 10:45:59')); -- 2139

SELECT ABS(TIMESTAMPDIFF(MINUTE, '2024-01-01 10:10:20', '2024-01-01 10:45:59')); -- 35

SELECT ABS(TIMESTAMPDIFF(HOUR, '2024-01-01 14:00:00', '2024-01-01 10:00:00')); -- 4

SELECT ABS(TIMESTAMPDIFF(DAY, "2024-10-01", "2024-01-01")); -- 274

SELECT ABS(TIMESTAMPDIFF(WEEK, "2024-10-01", "2024-01-01")); -- 39  

SELECT ABS(TIMESTAMPDIFF(MONTH, "2024-10-01", "2024-01-01")); -- 9

SELECT ABS(TIMESTAMPDIFF(QUARTER, "2023-01-01", "2024-10-01")); -- 7

SELECT ABS(TIMESTAMPDIFF(YEAR, "2023-01-01", "2024-10-01")); -- 1

SELECT employee_name, hire_date, CONCAT("JOINED ", ABS(TIMESTAMPDIFF(DAY, hire_date, CURDATE())), IF(ABS(TIMESTAMPDIFF(DAY, hire_date, CURDATE())) > 1, " DAYS AGO", " DAY AGO")) as joined FROM employees ORDER BY employee_id DESC;

SELECT u.name, p.dob, ABS(TIMESTAMPDIFF(YEAR, p.dob, CURDATE())) as "age" from users as u join profiles as p on u.id = p.user_id order by u.id desc;

-- ---------------------------

SELECT 
    e1.employee_name as "E1-NAME", 
    e1.hire_date as "E1-HIRE_DATE", 
    e2.employee_name as "E2-NAME", 
    e2.hire_date as "E2-HIRE_DATE", 
    CASE 
        WHEN e1.hire_date > e2.hire_date THEN CONCAT(e1.employee_name, " JOINED ", ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)), IF(ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)) > 1, " MONTHS ", " MONTH "), "AFTER ", e2.employee_name)
        ELSE CONCAT(e1.employee_name, " JOINED ", ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)), IF(ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)) > 1, " MONTHS ", " MONTH "), "BEFORE ", e2.employee_name)
    END AS "Joined"
from employees as e1
cross join employees as e2
where e1.employee_id = 1 and e1.employee_id != e2.employee_id
ORDER BY e1.hire_date desc;

SELECT 
    e1.employee_name as "E1-NAME", 
    e1.hire_date as "E1-HIRE_DATE", 
    e2.employee_name as "E2-NAME", 
    e2.hire_date as "E2-HIRE_DATE", 
    CASE 
        WHEN e1.hire_date > e2.hire_date THEN CONCAT(e1.employee_name, " JOINED ", ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)), IF(ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)) > 1, " MONTHS ", " MONTH "), "AFTER ", e2.employee_name)
        ELSE CONCAT(e1.employee_name, " JOINED ", ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)), IF(ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)) > 1, " MONTHS ", " MONTH "), "BEFORE ", e2.employee_name)
    END AS "Joined"
from employees as e1
cross join employees as e2
where e1.employee_id != e2.employee_id
ORDER BY e1.hire_date desc;

SELECT 
    e1.employee_name as "E1-NAME", 
    e1.hire_date as "E1-HIRE_DATE", 
    e2.employee_name as "E2-NAME", 
    e2.hire_date as "E2-HIRE_DATE", 
    CASE 
        WHEN e1.hire_date > e2.hire_date THEN CONCAT(e1.employee_name, " JOINED ", ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)), IF(ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)) > 1, " MONTHS ", " MONTH "), "AFTER ", e2.employee_name)
        ELSE CONCAT(e1.employee_name, " JOINED ", ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)), IF(ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)) > 1, " MONTHS ", " MONTH "), "BEFORE ", e2.employee_name)
    END AS "Joined"
from employees as e1
join employees as e2
where e1.employee_id != e2.employee_id
ORDER BY e1.hire_date desc;

-- ---------------------------

SELECT 
    e1.employee_name as "E1-NAME", 
    e1.hire_date as "E1-HIRE_DATE", 
    e2.employee_name as "E2-NAME", 
    e2.hire_date as "E2-HIRE_DATE", 
    CASE 
        WHEN e1.hire_date > e2.hire_date THEN CONCAT(e1.employee_name, " JOINED ", ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)), IF(ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)) > 1, " MONTHS ", " MONTH "), "AFTER ", e2.employee_name)
        WHEN e2.hire_date > e1.hire_date THEN CONCAT(e1.employee_name, " JOINED ", ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)), IF(ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)) > 1, " MONTHS ", " MONTH "), "BEFORE ", e2.employee_name)
        ELSE CONCAT(e1.employee_name, " AND ", e2.employee_name , " JOINED ON SAME DAY")
    END AS "Joined"
from employees as e1
cross join employees as e2
where e1.employee_id = 1 and e1.employee_id != e2.employee_id
ORDER BY e1.hire_date desc;

SELECT 
    e1.employee_name as "E1-NAME", 
    e1.hire_date as "E1-HIRE_DATE", 
    e2.employee_name as "E2-NAME", 
    e2.hire_date as "E2-HIRE_DATE", 
    CASE 
        WHEN e1.hire_date > e2.hire_date THEN CONCAT(e1.employee_name, " JOINED ", ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)), IF(ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)) > 1, " MONTHS ", " MONTH "), "AFTER ", e2.employee_name)
        WHEN e2.hire_date > e1.hire_date THEN CONCAT(e1.employee_name, " JOINED ", ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)), IF(ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)) > 1, " MONTHS ", " MONTH "), "BEFORE ", e2.employee_name)
        ELSE CONCAT(e1.employee_name, " AND ", e2.employee_name , " JOINED ON SAME DAY")
    END AS "Joined"
from employees as e1
cross join employees as e2
where e1.employee_id != e2.employee_id
ORDER BY e1.hire_date desc;

SELECT 
    e1.employee_name as "E1-NAME", 
    e1.hire_date as "E1-HIRE_DATE", 
    e2.employee_name as "E2-NAME", 
    e2.hire_date as "E2-HIRE_DATE", 
    CASE 
        WHEN e1.hire_date > e2.hire_date THEN CONCAT(e1.employee_name, " JOINED ", ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)), IF(ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)) > 1, " MONTHS ", " MONTH "), "AFTER ", e2.employee_name)
        WHEN e2.hire_date > e1.hire_date THEN CONCAT(e1.employee_name, " JOINED ", ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)), IF(ABS(TIMESTAMPDIFF(MONTH, e1.hire_date, e2.hire_date)) > 1, " MONTHS ", " MONTH "), "BEFORE ", e2.employee_name)
        ELSE CONCAT(e1.employee_name, " AND ", e2.employee_name , " JOINED ON SAME DAY")
    END AS "Joined"
from employees as e1
join employees as e2
where e1.employee_id != e2.employee_id
ORDER BY e1.hire_date desc;

-- If ON clause is not specified in INNER JOIN, then it will return the Cartesian product (Cross JOIN) of the tables involved in the JOIN.