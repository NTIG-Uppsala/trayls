'use strict';

/* -------------------------------------------------------------------------- */
/*                                 Dependencies                               */
/* -------------------------------------------------------------------------- */


const express = require('express');
const mariadb = require('mariadb');
const app = express();
const PORT = process.env.PORT || 8080;


/* -------------------------------------------------------------------------- */
/*                               MariaDB config                               */
/* -------------------------------------------------------------------------- */


const pool = mariadb.createPool({
    host: 'localhost',
	user: 'admin',
	password: 'admin123',
	database: 'trayls',
	connectionLimit : 20
});


/* -------------------------------------------------------------------------- */
/*                                 Middleware                                 */
/* -------------------------------------------------------------------------- */


//Parse JSON
app.use(express.json());


/* -------------------------------------------------------------------------- */
/*                                 API startup                                */
/* -------------------------------------------------------------------------- */


//Starts the API for it to listen
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});


/* -------------------------------------------------------------------------- */
/*                                  API routs                                 */
/* -------------------------------------------------------------------------- */

/* ------------------------------ GET requests ------------------------------ */

//Get task and task Id from task table
app.get('/task/', (req, res) => {
    getRandomTaskFromDatabase().then(result => {
        res.send(result);
    });
});



/* -------------------------------------------------------------------------- */
/*                          Functions used in the API                         */
/* -------------------------------------------------------------------------- */


/* --------- Random task and corresponding points from the task table-------- */
async function getRandomTaskFromDatabase() {
    let conn;
    let result;
    try {
        conn = await pool.getConnection();
        result = await conn.query('SELECT task_query, task_points FROM traylsdb ORDER BY RAND() LIMIT 1'); //Randomly select a task from task table
    } catch (err) {
        console.error(err);
    } finally {
        if (conn) return conn.end();
        result = result[0];
        return result;
    }
}

/* ----------------- Add a user to database with mail as id ----------------- */
async function addUserToDatabase(mail) {
    let conn;
    let result;
    try {
        conn = await pool.getConnection();
        result = await conn.query('INSERT INTO users (user_mail) VALUES (?)', mail); //Add user to database
    } catch (err) {
        console.error(err);
    } finally {
        if (conn) return conn.end();
        return result;
    }
}

/* ------------- Check if user is in database and add if its not ------------ */
async function checkUserInDatabase(mail) {
    let conn;
    let result;
    try {
        conn = await pool.getConnection();
        result = await conn.query('SELECT user_mail FROM users WHERE user_mail = ?', mail); //Check if user is in database
    } catch (err) {
        console.error(err);
    } finally {
        if (conn) return conn.end();
        result = result[0];
        if (result === undefined) {
            addUserToDatabase(mail);
        }
        return result;
    }
}

/* ---------------------- Get user points from database --------------------- */
async function getUserPointsFromDatabase(mail) {
    let conn;
    let result;
    try {
        conn = await pool.getConnection();
        result = await conn.query('SELECT user_points FROM users WHERE user_mail = ?', mail); //Get user points from database
    } catch (err) {
        console.error(err);
    } finally {
        if (conn) return conn.end();
        result = result[0];
        return result;
    }
}

/* ----------------------------- Sterilize mail ----------------------------- */
function sterilizeMail(mail) {
    let sterilizedMail = mail.replace(/[^a-zA-Z0-9]/g, '');
    return sterilizedMail;
}

/* -------------------------------------------------------------------------- */
/*                                 Middleware                                 */
/* -------------------------------------------------------------------------- */

//Middleware takes care of 404
//If higher up in code, it will be called first for some reason, and will not go through with any API calls
app.use(function(req, res) {
    res.status(404).send({url: req.originalUrl + ' not found. ERROR: 404'}) //send back 404
});