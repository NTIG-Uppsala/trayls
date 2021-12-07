'use strict';

//Basic API express and MariaDB setup
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
});

//Middleware to parse json
app.use(express.json());

//Starts the API for it to listen
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

//Simple GET request
app.get('/getTask', async function(req, res) {
	const sendData = await getDataFromDatabase();
    res.send(sendData);
});

//Test so API is up and works
app.get('/getApiTest', (req, res) => {
    res.send('API works');
});

//Post for adding a new user it checks if it exists in the database
app.post('/addUser', async function(req, res) {
    const { mail } = req.body;
    const userId = await getMailFromDatabase(`'${mail}'`);
	if (userId == 'Not found') {
		await addUserToDatabase(`'${mail}'`);
		console.log('User does not exist, added user to database');
		res.send('Welcome new user');
	} else {
		console.log('User exist');
		res.send(`Welcome ${mail}`);
	}
});

//Adds a new user to the database
async function addUserToDatabase(mail) {
	let conn;
	
	try {
		conn = await pool.getConnection();
		//insert user in database
		conn.query(`INSERT INTO users(user_id, user_mail) VALUES (NULL, ${mail})`);
        console.log('Successfully added user');
	} catch (err) {
		console.log('Failed');
		throw err;
	} finally {
		if (conn) {
			conn.end();
			return;
		}
	}
}

//Gets data from the database
async function getDataFromDatabase() {
	let conn;
	let APIresponse;
	try {
		conn = await pool.getConnection();
		const rows = await conn.query(`SELECT task_query, task_points FROM traylsdb ORDER BY RAND() LIMIT 1`);
		APIresponse = parseResponse(rows, 'task_query,task_points');
	} catch (err) {
		console.log('ERROR!!!')
		APIresponse = 'Not found';
		console.log(err)
		throw err;
	} finally {
		if (conn) {
			conn.end();
			return APIresponse
		}
	}
}
async function getMailFromDatabase(mail) {
	let conn;
	let APIresponse;
	try {
		conn = await pool.getConnection();
		const rows = await conn.query(`SELECT user_id FROM users WHERE user_mail=${mail}`);
		APIresponse = parseResponse(rows, data);
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


//Removes the meta data from the response, and parses it so the response becomes a string
function parseResponse(parsedRowsData, data) {
	delete parsedRowsData['meta'];
	const rowValue = parsedRowsData[0];
	if (data.includes(',')) {
		data = data.split(',');
		let returnList = []
		for(let i = 0; i < Object.keys(rowValue).length; i++){
			returnList.push(rowValue[data[i]])
		}
		return returnList;
	}
	return rowValue[data];
	
}

//Middleware takes care of 404
//If higher up in code, it will be called first for some reason, and will not go through with any API calls
app.use(function(req, res) {
    res.status(404).send({url: req.originalUrl + ' not found. ERROR: 404'}) //send back 404
});