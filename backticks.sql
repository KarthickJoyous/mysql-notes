/* Backticks are mainly used to prevent an error called "MySQL reserved word".

For example when you create a table with a column named "group" you get a warning. This is because you can make the following query:

*/

SELECT student_name, AVG(test_score) FROM student GROUP BY group

-- To make sure you don't get an error in your query you have to use backticks so your query becomes:

SELECT student_name, AVG(test_score) FROM student GROUP BY `group`

-- Not only column names can be surrounded by backticks, but also table names. For example when you need to JOIN multiple tables.

SELECT `users`.`username`, `groups`.`group` FROM `users`

/* 
As you can see using backticks around table and column names also make the query easier to read.

For example when you are used to write querys all in lower case:
*/

select student_name, AVG(test_score) from student group by group

select `student_name`, AVG(`test_score`) from `student` group by `group`.


-- If selecting columns from alias/table name use backticks on both side :

-- Ex :

SELECT `a`.`id`, `a`.`name` FROM `authors` as `a` join `books` as `b` on `a`.`id` = `b`.`author_id`;

SELECT `a.id`, `a.name` FROM `authors` as `a` join `books` as `b` on `a.id` = `b.author_id`; -- This will not work