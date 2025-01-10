const express = require('express');
const ejs = require('ejs');
const util = require('util');
const mysql = require('mysql2');
const bodyParser = require('body-parser');


/**
 * The following constants with your MySQL connection properties
 * You should only need to change the password
 */

const PORT = 8000;
const DB_HOST = 'localhost';
const DB_USER = 'root';
const DB_PASSWORD = '';
const DB_NAME = 'coursework';
const DB_PORT = 3306;

/**
 * DO NOT CHANGE ANYTHING BELOW THIS LINE UP TO THE NEXT COMMENT
 */
var connection = mysql.createConnection({
	host: DB_HOST,
	user: DB_USER,
	password: DB_PASSWORD,
	database: DB_NAME,
	port: DB_PORT
});

connection.query = util.promisify(connection.query).bind(connection);

connection.connect(function (err) {
	if (err) {
		console.error('error connecting: ' + err.stack);
		console.log('Please make sure you have updated the password in the index.js file. Also, ensure you have run db_setup.sql to create the database and tables.');
		return;
	}
	console.log('Connected to the Database');
});


const app = express();

app.set('view engine', 'ejs');
app.use(express.static('public'));
app.use(bodyParser.urlencoded({ extended: false }));

/**
 * YOU CAN CHANGE THE CODE BELOW THIS LINE
 */

// Add your code here

app.get('/', async (req, res) => {
	const totalcourses = await connection.query("SELECT COUNT(*) as count FROM coursework.course;");
	const totalenrollment = await connection.query("SELECT SUM(Crs_Enrollment) as sum FROM coursework.course;");
	const averageenrollments = await connection.query("SELECT AVG(Crs_Enrollment) as avg FROM coursework.course;");
	const highestenrollments = await connection.query("SELECT Crs_Title as title FROM coursework.course WHERE Crs_Enrollment=(SELECT MAX(Crs_Enrollment) FROM coursework.course);");
	const lowestenrollments = await connection.query("SELECT Crs_Title as title FROM coursework.course WHERE Crs_Enrollment=(SELECT MIN(Crs_Enrollment) FROM coursework.course);");
	res.render('index',{
		totalcourses:totalcourses[0].count,
		totalenrollment:totalenrollment[0].sum,
		averageenrollments:averageenrollments[0].avg,
		highestenrollments:highestenrollments[0].title,
		lowestenrollments:lowestenrollments[0].title
	});
});

app.get('/courses', async (req, res) => {
	const courses = await connection.query("SELECT * FROM coursework.course")
	res.render('courses',{
		courses:courses
	});
});

// need to get id info
app.get('/edit-course/:id', async (req, res) => { 
	res.render('edit', {
		error:false
	});
});

app.get('/create-course', async (req, res) => {
	res.render('create');
});

app.post('/create-course')

// need to get id info
app.post('/edit-course/:id', async (req, res) => {
	const data = req.body
	if(data.Crs_Title != "" && !(10 <= data.Crs_Title.length) && !(data.Crs_Title.length <= 250) && data.Crs_Enrollment != "" && !isNaN(data.Crs_Enrollment) && !( 0 <= data.Crs_Enrollment) && !(data.Crs_Enrollment <= 10000)){
		res.render("edit", {
			error:true
		})
		return
	} 
	try{
		await connection.query("UPDATE coursework.course SET ? WHERE Crs_Code = ?",
			[data, req.params.id]
		)
	} catch {
		res.render("edit", {
			error:true
		})
	}
})


/**
 * DON'T CHANGE ANYTHING BELOW THIS LINE
 */

app.listen(PORT, () => {

	console.log(`Server is running on port http://localhost:${PORT}`);

});



exports.app = app;