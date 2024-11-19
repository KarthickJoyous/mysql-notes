-- Comments can be added for queries using the below methods :

-- Select * from users;

# Select * from users;

/* Select * from users; */

/*

Select * from users;
Select * from authors;

*/

--------------------------

-- Adding Comments To Columns :

CREATE TABLE menagerie.bird (
bird_id INT NOT NULL AUTO_INCREMENT,
species VARCHAR(300) DEFAULT NULL COMMENT 'You can include genus, but never subspecies.',
INDEX idx_species (species) COMMENT 'We must search on species often.',
PRIMARY KEY (bird_id)
) ENGINE=InnoDB COMMENT 'This table was inaugurated on February 10th.';

/* 

Using an = after COMMENT is optional. (Oﬃcial docs)

These comments, unlike the others, are saved with the schema and can be retrieved via SHOW CREATE TABLE or from information_schema.

*/