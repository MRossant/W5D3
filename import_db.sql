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
    body TEXT NOT NULL
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE IF EXISTS question_follows (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE IF EXISTS replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    subject_question_id INTEGER NOT NULL,
    reply_id INTEGER NOT NULL,
    users_id INTEGER NOT NULL,

    FOREIGN KEY (subject_question_id) REFERENCES questions(id)
    FOREIGN KEY (reply_id) REFERENCES replies(id),
    FOREIGN KEY (users_id) REFERENCES users(id),
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE IF EXISTS question_likes (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);


