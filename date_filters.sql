-- Filters between two days

# Note : 2016 was a leap year.

SELECT * FROM `course_student`
    WHERE created_at >= "2016-02-25" AND created_at <= "2016-02-25" + INTERVAL 5 DAY 
order by created_at desc;

SELECT * FROM `course_student`
    WHERE created_at >= "2016-02-25" AND created_at <= "2016-03-01"
order by created_at desc;

SELECT * FROM `course_student`
    WHERE created_at BETWEEN "2016-02-25" AND "2016-02-25" + INTERVAL 5 DAY 
order by created_at desc;

SELECT * FROM `course_student`
    WHERE created_at BETWEEN "2016-02-25" AND "2016-03-01"
order by created_at desc;

/* 
    -- The above queries should return rows, equals or after 2016-02-25 and equals or before 2016-03-01.
    -- if a created_at stored in the range Between 2016-03-01 00:00:01 AND 2016-03-01 23:59:59, will not be returned.
    -- Reason is created_at stored as date+time but we are trying to query just a date (2016-02-25) (2016-03-01), so sql will try to search between (2016-02-25 00:00:00 -- 2016-03-01 00:00:00).
    -- So any date after 2016-03-01 00:00:00 willl not be returned in the result.
    -- Note : 2016-03-01 00:00:00 will be returned.
*/

/*
    Solution NO : 1

    Apply Date() to created_at to check only date exclude time.
*/

SELECT * FROM `course_student`
    WHERE DATE(created_at) >= "2016-02-25" AND DATE(created_at) <= "2016-02-25" + INTERVAL 5 DAY 
order by created_at desc;

SELECT * FROM `course_student`
    WHERE DATE(created_at) >= "2016-02-25" AND DATE(created_at) <= "2016-03-01"
order by created_at desc;

SELECT * FROM `course_student`
    WHERE DATE(created_at) BETWEEN "2016-02-25" AND "2016-02-25" + INTERVAL 5 DAY 
order by created_at desc;

SELECT * FROM `course_student`
    WHERE DATE(created_at) BETWEEN "2016-02-25" AND "2016-03-01"
order by created_at desc;

/*
    Solution NO : 2

    Add full timestamp in second value.
*/

SELECT * FROM `course_student`
    WHERE created_at >= "2016-02-25" AND created_at <= "2016-02-25 23:59:59" + INTERVAL 5 DAY 
order by created_at desc;

SELECT * FROM `course_student`
    WHERE created_at >= "2016-02-25" AND created_at <= "2016-03-01 23:59:59"
order by created_at desc;

SELECT * FROM `course_student`
    WHERE created_at BETWEEN "2016-02-25" AND "2016-02-25 23:59:59" + INTERVAL 5 DAY 
order by created_at desc;

SELECT * FROM `course_student`
    WHERE created_at BETWEEN "2016-02-25" AND "2016-03-01 23:59:59"
order by created_at desc;