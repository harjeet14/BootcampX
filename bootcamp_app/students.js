const { Pool } = require('pg');
// let arg = process.argv.slice(2);
const cohortName = process.argv[2];
const limit = process.argv[3];
const values = [`%${cohortName}%`, limit]

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});
const queryString = `
SELECT students.id as student_id, students.name as name,cohorts.name AS cohort
FROM students 
INNER JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name LiKE $1
LIMIT $2;
`
pool.query(queryString, values)
  .then(res => {
    res.rows.forEach(user => {
      console.log(`${user.name} has an id ${user.student_id} and was in cohort ${user.cohort}.`
      )
    });
  })
  .catch(err => console.error('query error', err.stack));