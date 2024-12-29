CREATE TABLE entities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    gender ENUM('male', 'female', 'others') NOT NULL
);

INSERT INTO entities (name, city, gender) VALUES
('Alice', 'New York', 'female'),
('Bob', 'Los Angeles', 'male'),
('Charlie', 'Chicago', 'others'),
('Diana', 'New York', 'female'),
('Ethan', 'Los Angeles', 'male'),
('Fiona', 'Chicago', 'female'),
('George', 'New York', 'male'),
('Hannah', 'San Francisco', 'female'),
('Ian', 'Miami', 'male'),
('Jenna', 'New York', 'female'),
('Kevin', 'Los Angeles', 'male'),
('Luna', 'San Francisco', 'others'),
('Michael', 'Miami', 'male'),
('Nina', 'New York', 'female'),
('Oscar', 'Los Angeles', 'male'),
('Paula', 'New York', 'female'),
('Quincy', 'Chicago', 'male'),
('Rita', 'San Francisco', 'female'),
('Sam', 'Miami', 'others'),
('Tina', 'Los Angeles', 'female');

/*
    Delete entities if has duplicates.
*/
DELETE e1 FROM entities AS e1
JOIN entities AS e2
ON e1.city = e2.city AND e1.id < e2.id;

/*
    Switch places of gender male, female.
*/

UPDATE entities SET female = (CASE female WHEN "Male" THEN "Female" ELSE "Male" END) WHERE gender IN ("Male", "Female");

-- -------------------------------------------------------------------------------------------------------

CREATE TABLE states (
    city VARCHAR(20),
    pincode VARCHAR(6)
);

INSERT INTO states (city, pincode) VALUES
('New York', '10001'),
('Los Angeles', '90001'),
('Chicago', '60601'),
('Houston', '77001'),
('Phoenix', '85001'),
('Philadelphia', '19101'),
('San Antonio', '78201'),
('San Diego', '92101'),
('Dallas', '75201'),
('San Jose', '95101'),
('Austin', '73301'),
('Jacksonville', '32099'),
('Fort Worth', '76101'),
('Columbus', '43085'),
('San Francisco', '94101'),
('Charlotte', '28201'),
('Indianapolis', '46201'),
('Seattle', '98101'),
('Denver', '80201'),
('Washington', '20001');

/*
    Assign row number when no unique identifier exists in a table.
*/

SELECT *, ROW_NUMBER() OVER(ORDER BY city) AS id FROM states;
