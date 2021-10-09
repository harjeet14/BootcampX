-- Get the total number of assistance_requests for a teacher.
SELECT teachers.name AS teacher_name , count(*) AS total_assistances
FROM assistance_requests
JOIN teachers ON assistance_requests.teacher_id = teachers.id
 WHERE teachers.name = 'Waylon Boehm'
GROUP BY assistance_requests.teacher_id, teachers.name;

-- Get the total number of assistance_requests for a student.
SELECT students.name , count(*) AS total_assistances
FROM assistance_requests
JOIN students ON student_id = students.id
 WHERE students.name = 'Elliot Dickinson'
GROUP BY  students.name;

-- Get important data about each assistance request.

SELECT teachers.name AS teacher,
 students.name AS student,assignments.name AS assignment ,
(completed_at- started_at) AS duration
FROM assistance_requests
JOIN students ON student_id = students.id
JOIN teachers ON teacher_id = teachers.id
JOIN assignments ON assignment_id = assignments.id
ORDER BY duration ;

-- Get the average time of an assistance request

SELECT AVG(completed_at- started_at) AS average_assistance_request_duration
FROM assistance_requests;

-- Get the average duration of assistance requests for each cohort
SELECT (cohorts.name)AS name,AVG(completed_at- started_at) AS average_assistance_time
FROM assistance_requests
 JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
GROUP BY cohorts.name
ORDER BY average_assistance_time;

-- Get the cohort with the longest average duration of assistance requests.
SELECT (cohorts.name)AS name,AVG(completed_at- started_at) AS average_assistance_time
FROM assistance_requests
JOIN students ON assistance_requests.student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
GROUP BY cohorts.name
ORDER BY average_assistance_time DESC
LIMIT 1;

-- Calculate the average time it takes to start an assistance request
SELECT AVG(started_at - created_at) AS average_wait_time 
FROM assistance_requests;

-- Get the total duration of all assistance requests for each cohort
SELECT cohorts.name AS  cohort , SUM(completed_at- started_at) AS total_duration
FROM assistance_requests
JOIN students ON assistance_requests.student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
GROUP BY cohorts.name
ORDER BY total_duration;

-- Calculate the average total duration of assistance requests for each cohort.
SELECT AVG(total_duration) AS average_total_duration
from (SELECT cohorts.name AS  cohort , SUM(completed_at- started_at) AS total_duration
FROM assistance_requests
JOIN students ON assistance_requests.student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
GROUP BY cohorts.name
ORDER BY total_duration 
) AS total_duration;

-- List each assignment with the total number of assistance requests with it.
  SELECT assignments.id,assignments.name,assignments.chapter,assignments.day ,COUNT(assistance_requests.*) AS total_requests
  FROM assistance_requests
  JOIN assignments ON assignment_id = assignments.id
  GROUP BY assignments.id,assignments.name,assignments.chapter,assignments.day
  ORDER BY total_requests DESC;

  -- Get each day with the total number of assignments and the total duration of the assignments
  SELECT assignments.day,COUNT(*) AS num_of_assignments,SUM(assignments.duration) AS duration
  FROM assignments
  GROUP BY assignments.day
  ORDER BY assignments.day;

SELECT DISTINCT teachers.name as teacher, cohorts.name as cohort
FROM teachers
JOIN assistance_requests ON teacher_id = teachers.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
ORDER BY teacher;

SELECT DISTINCT teachers.name as teacher, cohorts.name as cohort, COUNT(assistance_requests) AS total_assistances
FROM teachers
JOIN assistance_requests ON teacher_id = teachers.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
GROUP BY teachers.name,cohorts.name
ORDER BY teacher;