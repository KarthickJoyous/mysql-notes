-- 1. You can set a variable to a speciﬁc, string, number, date using SET

SET @author_id = 19;

SELECT * FROM books WHERE author_id = @author_id;

-- 2. you can set a variable to be the result of a select statement using :=

SELECT  @author_id := 19;

/*

(Note: You need to use := when assigning a variable not using the SET syntax, because in other statements,
(select, update...) the "=" is used to compare, so when you add a colon before the "=", you are saying "This is
not a comparison, this is a SET".)

*/