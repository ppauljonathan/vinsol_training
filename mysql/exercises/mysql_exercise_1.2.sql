use paul;

-- DDL Section
DROP TABLE IF EXISTS Holdings, Branch, Titles;

CREATE TABLE IF NOT EXISTS Branch(
	BCode CHAR(2) PRIMARY KEY,
    Librarian VARCHAR(20) NOT NULL,
    Address VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Titles(
	Title VARCHAR(50) PRIMARY KEY,
    Author VARCHAR(20) NOT NULL,
    Publisher VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Holdings(
	Branch CHAR(2) NOT NULL,
    Title VARCHAR(50) NOT NULL,
    no_of_copies INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (Branch) REFERENCES Branch(BCode),
    FOREIGN KEY (Title) REFERENCES Titles(Title),
    PRIMARY KEY (Branch, Title)
);

-- Populating the tables
INSERT INTO Branch(BCode, Librarian, Address)
VALUES
	('B1', 'John Smith', '2 Angelsea Rd'),
  ('B2', 'Mary Jones', '34 Pearse St'),
  ('B3', 'Francis Owens', 'Grange X');
    
INSERT INTO Titles(Title, Author, Publisher)
VALUES
	('Susannah', 'Ann Brown', 'Macmillian'),
  ('How to Fish', 'Amy Fly', 'Stop Press'),
  ('A History of Dublin', 'David Little', 'Wiley'),
  ('Computers', 'Blaise Pascal', 'Applewoods'),
  ('The Wife', 'Ann Brown', 'Macmillian');
    
INSERT INTO Holdings(Branch, Title, no_of_copies)
VALUES
	('B1', 'Susannah', 3),
  ('B1', 'How to Fish', 2),
  ('B1', 'A History of Dublin', 1),
  ('B2', 'How to Fish', 4),
  ('B2', 'Computers', 2),
  ('B2', 'The Wife', 3),
  ('B3', 'A History of Dublin', 1),
  ('B3', 'Computers', 4),
  ('B3', 'Susannah', 3),
  ('B3', 'The Wife', 1);

-- Query 1 (The names of all library books published by Macmillian)
SELECT Title FROM Titles WHERE Publisher = 'Macmillian';

-- Query 2 (Branches that hold any books by Ann Brown - with nested subquery)
SELECT * FROM Branch
WHERE BCode IN (
	SELECT Branch FROM Holdings
    WHERE 
	Title IN (
		SELECT Title FROM Titles
        WHERE Author = 'Ann Brown'
	) AND
    no_of_copies > 0
);

-- Query 3 (Branches that hold any books by Ann Brown - without nested subquery)
SELECT DISTINCT BCode, Librarian, Address FROM Branch AS b
	JOIN Holdings AS h
		ON b.BCode = h.Branch
	JOIN Titles AS t
		ON t.Title = h.Title
	WHERE 
		t.Author = 'Ann Brown' AND
    h.no_of_books > 0;
        

-- Query 4 (The total number of books held at each branch)
SELECT Branch, SUM(no_of_copies) AS Total_Books
FROM Holdings
GROUP BY Branch;

DROP TABLE IF EXISTS Holdings, Branch, Titles;