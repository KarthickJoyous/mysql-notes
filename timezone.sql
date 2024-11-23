SELECT sysdate(); -- 2024-11-22 08:57:57

/*
    In MySQL, the SYSDATE() function returns the current date and time (timestamp) of the system on which the MySQL server is running.
    SYSDATE() returns the actual time when it is executed.
    If the query takes some time to execute, the time returned by SYSDATE() will reflect the exact moment it is called during query execution, not when the query started.
    
    -- SYSDATE() is evaluated every time it is called, making it dynamic and reflective of real-time execution.
    -- NOW() is executed once per query. Its value is stored internally and reused for all calls in that query.

    Use SYSDATE() if you need a real-time timestamp that updates dynamically within the query.
    Use NOW() if you need a consistent timestamp across the entire query execution.

    -- The CURRENT_TIMESTAMP() function in MySQL is similar to NOW() and is used to retrieve the current date and time based on the system's clock. 
    It returns a timestamp value with the current date and time in the YYYY-MM-DD HH:MM:SS format.

    CURRENT_TIMESTAMP() is part of the SQL standard and is supported in other relational databases like PostgreSQL, Oracle, and SQL Server.
    NOW() is MySQL-specific but widely used for its brevity.
*/

SELECT NOW() AS now_time, SYSDATE() AS sysdate_time, SLEEP(2) AS pause, NOW() AS now_after_pause, SYSDATE() AS sysdate_after_pause;

/* 

[
  {
    "now_time": "2024-11-22 09:08:16",
    "sysdate_time": "2024-11-22 09:08:16",
    "pause": "0",
    "now_after_pause": "2024-11-22 09:08:16",
    "sysdate_after_pause": "2024-11-22 09:08:18"
  }
]

*/

-- GET TIMETAMPS :

SELECT CURRENT_DATE(); -- 2024-11-22

SELECT CURRENT_TIME(); -- 08:59:01

SELECT CURRENT_TIMESTAMP(); -- 2024-11-22 08:59:17

SELECT UTC_DATE(); -- 2024-11-22

SELECT UTC_TIME(); -- 03:30:00

SELECT UTC_TIMESTAMP(); -- 2024-11-22 03:30:16

SELECT NOW(); -- 2024-11-22 09:08:59

-- Convert Timezones :

SELECT UTC_TIMESTAMP() as 'UTC', CONVERT_TZ(UTC_TIMESTAMP(), '+00:00', '+05:30') as 'IST';

/* 

{
  "UTC": "2024-11-22 03:54:31",
  "IST": "2024-11-22 09:24:31"
}

*/