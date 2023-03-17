drop database paul;
CREATE DATABASE paul;
use paul;

DROP TABLE IF EXISTS Comments, Articles, Categories, Users;

-- DDL COMMANDS

CREATE TABLE Users(
  id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  type ENUM('admin', 'normal') NOT NULL
);

CREATE TABLE Categories(
  id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL
);

CREATE TABLE Articles(
  id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  title VARCHAR(50) NOT NULL,
  content TEXT NOT NULL,
  author_id INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES Users(id),
  FOREIGN KEY (category_id) REFERENCES Categories(id)
);

CREATE TABLE Comments(
  id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  content TEXT NOT NULL,
  author_id INTEGER NOT NULL,
  article_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES Users(id),
  FOREIGN KEY (article_id) REFERENCES Articles(id)
);

INSERT INTO Users(name, type)
VALUES
  ('Paul', 'admin'),
  ('Rachit', 'admin'),
  ('Anuj', 'normal'),
  ('Jon', 'normal'),
  ('Garfield', 'normal'),
  ('Sam', 'normal'),
  ('Ray', 'admin');

--  Q1 Inserting values in the DB

INSERT INTO Categories(name)
VALUES
  ('Horror'),
  ('Mystery'),
  ('Comedy'),
  ('Romance'),
  ('Tragedy'),
  ('Slice of Life'),
  ('Drama');

INSERT INTO Articles(title, content, author_id, category_id)
VALUES
  (
    'The Shining',
    'Two little girls fight a madman in their house',
    2,
    1
  ),
  (
    'The Princess and the Frog',
    'A princess meets a frog and desnt know what to do',
    1,
    2
  ),
  (
    'Into the Light',
    'A queen gets unfairly executed, reincarnation occurs',
    7,
    7
  ),
  (
    'till death do us part',
    'a soldier who goes blind but doesnt let that stop him',
    4,
    6
  ),
  (
    'a good meal',
    'a poor young girl goes to a house and finds a surprise',
    6,
    3
  ),
  (
    'the frequency',
    'did you know that the human body hAS a resonant frequency',
    6,
    1
  ),
  (
    'Mondays',
    'man i hate mondays - garfield',
    5,
    6
  ),
  (
    'Coffee',
    'man i hate coffee - jon',
    4,
    6
  );

  INSERT INTO Comments(content, author_id, article_id)
  VALUES
    ('I have goosebumps', 1, 1),
    ('Very scary', 3, 1),
    ('Thank you', 2, 1),
    ('pls write more', 6, 1),
    ('very interesting article', 2, 2),
    ('thanks guys', 1, 2),
    ('cool', 7, 2),
    ('could be better', 6, 2),
    ('meh', 4, 2),
    ('wow, just, wow', 1, 3),
    ('more pleASe', 1, 3),
    ('very nice, i liked the reincarnation part', 4, 3),
    ('this story gives me the chills, in a good way', 3, 3),
    ('thanks', 7, 3),
    ('10/10', 5, 3),
    ('very inspiring', 2, 4),
    ('noice', 7, 4),
    ('more like this', 3, 4),
    ('11/10', 5, 4),
    ('beautiful', 5, 5),
    ('thanks for your comments', 6, 5),
    ('meh', 2, 5),
    ('not so scary', 1, 6),
    ('5/10', 4, 6),
    ('2/10', 3, 6),
    ('4/10', 5, 6),
    ('sorry 7/10', 5, 6);

-- Altering Values in the table

UPDATE Users
  SET type = 'admin'
  WHERE name = 'Sam';

-- q2 select all articles whose author's name is Sam (Do this exercise using variable also)

-- without variable
SELECT title FROM Articles
WHERE author_id IN(
  SELECT id FROM Users
  WHERE name = 'Sam' 
);

-- with variable
SET @author_id := (SELECT id FROM Users
WHERE name = 'Sam');

SELECT title FROM Articles
WHERE author_id = @author_id;

-- q3 For all the articles being selected above, select all the articles and also the comments ASsociated with those articles in a single query (Do this using subquery also

-- without subquery
SELECT a.title AS Article, c.content AS Comment
FROM Comments AS c
  JOIN Articles AS a
    ON c.article_id = a.id
  JOIN Users AS u
    ON a.author_id = u.id
  WHERE u.name = 'Sam';

-- with subquery
SELECT title AS Article, c.content AS Comment
FROM Articles a, Comments c
WHERE
  a.author_id IN(
    SELECT id FROM Users
    WHERE name = 'Sam'
  ) AND
  c.article_id = a.id;

-- q4 Write a query to select all articles which do not have any comments (Do using subquery also)

-- without subquery
SELECT title FROM Articles AS a
  LEFT JOIN Comments AS c
    ON a.id = c.article_id
  WHERE c.content <=> NULL;

-- with subquery
SELECT title FROM Articles
WHERE id NOT IN(
  SELECT DISTINCT article_id FROM Comments
);

-- q5 Write a query to select article which hAS maximum comments
SELECT title, COUNT(c.author_id) AS No_of_Comments FROM Articles AS a
LEFT JOIN Comments AS c
ON a.id = c.article_id
GROUP BY title
ORDER BY COUNT(c.author_id) DESC
LIMIT 1;

-- q6 Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by )
SELECT a.title FROM Articles AS a
  LEFT JOIN Comments AS c
    ON a.id = c.article_id
  GROUP BY a.title
  HAVING COUNT(c.author_id) = COUNT(distinct c.author_id);