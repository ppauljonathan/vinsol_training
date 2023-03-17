use paul;

-- DDL Section
DROP TABLE IF EXISTS SANDWICHES, LOCATIONS, TASTES;

CREATE TABLE IF NOT EXISTS TASTES(
	Name VARCHAR(10) NOT NULL,
    Filling VARCHAR(10) NOT NULL,
    PRIMARY KEY(Name, Filling)
);

CREATE TABLE IF NOT EXISTS LOCATIONS(
	LName VARCHAR(30) PRIMARY KEY,
    Phone CHAR(8) NOT NULL,
    Address VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS SANDWICHES(
	Location VARCHAR(30) NOT NULL,
    Bread VARCHAR(10) NOT NULL,
    Filling VARCHAR(10) NOT NULL,
    Price DOUBLE(4, 2),
    FOREIGN KEY (Location) REFERENCES LOCATIONS(LName),
    PRIMARY KEY(Location, Bread, Filling)
);

-- Populating the tables
INSERT INTO TASTES(Name, Filling)
VALUES
	('Brown', 'Turkey'),
    ('Brown', 'Beef'),
    ('Brown', 'Ham'),
    ('Jones', 'Cheese'),
    ('Green', 'Beef'),
    ('Green', 'Turkey'),
    ('Green', 'Cheese');
    
INSERT INTO LOCATIONS(LName, Phone, Address)
VALUES
	('Lincoln', '683 4523', 'Lincoln Place'),
    ("O'Neill's", '674 2134', 'Pearse St'),
    ('Old Nag', '767 8132', 'Pearse St'),
    ('Buttery', '702 3421', 'College St');
    
INSERT INTO SANDWICHES(Location, Bread, Filling, Price)
VALUES
	('Lincoln', 'Rye',  'Ham', 1.25),
    ("O'Neill's", 'White',  'Cheese', 1.20),
    ("O'Neill's", 'Whole',  'Ham', 1.25),
    ('Old Nag', 'Rye',  'Beef', 1.35),
    ('Buttery', 'White',  'Cheese', 1.00),
    ("O'Neill's", 'White',  'Turkey', 1.35),
    ('Buttery', 'White',  'Ham', 1.10),
    ('Lincoln', 'Rye',  'Beef', 1.35),
    ('Lincoln', 'White',  'Ham', 1.30),
    ('Old Nag', 'Rye',  'Ham', 1.40);


-- Query 1 (Places where Jones can eat - using nested subquery)
SELECT * FROM LOCATIONS
WHERE Lname IN (
	SELECT Location FROM SANDWICHES
	WHERE Filling IN (
		SELECT Filling FROM TASTES
        WHERE Name = 'Jones'
	)
);
-- Query 2 (Places where Jones can eat - without using nested subquery)
SELECT Lname, Phone, Address FROM TASTES 
	JOIN SANDWICHES
		ON TASTES.Filling = SANDWICHES.Filling
	JOIN LOCATIONS
		ON SANDWICHES.Location = LOCATIONS.LName
	WHERE TASTES.Name = 'Jones';
        
-- Query 3 (For each location number of people who can eat there)
SELECT SANDWICHES.Location, COUNT(DISTINCT Name) AS Persons FROM TASTES
	JOIN SANDWICHES
		ON TASTES.Filling = SANDWICHES.Filling
	GROUP BY SANDWICHES.Location;
    
DROP TABLE IF EXISTS TASTES, LOCATIONS, SANDWICHES;