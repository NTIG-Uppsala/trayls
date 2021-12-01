'use strict';

//basic api express
const express = require('express');
const mariadb = require('mariadb');
const app = express();
const PORT = process.env.PORT || 8080;

const pool = mariadb.createPool({
    host: 'localhost',
	user: 'task_user',
	password: 'Hej123hej',
	database: 'trayls'
});

//Middleware to parse json
app.use(express.json());

//Start upp api to listen
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

//Simple GET request
app.get('/getTask', async function(req, res) {
	const senddata = await getTaskFromDb('traylsdb', value);
    res.send(senddata);
});

app.get('/getApiTest', (req, res) => {
    res.send('API works')
});

app.post('',(req, res) => {
    const {
        mail
    } = req.body
} )



async function getTaskFromDb(table, task_id) {
	let conn;
	let APIresponse;
	try {
		conn = await pool.getConnection();
		const rows = await conn.query(`SELECT * FROM ${table} traylsdb WHERE task_id = ${task_id}`);
		removeMeta(rows);
        console.log(removeMeta(rows));
		APIresponse = removeMeta(rows) 
		
		
	} catch (err) {
		console.log('ERROR!!!')
		throw err;
	} finally {
		if (conn) {
			conn.end();
			return APIresponse
		}
	}
}

function removeMeta(parsedJson) {
    delete parsedJson['meta'];
	return parsedJson;
}

function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}

let value = getRandomInt(20);
getTaskFromDb('traylsdb', value);
getTaskFromDb('taskvalues', value);

//Middleware takes care of 404
//If higher up in code, it will be called first for some reason. And wont go through with any api calls
app.use(function(req, res) {
    res.status(404).send({url: req.originalUrl + ' not found. ERROR: 404'}) //send back 404
});