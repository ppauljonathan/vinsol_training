CREATE DATABASE IF NOT EXISTS newtest;
USE newtest;
CREATE TABLE IF NOT EXISTS Inventory
(
	ProductID SMALLINT(4) UNSIGNED ZEROFILL,
    Quantity INT UNSIGNED
);

DROP TABLE Inventory;
SHOW TABLES;
DROP DATABASE newtest;