'use strict';

//Basic API express
const express = require('express');
const mariadb = require('mariadb');
const app = express();
const PORT = process.env.PORT || 8080;

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
	const senddata = await getDataFromDb('task_query','traylsdb','task_id',getRandomInt(19));
    res.send(senddata);
});

app.get('/getApiTest', (req, res) => {
    res.send('API works');
});

app.post('/addUser', async function(req, res) {
    const { mail } = req.body;
	console.log(mail)
    const userId = await getDataFromDb('user_id','users','user_mail',`'${mail}'`);
	console.log(userId);
	if (userId == 'Not found') {
		await addToDb(`'${mail}'`);
		console.log('User does not exist, added it to database');
		res.send(`Welcome new user :) ${mail}`);
	} else {
		console.log('User exist');
		res.send(`Welcome ${mail}`);
	}
	
});

async function addToDb(mail) {
	let conn;
	try {
		conn = await pool.getConnection();
		//insert user in db
		conn.query(`INSERT INTO users(user_id, user_mail) VALUES (NULL, ${mail})`);
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



async function getDataFromDb(data, table, colVal, id) {
	let conn;
	let APIresponse;
	try {
		conn = await pool.getConnection();
		const rows = await conn.query(`SELECT ${data} FROM ${table} WHERE ${colVal} = ${id}`);
		removeMeta(rows);
        console.log(removeMeta(rows, data));
		APIresponse = removeMeta(rows) 
				
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

function removeMeta(parsedJson, data) {
    delete parsedJson['meta'];
	return parsedJson[0][data];
}

function getRandomInt(max) {
  return Math.floor(Math.random() * max) + 1;
}

//Middleware takes care of 404
//If higher up in code, it will be called first for some reason, and will not go through with any API calls
app.use(function(req, res) {
    res.status(404).send({url: req.originalUrl + ' not found. ERROR: 404'}) //send back 404
});