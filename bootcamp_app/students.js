const { Pool } = require('pg');
let arg = process.argv.slice(2);
let cohortName = arg[0];
let limit = arg[1];

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});
pool.query(`
SELECT students.id as student_id, students.name as name,cohorts.name AS cohort
FROM students 
INNER JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = '${cohortName}'
LIMIT ${limit}
`)
  .then(res => {
    res.rows.forEach(user => {
      console.log(`${user.name} has an id ${user.student_id} and was in cohort ${user.cohort}.`
      )
    });
  })
  .catch(err => console.error('query error', err.stack));