CREATE TABLE worker(
    worker_id INT AUTO_INCREMENT,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    salary FLOAT,
    joining_date DATETIME,
    department VARCHAR(30),
    PRIMARY KEY(worker_id)
);

INSERT INTO worker(first_name,last_name,salary,joining_date,department) VALUES('Monika','Arora',100000,'2014-02-20 09:00:00','HR'),
('Niharika','Verma',80000,'2014-06-11 09:00:00','Admin'),
('Vishal','Singhal',300000,'2014-02-20 09:00:00','HR'),
('Amitabh','Singh',500000,'2014-02-20 09:00:00','Admin'),
('Vivek','Bhati',500000,'2014-06-11 09:00:00','Admin'),
('Vipul','Diwan',200000,'2014-06-11 09:00:00','Account'),
('Satish','Kumar',75000,'2014-01-20 09:00:00','Account'),
('Geetika','Chauhan',90000,'2014-04-11 09:00:00','Admin');

CREATE TABLE Bonus(
    worker_ref_id INT,
    bonus_date DATETIME,
    bonus_amount FLOAT,
    -- PRIMARY KEY(worker_ref_id)
);

ALTER TABLE Bonus DROP PRIMARY KEY;

INSERT INTO Bonus VALUES(1,'2016-02-20 00:00:00',5000),
(2,'2016-06-11 00:00:00',3000),
(3,'2016-02-20 0:00:00',4000),
(1,'2016-02-20 00:00:00',4500),
(2,'2016-06-11 00:00:00',3500)
;

CREATE TABLE title(
    worker_ref_id INT,
    worker_title VARCHAR(30),
    affected_from DATETIME
);

INSERT INTO title VALUES(1,'manager','2016-02-20 00:00:00'),
(2,'executive','2016-06-11 00:00:00'),
(8,'executive','2016-06-11 00:00:00'),
(5,'manager','2016-06-11 00:00:00'),
(4,'asst.manager','2016-06-11 00:00:00'),
(7,'executive','2016-06-11 00:00:00'),
(6,'lead','2016-06-11 00:00:00'),
(3,'lead','2016-06-11 00:00:00')
;
--1. selcting first name from table worker alias worker_name.
SELECT first_name AS worker_name FROM  worker; 

--2. to fetch “FIRST_NAME” from the Worker table in uppercase.
SELECT UCASE(first_name) FROM worker;

--3. fetch unique values of DEPARTMENT from the Worker table.
ALTER TABLE worker ADD UNIQUE(department);
-- ERROR-> "Duplicate entry 'Admin' for key 'worker.department'": QUESTION DEMANDS TO PRINT UNIQUE VALUES AND NOT ALTER THE COLUMN TO UNIQUE.UNDERSTAND THE QUESTION PROPERLY 
-- now we use DISTINCT KEYWORD to show the unique values in department.
SELECT DISTINCT department FROM worker; 

--4. query to print the first three characters of first_name from the Worker table.
SELECT SUBSTRING(first_name,1,3) FROM worker;

--5. to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from the Worker table.
SELECT * FROM worker WHERE first_name Amitabh ^[a]; 
--  You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'Amitabh [a]'.THE QUES WANTS THE POSTION OF 'a' NOT THE COUNT.
SELECT POSITION('a','A' IN 'Amitabh'); ->ERROR

-- 6.to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * FROM worker ORDER BY first_name ASC;

--7. to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM worker ORDER BY first_name ASC,
department DESC;

--8. to print details for Workers with the first names “Vipul” and “Satish” from the Worker table.
-- SELECT FROM worker WHERE first_name='vipul','satish';->ERROR
-- SELECT first_name='vipul','satish' FROM worker; ->WRONG OUTPUT
SELECT * FROM worker WHERE first_name='Vipul' OR first_name='Satish';

-- 9.to print details of workers excluding first names, “Vipul” and
-- “Satish” from the Worker table.
SELECT * FROM worker WHERE first_name!='Vipul' AND first_name!='Satish';
-- OR me agar koi ek true ho rha hai to dusre pe nahi jaa rha,isliye make it AND

-- 10.to print details of Workers with DEPARTMENT name as
-- “Admin”.
SELECT * FROM worker WHERE department='admin';

-- 11.to print details of the Workers whose FIRST_NAME contains
-- ‘a’.
-- SELECT * FROM worker WHERE first_name='a';
-- this will shoe empty set beacuse we dont have any worker with name 'a'
SELECT * FROM worker WHERE first_name LIKE '%a%';

-- 12.print names of the Workers whose FIRST_NAME ends
-- with ‘a’.
SELECT * FROM worker WHERE first_name LIKE '%a';

-- 13.to print details of the Workers whose FIRST_NAME ends
-- with ‘h’ and contains six alphabets.
SELECT * FROM worker WHERE first_name LIKE '_____%a';

-- 14. query to print details of the Workers whose SALARY lies between
-- 100000 and 500000.
SELECT * FROM worker WHERE salary>=100000 AND salary<=500000;

-- 15.query to print details of the Workers who joined in Feb’2014.
SELECT * FROM worker WHERE joining_date >='2014-02-01 00:00:00'AND joining_date <'2014-03-01 00:00:00';

--16.to fetch the count of employees working in the department 'Admin’.
SELECT COUNT(department) FROM worker WHERE department='Admin';

-- 17.to fetch worker names with salaries >= 50000 and <=
-- 100000.
SELECT first_name FROM worker WHERE salary >=50000 AND salary <=100000; 
SELECT first_name,last_name FROM worker WHERE salary >=50000 AND salary <=100000; 

