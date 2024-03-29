USE paul;

DROP TABLE Commissions, Employees, Departments;

-- DDL commands
CREATE TABLE Departments(
  ID INTEGER PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(20) NOT NULL
);

CREATE TABLE Employees(
  ID INTEGER PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(20) NOT NULL,
  SALARY INTEGER NOT NULL,
  DEPARTMENT_ID INTEGER NOT NULL,
  FOREIGN KEY (DEPARTMENT_ID) REFERENCES Departments(ID)
);

CREATE TABLE Commissions(
  ID INTEGER PRIMARY KEY AUTO_INCREMENT,
  EMPLOYEE_ID INTEGER NOT NULL,
  COMMISSION_AMOUNT INTEGER NOT NULL,
  FOREIGN KEY (EMPLOYEE_ID) REFERENCES Employees(ID)
);

-- indexes
CREATE INDEX commission_val
ON Commissions(COMMISSION_AMOUNT);

CREATE INDEX emp_salary
ON Employees(SALARY);

-- populate tables
INSERT INTO Departments(NAME)
VALUES
  ('Banking'),
  ('Insurance'),
  ('Services');

INSERT INTO Employees(NAME, SALARY, DEPARTMENT_ID)
VALUES
  ('Chris Gayle', 1000000, 1),
  ('Michael Clark', 800000, 2),
  ('Rahul Dravid', 700000, 1),
  ('Ricky Pointing', 600000, 2),
  ('Albie Morkel', 650000, 2),
  ('Wasim Akram', 750000, 3);

INSERT INTO Commissions(EMPLOYEE_ID, COMMISSION_AMOUNT)
VALUES
  (1, 5000),
  (2, 3000),
  (3, 4000),
  (1, 4000),
  (2, 3000),
  (4, 2000),
  (5, 1000),
  (6, 5000);

-- i. Find the employee who gets the highest total commission.
SELECT E.ID, E.NAME, SUM(C.COMMISSION_AMOUNT) AS COMMISSION
FROM Commissions AS C
  INNER JOIN Employees AS E
    ON C.EMPLOYEE_ID = E.ID
  GROUP BY E.ID
  ORDER BY COMMISSION DESC
  LIMIT 1;

-- ii. Find employee with 4th Highest salary from employee table.
SELECT ID, NAME FROM Employees
ORDER BY SALARY DESC
LIMIT 3, 1;

-- iii. Find department that is giving highest commission.
SELECT D.ID, D.NAME, SUM(C.COMMISSION_AMOUNT) AS TOTAL_COMMISSION_AMT
FROM Departments AS D
  INNER JOIN Employees AS E
    ON D.ID = E.DEPARTMENT_ID
  INNER JOIN Commissions AS C
    ON E.ID = C.EMPLOYEE_ID
  GROUP BY D.ID
  ORDER BY TOTAL_COMMISSION_AMT DESC
  LIMIT 1;
-- iv. Find employees getting commission more than 3000
-- Display Output in following pattern:  
-- Chris Gayle, Rahul Dravid  4000
SELECT GROUP_CONCAT(
  DISTINCT E.NAME
  SEPARATOR ', '
) AS PLAYERS, COMMISSION_AMOUNT
FROM Commissions AS C
  INNER JOIN Employees AS E
    ON C.EMPLOYEE_ID = E.ID
  GROUP BY C.COMMISSION_AMOUNT
  HAVING C.COMMISSION_AMOUNT > 3000;