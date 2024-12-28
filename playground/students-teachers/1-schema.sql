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

CREATE TABLE courses(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30)
);

CREATE TABLE course_student(
	id INT PRIMARY KEY AUTO_INCREMENT,
   	course_id INT,
    student_id INT
);

INSERT INTO courses (name) VALUES 
('Math 102'),
('Physics 102'),
('Chemistry 102'),
('Biology 102'),
('Computer Science 102'),
('History 102'),
('Economics 102'),
('Psychology 102'),
('Philosophy 102'),
('Sociology 102'),
('Art 102'),
('Music 102'),
('English 102'),
('Business 102'),
('Engineering 102'),
('Math 201'),
('Physics 201'),
('Chemistry 201'),
('Biology 201'),
('Computer Science 201'),
('History 201'),
('Economics 201'),
('Psychology 201'),
('Philosophy 201'),
('Sociology 201'),
('Art 201'),
('Music 201'),
('English 201'),
('Business 201'),
('Engineering 201');

INSERT INTO course_student (course_id, student_id) VALUES 
(1, 5),
(2, 3),
(3, 8),
(4, 12),
(5, 14),
(6, 9),
(7, 7),
(8, 6),
(9, 15),
(10, 10),
(11, 2),
(12, 13),
(13, 1),
(14, 4),
(15, 11),
(16, 8),
(17, 6),
(18, 12),
(19, 5),
(20, 10),
(21, 3),
(22, 9),
(23, 2),
(24, 13),
(25, 14),
(26, 15),
(27, 1),
(28, 7),
(29, 11),
(30, 4),
(1, 8),
(2, 12),
(3, 9),
(4, 5),
(5, 6),
(6, 13),
(7, 3),
(8, 2),
(9, 7),
(10, 14),
(11, 1),
(12, 15),
(13, 4),
(14, 11),
(15, 10),
(16, 8),
(17, 12),
(18, 9),
(19, 6),
(20, 2);