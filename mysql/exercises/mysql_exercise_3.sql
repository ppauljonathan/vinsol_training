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
  ('James', 'admin'),
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
    ('sorry 7/10', 5, 6),
    ('nice', 2, 6);

-- Deleting values in table

DELETE FROM Comments
  WHERE content like 'meh';

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
  WHERE c.content IS NULL;

-- with subquery
SELECT title FROM Articles
WHERE id NOT IN(
  SELECT DISTINCT article_id FROM Comments
);

-- q5 Write a query to select articles which has maximum comments
SELECT A.id, A.title, COUNT(C.author_id) FROM Articles AS A
  JOIN Comments AS C
    ON A.id = C.article_id
GROUP BY C.article_id
HAVING COUNT(C.author_id) = (
  SELECT MAX(CC.total) FROM (
    SELECT article_id, COUNT(author_id) as total
    FROM Comments
    GROUP BY article_id) AS CC
  );


CREATE INDEX author3
ON Users (id);

ALTER TABLE Users
DROP INDEX author;

CREATE INDEX authorc
ON Comments(author_id);

CREATE INDEX authera
ON Articles(author_id);

-- q6 Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by )
SELECT a.id, a.title FROM Articles AS a
  LEFT JOIN Comments AS c
    ON a.id = c.article_id
  GROUP BY a.title
  HAVING COUNT(c.author_id) = COUNT(distinct c.author_id)
  ORDER BY a.title;

SELECT id, title FROM Articles
  WHERE id NOT IN(
    SELECT article_id FROM Comments
    GROUP BY article_id, author_id
    HAVING COUNT(author_id) > 1
  )
  ORDER BY title;