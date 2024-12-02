UPDATE users
SET 
    `name` = 'John'
WHERE `id` = 1048;

UPDATE users
SET 
    `name` = 'John',
    `email` = 'john@app.com',
    `email_verified_at` = NOW()
WHERE `id` = 1048;

/*
 UPDATE ALL ROWS :
 
 UPDATE users SET `name` = 'John';
 
 This will update all the rows from users table as no where clause added.
 
 NOTE : It is necessary to use conditional clauses (WHERE) in UPDATE query. If you do not use any conditional clause then all records of that table's attribute will be updated.
 */
-- Bulk UPDATE
-- By bulk updating only one query can be sent to the server instead of one query for each row to update. The cases should contain all possible parameters looked up in the WHERE clause.
UPDATE users
SET name = (
        CASE
            id
            WHEN 1 THEN 'Karl'
            WHEN 2 THEN 'Tom'
            WHEN 3 THEN 'Mary'
        END
    )
WHERE id IN (1, 2, 3);