CREATE DATABASE students_teachers;

use students_teachers;

-- Step 1: Create the schema for `students` and `teachers` tables
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50)
);

CREATE TABLE teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50)
);

-- Step 2: Insert sample data into the `students` table
INSERT INTO students (name, city, state) VALUES
('Alice', 'New York', 'NY'),
('Bob', 'Los Angeles', 'CA'),
('Charlie', 'Chicago', 'IL'),
('Daisy', 'Houston', 'TX'),
('Eve', 'Phoenix', 'AZ'),
('Frank', 'Philadelphia', 'PA'),
('Grace', 'San Antonio', 'TX'),
('Hannah', 'San Diego', 'CA'),
('Ivy', 'Dallas', 'TX'),
('Jack', 'San Jose', 'CA'),
('Kara', 'Austin', 'TX'),
('Leo', 'Jacksonville', 'FL'),
('Mia', 'San Francisco', 'CA'),
('Nathan', 'Columbus', 'OH'),
('Olivia', 'Indianapolis', 'IN');

-- Step 3: Insert sample data into the `teachers` table
INSERT INTO teachers (name, city, state) VALUES
('Peter', 'New York', 'NY'),
('Quinn', 'Miami', 'FL'),
('Rachel', 'Chicago', 'IL'),
('Steve', 'Houston', 'TX'),
('Tina', 'Seattle', 'WA'),
('Uma', 'San Antonio', 'TX'),
('Victor', 'Dallas', 'TX'),
('Wendy', 'Denver', 'CO'),
('Xander', 'Atlanta', 'GA'),
('Yara', 'Boston', 'MA'),
('Zane', 'Austin', 'TX'),
('Alice', 'Jacksonville', 'FL'),
('Bruce', 'San Francisco', 'CA'),
('Chris', 'Columbus', 'OH'),
('Diana', 'Indianapolis', 'IN');