PRAGMA foreign_keys = ON;

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
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    subject_question_id INTEGER NOT NULL,
    reply_id INTEGER,
    users_id INTEGER NOT NULL,

    FOREIGN KEY (subject_question_id) REFERENCES questions(id),
    FOREIGN KEY (reply_id) REFERENCES replies(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ('Mickey', 'Addai'),
    ('Matteo', 'Rossant');

INSERT INTO
    questions (title, body, author_id)
VALUES
    ('Is the World flat?', 'I heard some news about the world being flat. Is that true?', (SELECT id FROM users WHERE fname = 'Matteo')),
    ('Why is the Sky blue?', 'I heard it depends on the sunlight rays? Asking for a friend.', (SELECT id FROM users WHERE fname = 'Mickey'));

INSERT INTO
    question_follows (users_id, questions_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Mickey'), (SELECT id FROM questions WHERE title = 'Is the World flat?')),
    ((SELECT id FROM users WHERE fname = 'Matteo'), (SELECT id FROM questions WHERE title = 'Why is the Sky blue?'));

INSERT INTO
    replies (body, subject_question_id, reply_id, users_id)
VALUES
    ('Well, I went to the World is Flat convention and I could tell you. It sure is FLAAT.', (SELECT id FROM questions WHERE title = 'Is the World flat?'), NULL, (SELECT id FROM users WHERE fname = 'Mickey')),
    ('Yeah man, I was at that convention too!', (SELECT id FROM questions WHERE title = 'Is the World flat?'), 
    (SELECT id FROM replies WHERE body = 'Well, I went to the World is Flat convention and I could tell you. It sure is FLAAT.'), 
    (SELECT id FROM users WHERE fname = 'Matteo')),
    ('Because it is', (SELECT id FROM questions WHERE title = 'Why is the Sky blue?'), NULL, (SELECT id FROM users WHERE fname = 'Matteo'));

INSERT INTO
    question_likes (users_id, questions_id)
VALUES
    ((SELECT id FROM users WHERE fname = 'Mickey'), (SELECT id FROM questions WHERE title = 'Is the World flat?')),
    ((SELECT id FROM users WHERE fname = 'Matteo'), (SELECT id FROM questions WHERE title = 'Is the World flat?'));



