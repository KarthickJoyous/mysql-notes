-- ADD COLUMN

ALTER TABLE restaurants ADD COLUMN address VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'address of restaurant' AFTER name;
ALTER TABLE restaurants ADD COLUMN city VARCHAR(30) NOT NULL DEFAULT '' COMMENT 'city of restaurant' AFTER address;
ALTER TABLE restaurants ADD COLUMN country_code CHAR(3) NOT NULL COMMENT 'country_code in alpha 3' AFTER city;

-- DROP COLUMN

ALTER TABLE restaurants DROP COLUMN address;
ALTER TABLE restaurants DROP COLUMN city;
ALTER TABLE restaurants DROP COLUMN country_code;

-- Change dataType of column

ALTER TABLE restaurants MODIFY country_code CHAR(2) COMMENT 'country_code in alpha 2';

-- Change dataType & name of column

ALTER TABLE restaurants CHANGE address state VARCHAR(50) COMMENT 'state of restaurant' AFTER city;

-- Add index 

ALTER TABLE restaurants ADD INDEX idx_name(name);

-- Change table name

ALTER TABLE restaurants RENAME TO hotels;

ALTER TABLE hotels RENAME TO restaurants;

RENAME TABLE restaurants to hotels;

RENAME TABLE hotels to restaurants;