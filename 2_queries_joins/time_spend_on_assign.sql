-- Get the total amount of time that a student has spent on all assignments
SELECT sum(duration) AS total_duration
FROM assignment_submissions a
JOIN students s ON a.student_id = s.id
WHERE s.name = 'Ibrahim Schimmel' ;

-- Get the total amount of time that all students from a specific cohort have spent on all assignments
SELECT sum(duration) AS total_duration
FROM assignment_submissions a
JOIN students s ON a.student_id = s.id
JOIN cohorts c ON c.id = s.cohort_id
WHERE c.name = 'FEB12';
