/*======================
  STUDENT TABLE
  ======================*/
CREATE TABLE STUDENT(
STUDENT_ID  INT PRIMARY KEY,
NAME VARCHAR(50),
DEPARTMENT VARCHAR(50),
SEMESTER INT);


/*======================
  SUBJECT TABLE
  ======================*/
CREATE TABLE SUB(
SUBJECT_ID int primary key,
SUBJECT_NAME varchar(50));


/*======================
  MARKS TABLE
  ======================*/
CREATE TABLE MARKS(
MARK_ID INT PRIMARY KEY,
STUDENT_ID INT,
SUBJECT_ID INT,
MARKS INT,
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID),
FOREIGN KEY (SUBJECT_ID) REFERENCES SUB(SUBJECT_ID));


/*======================
  INSERT INTO STUDENT
  ======================*/
INSERT INTO Student VALUES
(1,'Aarav','IT',3),
(2,'Diya','IT',3),
(3,'Vivaan','CS',2),
(4,'Ananya','IT',4),
(5,'Aditya','CS',2),
(6,'Ishita','IT',3),
(7,'Arjun','CS',4),
(8,'Meera','IT',2),
(9,'Krishna','CS',3),
(10,'Saanvi','IT',4),
(11,'Rohan','CS',2),
(12,'Priya','IT',3),
(13,'Rahul','CS',4),
(14,'Sneha','IT',2),
(15,'Karan','CS',3),
(16,'Neha','IT',4),
(17,'Amit','CS',2),
(18,'Pooja','IT',3),
(19,'Varun','CS',4),
(20,'Riya','IT',2);


/*======================
  INSERT INT0 SUBJECT
  ======================*/
INSERT INTO SUB VALUES
(101,'DBMS'),
(102,'Python'),
(103,'Java'),
(104,'Web Development'),
(105,'Data Structures');


/*======================
  INSERT INTO MARKS
  ======================*/
INSERT INTO Marks VALUES
(1,1,101,85),(2,1,102,78),(3,1,103,90),(4,1,104,82),(5,1,105,88),

(6,2,101,92),(7,2,102,87),(8,2,103,95),(9,2,104,89),(10,2,105,91),

(11,3,101,35),(12,3,102,45),(13,3,103,50),(14,3,104,38),(15,3,105,40),

(16,4,101,76),(17,4,102,81),(18,4,103,79),(19,4,104,84),(20,4,105,77),

(21,5,101,60),(22,5,102,55),(23,5,103,58),(24,5,104,62),(25,5,105,57),

(26,6,101,88),(27,6,102,91),(28,6,103,85),(29,6,104,90),(30,6,105,87),

(31,7,101,42),(32,7,102,39),(33,7,103,48),(34,7,104,50),(35,7,105,45),

(36,8,101,73),(37,8,102,69),(38,8,103,75),(39,8,104,71),(40,8,105,70),

(41,9,101,95),(42,9,102,93),(43,9,103,97),(44,9,104,96),(45,9,105,94),

(46,10,101,82),(47,10,102,78),(48,10,103,80),(49,10,104,76),(50,10,105,79),

(51,11,101,30),(52,11,102,35),(53,11,103,32),(54,11,104,40),(55,11,105,38),

(56,12,101,85),(57,12,102,88),(58,12,103,90),(59,12,104,87),(60,12,105,86),

(61,13,101,65),(62,13,102,70),(63,13,103,68),(64,13,104,72),(65,13,105,66),

(66,14,101,91),(67,14,102,89),(68,14,103,93),(69,14,104,90),(70,14,105,92),

(71,15,101,55),(72,15,102,58),(73,15,103,52),(74,15,104,60),(75,15,105,57),

(76,16,101,98),(77,16,102,96),(78,16,103,99),(79,16,104,97),(80,16,105,95),

(81,17,101,48),(82,17,102,50),(83,17,103,46),(84,17,104,52),(85,17,105,49),

(86,18,101,75),(87,18,102,78),(88,18,103,80),(89,18,104,77),(90,18,105,79),

(91,19,101,84),(92,19,102,86),(93,19,103,83),(94,19,104,85),(95,19,105,87),

(96,20,101,69),(97,20,102,72),(98,20,103,70),(99,20,104,68),(100,20,105,71);


-- Find the student with the highest total marks across all subjects --

SELECT S.NAME, SUM(M.MARKS) AS TOTAL
FROM STUDENT S
JOIN MARKS M
ON S.STUDENT_ID = M.STUDENT_ID
GROUP BY S.STUDENT_ID, S.NAME
ORDER BY TOTAL DESC
LIMIT 1;

-- Retrieve students who scored less than 40 marks in any subject --

SELECT S.NAME, SUB.SUBJECT_ID, M.MARKS
FROM STUDENT S
JOIN MARKS M
ON S.STUDENT_ID = M.STUDENT_ID
JOIN SUB SUB
ON M.SUBJECT_ID = SUB.SUBJECT_ID
WHERE MARKS < 40;

-- Calculate the average marks obtained by each student --

SELECT S.NAME, AVG(M.MARKS) AS AVERAGE_MARKS
FROM STUDENT S
JOIN MARKS M
ON S.STUDENT_ID = M.STUDENT_ID
GROUP BY S.STUDENT_ID, S.NAME;

-- Create a view to simplify access to student performance reports --

CREATE VIEW STUDENT_REPORT AS
SELECT S.NAME, SUB.SUBJECT_ID, M.MARKS
FROM STUDENT S
JOIN MARKS M
ON S.STUDENT_ID = M.STUDENT_ID
JOIN SUB SUB
ON M.SUBJECT_ID = SUB.SUBJECT_ID;

-- create a trigger to prevent insertion of marks greater than 100 --

DELIMITER //
CREATE TRIGGER CHECK_MARKS
BEFORE INSERT ON MARKS
FOR EACH ROW
BEGIN
	IF NEW.MARKS > 100 THEN 
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'MARKS CANNOT EXCEED 100';
	END IF;
END //
DELIMITER ;