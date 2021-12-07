'use strict';

/* -------------------------------------------------------------------------- */
/*                                 Dependencies                               */
/* -------------------------------------------------------------------------- */


const express = require('express');
const mariadb = require('mariadb');
const { check, validationResult } = require('express-validator');
const bodyParser = require('body-parser'); // Middleware
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

app.use(bodyParser.urlencoded({ extended: false }));


/* -------------------------------------------------------------------------- */
/*                              Helper variables                              */
/* -------------------------------------------------------------------------- */


/* ------------------------- Check if mail is a mail ------------------------ */
var validateMail = [ //Documentation uses var so I'll use var
    check('mail', 'Must Be an Email Address').isEmail().trim().escape().normalizeEmail()
]


/* -------------------------------------------------------------------------- */
/*                                  API routs                                 */
/* -------------------------------------------------------------------------- */


/* ------------------------------ GET requests ------------------------------ */

//Get task and task Id from task table
app.get('/task', (req, res) => {
    getRandomTaskFromDatabase().then(result => {
        res.send(result);
    });
});

/* ------------------------------ POST requests ----------------------------- */

app.post('/user', validateMail, (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({ errors: errors.array() });
    }
    const mail = req.body;
    checkUserInDatabase(mail).then(result => {
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
        if (conn) conn.end();
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
        if (conn) conn.end();
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
        if (conn) conn.end();
        result = result[0];
        if (result === undefined) {
            addUserToDatabase(mail);
            return 'Ny användare'
        }
        return 'Välkommen tillbaka';
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
        if (conn) conn.end();
        result = result[0];
        return result;
    }
}

/* -------------------------------------------------------------------------- */
/*                                 Middleware                                 */
/* -------------------------------------------------------------------------- */

//Middleware takes care of 404
//If higher up in code, it will be called first for some reason, and will not go through with any API calls
app.use(function(req, res) {
    res.status(404).send({url: req.originalUrl + ' not found. ERROR: 404'}) //send back 404
});


/* -------------------------------------------------------------------------- */
/*                                 API startup                                */
/* -------------------------------------------------------------------------- */


//Starts the API for it to listen
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});