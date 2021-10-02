CREATE TABLE assignments(id SERIAL PRIMARY KEY NOT NULL,
name VARCHAR(255) NOT NULL,
content TEXT,
day INTEGER,
chapter INTEGER,
duration INTEGER
);
-- SELECT * FROM assignments;

CREATE TABLE assignment_submissions(id SERIAL PRIMARY KEY NOT NULL,
student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
assignment_id INTEGER REFERENCES assignments(id) ON DELETE CASCADE,
duration INTEGER,
submission_date DATE
);
SELECT count(*) FROM assignment_submissions;

