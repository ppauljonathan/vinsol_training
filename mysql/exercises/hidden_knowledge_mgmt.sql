USE paul;

-- DDL
DROP TABLE IF EXISTS ProjectTechnology, EmployeeProject, Technologies, Employees, Projects;

CREATE TABLE Projects(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20)
);

CREATE TABLE Employees(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20)
);

CREATE TABLE Technologies(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20)
);

CREATE TABLE EmployeeProject(
  emp_id INTEGER NOT NULL,
  project_id INTEGER NOT NULL,
  currently_working_on BOOLEAN NOT NULL,
  PRIMARY KEY(emp_id, project_id),
  FOREIGN KEY (emp_id) REFERENCES Employees(id),
  FOREIGN KEY (project_id) REFERENCES Projects(id)
);

CREATE TABLE ProjectTechnology(
  project_id INTEGER NOT NULL,
  tech_id INTEGER NOT NULL,
  PRIMARY KEY(project_id, tech_id),
  FOREIGN KEY (project_id) REFERENCES Projects(id),
  FOREIGN KEY (tech_id) REFERENCES Technologies(id)
);

-- populate tables
INSERT INTO Projects(name)
VALUES
  ('ProjectA'),
  ('ProjectB'),
  ('ProjectC'),
  ('ProjectD'),
  ('ProjectE'),
  ('ProjectF'),
  ('ProjectG'),
  ('ProjectH'),
  ('ProjectI'),
  ('ProjectJ'),
  ('ProjectK'),
  ('ProjectL');

INSERT INTO Employees(name)
VALUES ('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G'), ('H');

INSERT INTO Technologies(name)
VALUES
  ('HTML'),
  ('JavaScript'),
  ('Ruby'),
  ('Rails'),
  ('IOS'),
  ('Android'),
  ('Python'),
  ('R'),
  ('Flutter');

SELECT * FROM `Employees`;
INSERT INTO EmployeeProject
VALUES
  (1, 1, 0),
  (1, 2, 0),
  (1, 3, 0),
  (1, 6, 1),
  (1, 10, 1),
  (1, 12, 0),
  (2, 1, 0),
  (2, 3, 0),
  (2, 7, 0),
  (2, 9, 0),
  (3, 1, 0),
  (3, 2, 0),
  (3, 8, 0),
  (3, 9, 0),
  (3, 11, 0),
  (4, 1, 0),
  (4, 2, 0),
  (4, 4, 0),
  (4, 5, 1),
  (4, 6, 1),
  (4, 11, 0),
  (5, 2, 0),
  (5, 8, 0),
  (5, 11, 0),
  (5, 12, 0),
  (6, 3, 0),
  (6, 5, 1),
  (7, 9, 0),
  (8, 1, 0),
  (8, 3, 0),
  (8, 5, 1),
  (8, 10, 1),
  (8, 11, 0),
  (8, 12, 0);


INSERT INTO ProjectTechnology
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (1, 4),
  (2, 5),
  (3, 6),
  (4, 5),
  (4, 6),
  (5, 3),
  (5, 4),
  (6, 6),
  (6, 1),
  (6, 2),
  (7, 6),
  (7, 5),
  (8, 1),
  (8, 2),
  (8, 3),
  (8, 4),
  (8, 6),
  (9, 5),
  (10, 7),
  (10, 8),
  (11, 1),
  (11, 2),
  (11, 3),
  (11, 4),
  (12, 5),
  (12, 6),
  (12, 9);

SELECT * FROM Technologies;
SELECT * FROM Projects;
SELECT * FROM Employees;
SELECT * FROM EmployeeProject;
SELECT * FROM ProjectTechnology;

-- q1 Find names of all employees currently not working in any projects. (Use joins)
SELECT E.id, E.name
FROM Employees AS E
  JOIN EmployeeProject AS EP
    ON E.id = EP.emp_id
  GROUP BY EP.emp_id
  HAVING  COUNT(DISTINCT EP.currently_working_on) = 1;

-- q2  Find all employees who have exposure to HTML, Javascript and IOS.
SELECT E.id, E.name FROM EmployeeProject AS EP
JOIN ProjectTechnology AS PT
  ON EP.project_id = PT.project_id
JOIN Employees AS E
  ON E.id = EP.emp_id
JOIN Technologies AS T
  ON T.id = PT.tech_id
WHERE T.name IN ('HTML', 'Javascript', 'IOS')
GROUP BY E.id
HAVING COUNT(DISTINCT T.id) = 3;

-- q3 Find the technologies in which a particular employee(Say H) has expertise(3 or more projects
SELECT T.name FROM EmployeeProject AS EP
JOIN ProjectTechnology AS PT
  ON EP.project_id = PT.project_id
JOIN Employees AS E
  ON E.id = EP.emp_id
JOIN Technologies AS T
  ON T.id = PT.tech_id
WHERE E.name = 'H'
GROUP BY T.name
HAVING COUNT(DISTINCT PT.project_id) >= 3;

-- q4 Find the employee who has done most no of projects in android (do this using variable also)
-- without variable
SELECT E.id, E.name FROM Employees AS E
  JOIN EmployeeProject AS EP
    ON E.id = EP.emp_id
  JOIN ProjectTechnology AS PT
    ON EP.project_id = PT.project_id
  JOIN Technologies AS T
    ON PT.tech_id = T.id
  WHERE T.name = 'Android'
  GROUP BY E.id
  ORDER BY COUNT(DISTINCT PT.project_id) DESC
  LIMIT 1;

-- with variable
SET @tech_id := (
  SELECT id FROM Technologies
  WHERE name = 'Android'
);

SELECT E.id, E.name FROM Employees AS E
  JOIN EmployeeProject AS EP
    ON E.id = EP.emp_id
  JOIN ProjectTechnology AS PT
    ON EP.project_id = PT.project_id
  WHERE PT.tech_id = @tech_id
  GROUP BY E.id
  ORDER BY COUNT(DISTINCT PT.project_id) DESC
  LIMIT 1;

-- DEBUG
SELECT P.id, P.name, GROUP_CONCAT(DISTINCT T.name), GROUP_CONCAT(DISTINCT E.name)
FROM Projects AS P
  JOIN EmployeeProject as EP
    ON P.id = EP.project_id
  JOIN ProjectTechnology as PT
    ON P.id = PT.project_id
  JOIN Employees as E
    ON E.id = EP.emp_id
  JOIN Technologies as T
    ON T.id = PT.tech_id
  GROUP BY P.id;