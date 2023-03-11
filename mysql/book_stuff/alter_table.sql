USE shirt;
ALTER TABLE Shirts
ADD company VARCHAR(30);

SELECT * FROM Shirts;

ALTER TABLE shirt.Shirts
DROP company;

SELECT * FROM Shirts;