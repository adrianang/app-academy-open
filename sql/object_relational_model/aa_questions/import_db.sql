DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;
CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;
CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Arthur', 'Miller'),
  ('Homer', 'Simpson'),
  ('Kylie', 'Jenner');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Need help', 'My code won''t compile', 3),
  ('Critique my project?', 'I just finished the tribute page', 2),
  ('What''s next, after the AA curriculum', 'Please don''t recommend another Udemy course', 3),
  ('Quick q', 'Help me', 3);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (1, 1),
  (2, 1),
  (1, 2);

INSERT INTO
  replies (body, question_id, parent_reply_id, user_id)
VALUES
  ('Have you tried restarting', 1, NULL, 2),
  ('Not yet! Will do!', 1, 1, 3);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 2);