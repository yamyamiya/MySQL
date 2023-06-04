-- 1. **Создание таблиц**
-- 1) Создать таблицу Students
-- с полями:
-- - id целое число первичный ключ автоинкремент
-- - name строка 128 не null
-- - age целое число 
create database homework;
USE homework;
CREATE TABLE students(
id integer primary key auto_increment,
name varchar(128) NOT NULL,
age integer);

SELECT * FROM students;

-- 2) Создать таблицу Teachers
-- с полями:
-- - id целое число первичный ключ автоинкремент
-- - name строка 128 не null
-- - age целое число
CREATE TABLE teachers(
id integer primary key auto_increment,
name varchar(128) NOT NULL,
age integer);

SELECT * FROM teachers;

-- 3) Создать таблицу Competencies
-- с полями:
-- - id целое число первичный ключ автоинкремент
-- - title строка 128 не null

CREATE TABLE Competencies(
id integer primary key auto_increment,
title varchar(128) NOT NULL
);

SELECT * FROM Competencies;

-- 4) Создать таблицу Teachers2Competencies
-- с полями:
-- - id целое число первичный ключ автоинкремент
-- - teacher_id целое число
-- - competencies_id целое число

CREATE TABLE Teachers2Competencies(
id integer primary key auto_increment,
teacher_id integer,
competencies_id integer);

SELECT * FROM Teachers2Competencies;

-- 5) Создать таблицу Courses
-- - id целое число первичный ключ автоинкремент
-- - teacher_id целое число
-- - title строка 128 не null
-- - headman_id целое число

CREATE TABLE Courses(
id integer primary key auto_increment,
teacher_id integer,
title varchar(128) NOT NULL,
headman_id integer
);

SELECT * FROM Courses;

-- 6) Создать таблицу Students2Courses
-- - id целое число первичный ключ автоинкремент
-- - student_id целое число
-- - course_id целое число

CREATE TABLE Students2Courses(
id integer primary key auto_increment,
student_id integer,
course_id integer
);
SELECT * FROM Students2Courses;

-- 2. Заполнение таблиц
-- Добавить 6 записей в таблицу Students
-- Анатолий 29
-- Олег 25
-- Семен 27
-- Олеся 28
-- Ольга 31
-- Иван 22

INSERT INTO students (name, age) VALUES 
("Анатолий", 29),
("Олег", 25),
("Семен", 27),
("Олеся", 28),
("Ольга", 31),
("Иван", 22);

-- Добавить 6 записей в таблицу Teachers
-- Петр 39
-- Максим 35
-- Антон 37
-- Всеволод 38
-- Егор 41
-- Светлана 32

INSERT INTO teachers (name, age) VALUES 
("Петр", 39),
("Максим", 35),
("Антон", 37),
("Всеволод", 38),
("Егор", 41),
("Светлана", 32);

-- Добавить 4 записей в таблицу Competencies
-- Математика 
-- Информатика
-- Программирование
-- Графика

INSERT INTO Competencies (title) VALUES 
("Математика"),
("Информатика"),
("Программирование"),
("Графика");

-- Добавьте 6 записей в таблицу Teachers2Competencies
-- 1 1
-- 2 1
-- 2 3
-- 3 2
-- 4 1
-- 5 3
INSERT INTO Teachers2Competencies (teacher_id, competencies_id) VALUES 
(1, 1),
(2, 1),
(2, 3),
(3, 2),
(4, 1),
(5, 3);

-- Добавьте 5 записей в таблицу Courses
-- 1 Алгебра логики 2
-- 2 Математическая статистика 3
-- 4 Высшая математика 5
-- 5 Javascript 1
-- 5 Базовый Python 1

INSERT INTO Courses (teacher_id, title, headman_id) VALUES 
(1, "Алгебра логики", 2),
(2, "Математическая статистика", 3),
(4, "Высшая математика", 5),
(5, "Javascript", 1),
(5, "Базовый Python", 1);

-- Добавьте 5 записей в таблицу Students2Courses
-- 1 1
-- 2 1
-- 3 2
-- 3 3
-- 4 5

INSERT INTO Students2Courses (student_id, course_id) VALUES 
(1, 1),
(2, 1),
(3, 2),
(3, 3),
(4, 5);

-- 3. **Задачи**
-- 1) Вывести имена студентов и курсы, которые они проходят
SELECT 
	t1.name,
    t2.course_id
FROM students t1
INNER JOIN Students2Courses t2 
ON t1.id = t2.student_id;

SELECT
t1.name,
t2.course_id,
t3.title                  
FROM students t1
INNER JOIN Students2Courses t2 
ON t1.id = t2.student_id
INNER JOIN Courses t3
ON t3.id=t2.course_id;

-- 2) Вывести имена всех преподавателей с их компетенциями

SELECT 
	t1.name,
    t2.competencies_id
FROM teachers t1
INNER JOIN Teachers2Competencies t2 
ON t1.id = t2.teacher_id;

SELECT
t1.name,
t2.competencies_id,
t3.title                  
FROM teachers t1
INNER JOIN Teachers2Competencies t2 
ON t1.id = t2.teacher_id
INNER JOIN Competencies t3
ON t3.id=t2.competencies_id;

-- 3) Найти преподавателя, у которого нет компетенций
SELECT 
	name
FROM teachers
WHERE id NOT IN(
	SELECT teacher_id FROM Teachers2Competencies
);

-- 4) Найти имена студентов, которые не проходят ни один курс
SELECT 
	name
FROM students
WHERE id NOT IN(
	SELECT student_id FROM Students2Courses
);

-- 5) Найти курсы, которые не посещает ни один студент
SELECT 
	id, 
    title
FROM Courses
WHERE id NOT IN(
	SELECT course_id FROM Students2Courses
);

-- 6) Найти компетенции, которых нет ни у одного преподавателя
SELECT 
	id, 
    title
FROM Competencies
WHERE id NOT IN(
	SELECT competencies_id FROM Teachers2Competencies
);

-- 7) Вывести название курса и имя старосты
SELECT 
	t1.title,
    t2.name
FROM Courses t1
INNER JOIN students t2 
ON t1.headman_id = t2.id;

-- 8) Вывести имя студента и имена старост, которые есть на курсах, которые он проходит
SELECT
t1.name AS student_name,
t4.name AS headman_name           
FROM students t1
LEFT JOIN Students2Courses t2 
ON t1.id = t2.student_id
LEFT JOIN Courses t3
ON t2.course_id=t3.id
LEFT JOIN students t4
ON t3.headman_id=t4.id



