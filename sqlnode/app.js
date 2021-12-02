'use strict';

//Basic API express and mariadb setup
const express = require('express');
const mariadb = require('mariadb');
const app = express();
const PORT = process.env.PORT || 8080;


//MariaDB setup
const pool = mariadb.createPool({
    host: 'localhost',
	user: 'admin',
	password: 'admin123',
	database: 'trayls',
	connectionLimit : 20
});

//Middleware to parse json
app.use(express.json());

//Starts the API for it to listen
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

//Simple GET request
app.get('/getTask', async function(req, res) {
	const sendData = await getDataFromDb('task_query', 'traylsdb', 'task_id', getRandomInt(19));
    res.send(sendData);
});


//Test so api is up
app.get('/getApiTest', (req, res) => {
    res.send('API works');
});

//Post for adding a new user it checks if it exists in the db
app.post('/addUser', async function(req, res) {
    const { mail } = req.body;
    const userId = await getDataFromDb('user_id','users','user_mail',`'${mail}'`);
	if (userId == 'Not found') {
		await addToDb(`'${mail}'`);
		console.log('User does not exist, added it to database');
		res.send(`Welcome new user :) ${mail}`);
	} else {
		console.log('User exist');
		res.send(`Welcome ${mail}`);
	}
	
});

//Adds a new user to the database
async function addToDb(mail) {
	let conn;
	try {
		conn = await pool.getConnection();
		//insert user in db
		conn.query(`INSERT INTO users(user_id, user_mail) VALUES (NULL, ${mail})`);
        console.log('Successfully added user');
	} catch (err) {
		console.log('Failed');
		throw err;
	} finally {
		if (conn) {
			conn.end();
			return response;
		}
	}
}


//Gets data from the database
async function getDataFromDb(data, table, colVal, id) {
	let conn;
	let APIresponse;
	try {
		conn = await pool.getConnection();
		const rows = await conn.query(`SELECT ${data} FROM ${table} WHERE ${colVal} = ${id}`);
		APIresponse = parseResponse(rows);
				
	} catch (err) {
		console.log('ERROR!!!')
		APIresponse = 'Not found';
		throw err;
	} finally {
		if (conn) {
			conn.end();
			return APIresponse
		}
	}
}

//Removes the meta data from the response, and parses it so response is a string
function parseResponse(parsedJson, data) {
    delete parsedJson['meta'];
	return parsedJson[0][data];
}


//Gets a random number between 1 and 20, used for getting a random task.
//note: this is not a good way to do this, but it works for now. Better way to do this is to check with the database how many rows there are in the table.
function getRandomInt(max) {
  return Math.floor(Math.random() * max) + 1;
}

//Middleware takes care of 404
//If higher up in code, it will be called first for some reason, and will not go through with any API calls
app.use(function(req, res) {
    res.status(404).send({url: req.originalUrl + ' not found. ERROR: 404'}) //send back 404
});