-- 18.the no. of workers for each department in
-- descending order.
--SELECT * FROM worker WHERE department='Admin' ORDER BY DESC;



-- above shows natural join and printing the list of worker_title
SELECT worker_title FROM worker,title  WHERE worker.worker_id = title.worker_ref_id;
SELECT COUNT()

-- 19.query to print details of the Workers who are also Managers.
-- STEP 1: PERFORM NATURAL JOIN
SELECT worker_title='manager' FROM worker,title WHERE worker.worker_id = title.worker_ref_id;
--this just shows the number but not the details
--JOINING ALL 3 TABLES
SELECT worker_id, first_name,department,worker_title FROM worker,Bonus,title WHERE worker.worker_id = title.worker_ref_id = Bonus.worker_ref_id;
--OR
--SELECT TABLE worker = (
SELECT worker_title 'manager' from title;


SELECT worker_id, first_name,department,worker_title FROM worker INNER JOIN title ON worker.worker_id = title.worker_ref_id WHERE title.worker_title = 'manager';

--20.to fetch duplicate records having matching data in some fields of a table. Accepting the salary as data and finding duplicate value there


--21.Write an SQL query to show only odd and even rows from a table.
SELECT * FROM worker WHERE MOD(worker_id,2)=1;
SELECT * FROM worker WHERE MOD(worker_id,2)=0;

--23.Write an SQL query to clone a new table from another table.
CREATE TABLE worker1 AS SELECT * FROM worker;

--24. Write an SQL query to fetch intersecting records of previous two tables.
SELECT * FROM worker w INNER JOIN title t ON w.worker_id=t.worker_ref_id;

--25. Write an SQL query to show records from one table that another table does not have.
--a
SELECT * FROM worker w LEFT JOIN title t ON w.worker_id=t.worker_ref_id WHERE t.worker_ref_id IS NULL;

--27. Write an SQL query to fetch the list of employees with the same salary.
SELECT * FROM worker GROUP BY salary;
--ERROR 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'ASSIGNMENT.worker.worker_id' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
SELECT first_name FROM worker WHERE salary IN ( SELECT salary FROM worker GROUP BY salary HAVING COUNT(*) > 1) ;

SELECT * FROM worker w SELF JOIN worker ON w.salary; 


--28. Write an SQL query to show the second-highest salary from a table.
SELECT MAX(salary) FROM worker;--MAX salary

--30. Write an SQL query to fetch the first 50% of records from a table.
SELECT  FROM worker 

--31. Write an SQL query to fetch the departments that have less than five people in them.
SELECT department,COUNT(department) AS count FROM worker GROUP BY department HAVING count<5 ;
--NOTE: When we use GRoUP BY after WHERE clause then it changes to HAVING. 
--NOTE 2: Using of IN keyword -> 
--For eg.,If we want to print all departments except Admin then: 
--IN -> The IN operator allows you to specify multiple values in a WHERE clause.The IN operator is a shorthand for multiple OR conditions.(W3School)

--SELECT department FROM worker WHERE department NOT IN (Admin); OR, SELECT department FROM worker WHERE department IN (HR,IT,etc.); 

--32. Write an SQL query to show all departments along with the number of people in there.
SELECT department,COUNT(department) FROM worker GROUP BY department;

--33. Write an SQL query to show the last record from a table.
SELECT * FROM worker ORDER BY worker_id DESC;
SELECT * FROM worker ORDER BY worker_id DESC LIMIT 1;

--34. Write an SQL query to fetch the first row of a table.
SELECT * FROM worker LIMIT 1;

--35. Write an SQL query to fetch the last five records from a table.
SELECT * FROM worker ORDER BY worker_id DESC LIMIT 5;

--36. Write an SQL query to print the name of employees having the highest salary in each department.
SELECT department,first_name,MAX(department) AS max FROM worker GROUP BY salary;--ERROR 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'ASSIGNMENT.worker.department' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
SELECT MAX(salary),department FROM worker GROUP BY department;
--+-------------+------------+
| MAX(salary) | department |
+-------------+------------+
|      500000 | HR         |
|      900000 | Admin      |
|      200000 | Account    |
+-------------+------------+

--37. Write an SQL query to fetch three max salaries from a table.
SELECT salary FROM worker ORDER BY salary DESC LIMIT 3;
+--------+
| salary |
+--------+
| 900000 |
| 500000 |--When in desc order, same salary people will be 
| 500000 |--displayed according to LIMIT
+--------+

--38. Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT department,SUM(salary) FROM worker GROUP BY department; 

--39./36. Write an SQL query to fetch the names of workers who earn the highest salary.
SELECT MAX(salary) FROM worker GROUP BY department;
-- SELECT empName,empDept,EmpSalary
-- FROM Employee
-- WHERE empSalary IN
--   (SELECT max(empSalary) AS salary
--    From Employee
--    GROUP BY EmpDept)
SELECT first_name,salary,department FROM worker WHERE salary IN (SELECT MAX(salary)AS sal FROM worker GROUP  BY department);

+------------+--------+------------+
| first_name | salary | department |
+------------+--------+------------+
| Amitabh    | 500000 | Admin      |
| Vivek      | 500000 | Admin      |
| Vipul      | 200000 | Account    |
| Shikha     | 500000 | HR         |
| Shipra     | 900000 | Admin      |
+------------+--------+------------+










































