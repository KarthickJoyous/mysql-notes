/*
    Get students & their courses
*/

SELECT cs.student_id, s.name AS STUDENT, c.name AS COURSE, cs.course_id FROM course_student AS cs JOIN students AS s ON cs.student_id = s.id JOIN courses AS c ON cs.course_id = c.id;

SELECT s.id AS STUDENT_ID, s.name AS STUDENT, c.id AS COURSE_ID, c.name AS COURSE FROM students AS s JOIN course_student AS cs ON cs.student_id = s.id JOIN courses AS c ON c.id = cs.course_id;

SELECT c.id AS COURSE_ID, c.name AS COURSE, s.id AS STUDENT_ID, s.name AS STUDENT FROM courses AS c JOIN course_student AS cs ON cs.course_id = c.id JOIN students AS s ON s.id = cs.student_id;

/*
    Students with courses.
*/

SELECT s.id, s.name FROM students AS s JOIN course_student AS cs ON s.id = cs.student_id;

/*
    Student id, name with courses count
*/

SELECT s1.*, COUNT(*) AS COURSE_COUNT FROM students AS s1 JOIN course_student AS cs ON s1.id = cs.student_id GROUP BY s1.id;

SELECT s1.id, s1.name, TOTAL_COURSES.COURSE_COUNT FROM students AS s1
JOIN (SELECT s2.id, COUNT(*) AS COURSE_COUNT FROM students AS s2 JOIN course_student AS cs ON s2.id = cs.student_id GROUP BY s2.id) AS TOTAL_COURSES
ON s1.id = TOTAL_COURSES.id;

/*
    Courses based on students state.
*/

SELECT s.state, COUNT(*) AS TOTAL_COURSES FROM students AS s JOIN course_student AS cs ON s.id = cs.student_id GROUP BY s.state;