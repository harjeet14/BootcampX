-- Get the total number of assignments for each day 
SELECT day, count(assignments.*)AS total_assignments
FROM assignments 
GROUP BY day
ORDER BY day;

-- The same query as before, but only return rows where total assignments is greater than or equal to 10
SELECT day, count(assignments.*)AS total_assignments
FROM assignments
 GROUP BY day
HAVING count(assignments.*) >=10
-- ORDER BY day;

-- Get all cohorts with 18 or more students
SELECT cohorts.name, count(students.cohort_id) AS student_count 
FROM students
JOIN cohorts ON cohort_id = cohorts.id
GROUP BY cohorts.name
HAVING count(students.cohort_id) >=18
ORDER BY count(students.cohort_id);

-- Get the total number of assignment submissions for each cohort.
SELECT cohorts.name ,count(assignment_submissions.*)AS total_assignments
FROM assignment_submissions
JOIN students  ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
GROUP BY cohorts.name
ORDER BY total_assignments DESC;


-- Get currently enrolled students average assignment completion time
SELECT students.name , AVG(assignment_submissions.duration) AS average_assignment_duration
FROM assignment_submissions
JOIN students  ON student_id = students.id
WHERE end_date IS NULL
GROUP BY students.name 
ORDER BY average_assignment_duration DESC;

SELECT students.name AS student,
 AVG(assignment_submissions.duration) AS average_assignment_duration, 
 AVG(assignments.duration) AS average_estimated_duration
 FROM students
 JOIN assignment_submissions ON student_id = students.id
 JOIN  assignments ON assignment_id = assignments.id
 WHERE end_date IS NULL
 GROUP BY student
 HAVING AVG(assignment_submissions.duration) < AVG(assignments.duration)
 ORDER BY average_assignment_duration ; 
