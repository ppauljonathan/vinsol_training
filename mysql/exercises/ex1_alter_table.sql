-- Using MySQL 5.7.30
-- Your Queries Here.

-- Add statements like 'SHOW KEYS FROM TABLE_NAME;' and 'DESCRIBE TABLE_NAME;' to help reviewer to visualize DB.
-- Do not include 'create database' statements. One db will be created for you. Just use tables you created in the schema tab.

DROP TABLE IF EXISTS testing_table;

CREATE TABLE IF NOT EXISTS testing_table
(
  name VARCHAR(30),
  contact_name VARCHAR(30) NOT NULL,
  roll_no VARCHAR(30) PRIMARY KEY
);

DESCRIBE testing_table; -- output 1

ALTER TABLE testing_table
  DROP COLUMN name,
  ADD first_name VARCHAR(30),
  ADD last_name VARCHAR(30),
  MODIFY COLUMN roll_no INTEGER,
  -- RENAME COLUMN contact_name TO username; -- in version 10.11.2
  CHANGE COLUMN contact_name username VARCHAR(30) NOT NULL;


DESCRIBE testing_table; -- output 2

DROP TABLE testing_table;
