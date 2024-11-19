-- INSERT, ON DUPLICATE KEY UPDATE
/*
 ON DUPLICATE KEY UPDATE clause, instead of inserting a new row, it checks for an existing row, if exists that row will be updated.
 
 Using VALUES(`name`), we can access the value passed in the insert query.
 */
INSERT INTO `users` (`name`, `email`, `password`)
VALUES ('urolfson', 'urolfson@example.com', '123456');
INSERT INTO `users` (`name`, `email`, `password`)
VALUES ('urolfson', 'urolfson@example.com', '123456') ON DUPLICATE KEY
UPDATE `password` =
VALUES(`password`),
    `email` = CONCAT(
        VALUES(`name`),
            VALUES(`email`)
    );
-- Inserting multiple rows
INSERT INTO `users` (`name`, `email`, `password`)
VALUES (
        SUBSTRING(MD5(RAND()), 1, 10),
        CONCAT(SUBSTRING(MD5(RAND()), 1, 10), '@app.com'),
        '123456'
    ),
    (
        SUBSTRING(MD5(RAND()), 1, 10),
        CONCAT(SUBSTRING(MD5(RAND()), 1, 10), '@app.com'),
        '123456'
    ),
    (
        SUBSTRING(MD5(RAND()), 1, 10),
        CONCAT(SUBSTRING(MD5(RAND()), 1, 10), '@app.com'),
        '123456'
    );
/* 
 When importing large datasets, it may be preferable under certain circumstances to skip rows that would usually cause the query to fail 
 due to a column restraint e.g. duplicate primary keys. This can be done using INSERT IGNORE. 
 */
INSERT IGNORE INTO `users` (`name`, `email`, `password`)
VALUES (
        SUBSTRING(MD5(RAND()), 1, 10),
        CONCAT(SUBSTRING(MD5(RAND()), 1, 10), '@app.com'),
        '123456'
    ),
    (
        SUBSTRING(MD5(RAND()), 1, 10),
        CONCAT(SUBSTRING(MD5(RAND()), 1, 10), '@app.com'),
        '123456'
    ),
    (
        SUBSTRING(MD5(RAND()), 1, 10),
        'urolfson@example.com',
        -- Without IGNORE this will throw an error.
        '123456'
    );
/*
 The important thing to remember is that INSERT IGNORE will also silently skip other errors too, here is what Mysql
 oﬃcial documentations says:
 Data conversions that would trigger errors abort the statement if IGNORE is not > speciﬁed. With IGNORE,
 invalid values are adjusted to the closest values and >inserted; warnings are produced but the statement
 does not abort.
 */
# ---------------------------------------------------------------
/* 
 If you specify the value of the corresponding column for all columns in the table, you can ignore the column list in
 the INSERT statement as follows:
 INSERT INTO `my_table` VALUES
 ('data_1', 'data_2'),
 ('data_1', 'data_3'),
 ('data_4', 'data_5');
 */