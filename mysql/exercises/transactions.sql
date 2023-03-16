use paul;

CREATE TABLE Users(
  id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(20) NOT NULL,
  email VARCHAR(30) NOT NULL,
  account_no INTEGER NOT NULL UNIQUE
);

CREATE TABLE Accounts(
  id INTEGER PRIMARY KEY NOT NULL,
  account_no INTEGER NOT NULL UNIQUE,
  balance INTEGER NOT NULL
);

INSERT INTO Users
VALUES
  (1, 'UserA', 'usera@mail.com', 20),
  (2, 'UserB', 'userb@mail.com', 43);
  
INSERT INTO Accounts
VALUES
  (1, 18, 400),
  (2, 43, 1000),
  (3, 20, 200);
  
-- Query 1 userA is depositing 1000 Rs. his account
START TRANSACTION;
  SET @user_balance = (SELECT balance
    FROM Accounts AS a
      LEFT JOIN Users AS u
        ON a.account_no = u.account_no
    WHERE u.name = 'userA');
    
  SET @user_deposit = 1000;
  SET @user_balance = @user_balance + @user_deposit;
  
  UPDATE Accounts AS a
    LEFT JOIN Users AS u
      ON a.account_no = u.account_no
  SET a.balance = @user_balance
  WHERE u.name = 'userA';
COMMIT;
  
SELECT u.name, a.balance FROM Users AS u
  LEFT JOIN Accounts AS a
    ON a.account_no = u.account_no
  WHERE u.name = 'userA';

-- Query 2 userA is withdrawing 500 Rs.
START TRANSACTION;
  SET @user_balance = (SELECT balance
    FROM Accounts AS a
      LEFT JOIN Users AS u
        ON a.account_no = u.account_no
    WHERE u.name = 'userA');
    
  SET @user_withdraw = 500;
  SET @user_balance = @user_balance - @user_withdraw;
  
  UPDATE Accounts AS a
    LEFT JOIN Users AS u
      ON a.account_no = u.account_no
  SET a.balance = @user_balance
  WHERE u.name = 'userA';
COMMIT;
  
SELECT u.name, a.balance FROM Users AS u
  LEFT JOIN Accounts AS a
    ON a.account_no = u.account_no
  WHERE u.name = 'userA';

-- Query 3 userA is transferring 200 Rs to userB's account
START TRANSACTION;
  SET @user_a_balance = (SELECT balance
    FROM Accounts AS a
      LEFT JOIN Users AS u
        ON a.account_no = u.account_no
    WHERE u.name = 'userA');
    
  SET @user_transfer = 200;
  SET @user_a_balance = @user_a_balance - @user_withdraw;
  
  UPDATE Accounts AS a
    LEFT JOIN Users AS u
      ON a.account_no = u.account_no
  SET a.balance = @user_a_balance
  WHERE u.name = 'userA';
  
SAVEPOINT sp1;

  SET @user_b_balance = (SELECT balance
    FROM Accounts AS a
      LEFT JOIN Users AS u
        ON a.account_no = u.account_no
    WHERE u.name = 'userB');
    
  SET @user_b_balance = @user_b_balance - @user_withdraw;
  
  UPDATE Accounts AS a
    LEFT JOIN Users AS u
      ON a.account_no = u.account_no
  SET a.balance = @user_b_balance
  WHERE u.name = 'userB';
COMMIT;
  
SELECT u.name, a.balance FROM Users AS u
  LEFT JOIN Accounts AS a
    ON a.account_no = u.account_no
  WHERE u.name IN ('userA', 'userB');