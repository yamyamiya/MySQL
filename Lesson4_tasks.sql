use learn;
CREATE TABLE goods2(
 id integer primary key auto_increment,
 title varchar(128),
 quantity integer CHECK (quantity BETWEEN 0 AND 1000)
 );
 
 INSERT INTO 
 goods2 (title, quantity)
 VALUES
	('велосипед', 4),
    ('лыжи', 5),
    ('коньки', 7),
    ('скейт', 2);

ALTER TABLE goods2
ADD COLUMN price integer DEFAULT 0;

SELECT * FROM goods2;

UPDATE goods2
SET price = NULL;

ALTER TABLE goods2
MODIFY COLUMN price NUMERIC;


ALTER TABLE goods2
MODIFY COLUMN price INTEGER;

ALTER TABLE goods2
RENAME COLUMN price TO item_price;

ALTER TABLE goods2
DROP COLUMN item_price;

use learn;
CREATE TABLE students(
 name varchar(128) NOT NULL,
 lastname varchar(128) NOT NULL,
 avg_mark numeric(2,1) CHECK (avg_mark BETWEEN 0 AND 5),
 gender varchar(128) CHECK (gender IN("M","F"))
 );
 
 INSERT INTO 
 students(name, lastname, avg_mark, gender)
 VALUES
 ("Олег", "Петров", 4.3, "M"),
 ("Семен", "Степанов", 3.1, "M"),
 ("Ольга", "Семенова", 4.7, "F"),
 ("Игорь", "Романов", 3.1, "M"),
 ( "Ирина", "Иванова", 2.2, "F");
 
 SELECT * FROM students;
 
ALTER TABLE students
ADD COLUMN id integer primary key auto_increment;

ALTER TABLE students
MODIFY COLUMN gender varchar(1);

ALTER TABLE students
RENAME COLUMN name TO firstname;
 
SELECT * FROM students
WHERE avg_mark > 4;

SELECT * FROM students
WHERE avg_mark NOT BETWEEN 3 AND 4;

SELECT * FROM students
WHERE firstname LIKE 'И%';

SELECT * FROM students
WHERE avg_mark IN(2.2, 3.1, 4.7);

CREATE VIEW v_male_students AS
 SELECT
  *
 FROM students
 WHERE gender LIKE 'M';
 
 SELECT * FROM v_male_students;
 
 CREATE VIEW v_female_students AS
 SELECT
  *
 FROM students
 WHERE gender LIKE 'F';
 
SELECT * FROM v_female_students;

ALTER TABLE students
MODIFY avg_mark decimal(3,1);

ALTER TABLE students
DROP CONSTRAINT students_chk_1;

UPDATE students
SET avg_mark=avg_mark*10;

SELECT * FROM students;

UPDATE students
SET lastname='Сидоров'
WHERE lastname LIKE "Петров";

UPDATE students
SET avg_mark=avg_mark+10
WHERE avg_mark <=31;






 
 
 
 




