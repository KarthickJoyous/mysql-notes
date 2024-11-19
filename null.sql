SELECT a.id as author_id, a.name, b.title, b.id FROM authors as a left join books as b on a.id = b.author_id where b.id IS NULL ORDER BY b.id;

SELECT COUNT(*) FROM authors as a left join books as b on a.id = b.author_id where b.id IS NULL ORDER BY b.id;

-- --------------------------

-- NULL & NOT NULL :

SELECT id, name from users where email_verified_at IS NULL;

SELECT id, name, email_verified_at from users where email_verified_at IS NOT NULL;

---

SELECT id, name, email_verified_at from users where email_verified_at IS NOT NULL;

SELECT id, name, email_verified_at from users where email_verified_at != NULL;

/*

The difference in results stems from how SQL handles comparisons involving NULL values.

1.email_verified_at IS NOT NULL:

This is the correct way to check if email_verified_at has a value.
The IS NOT NULL operator checks explicitly whether a column is not null.
It evaluates to TRUE for all rows where email_verified_at has a value (not NULL).

Example:

email_verified_at = '2024-01-01' -> TRUE
email_verified_at = NULL         -> FALSE

2.email_verified_at != NULL:

This is incorrect because in SQL, NULL represents an unknown or undefined value.
Any comparison with NULL (e.g., = NULL, != NULL) will always evaluate to UNKNOWN.
The row will not satisfy the condition, even if email_verified_at has a value.

Example:

email_verified_at = '2024-01-01' -> UNKNOWN
email_verified_at = NULL         -> UNKNOWN

*/