DELETE FROM users
WHERE id = 1050;
/* 
 
 We can use joins to delete rows as well.
 
 Remove only rows from pets :
 
 DELETE p2
 FROM people p1
 JOIN pets p2
 ON p2.ownerId = p1.id
 WHERE p1.name = 'Paul';
 
 Remove rows from both tables :
 
 DELETE p1, p2
 FROM people p1
 JOIN pets p2
 ON p2.ownerId = p1.id
 WHERE p1.name = 'Paul';
 
 */
-- Delete all rows from a table
-- DELETE FROM users;
/*
 DELETE vs TRUNCATE
 
 TRUNCATE tableName;
 This will delete all the data and reset AUTO_INCREMENT index. It's much faster than DELETE FROM tableName on a
 huge dataset. It can be very useful during development/testing.
 
 When you truncate a table SQL server doesn't delete the data, it drops the table and recreates it
 */