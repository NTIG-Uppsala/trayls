'use strict';

/* -------------------------------------------------------------------------- */
/*                                 Dependencies                               */
/* -------------------------------------------------------------------------- */

const express = require('express');
const { check, validationResult } = require('express-validator');
const mariadb = require('mariadb');
const bodyParser = require('body-parser'); // Middleware
const app = express();
const PORT = process.env.PORT || 8080;
const fs = require('fs');


/* -------------------------------------------------------------------------- */
/*                               MariaDB config                               */
/* -------------------------------------------------------------------------- */



const pool = mariadb.createPool({
    host: readConfig('DB_HOST'),
	user: readConfig('DB_USERNAME'),
	password: readConfig('DB_PASS'),
	database: readConfig('DB_DATABASE'),
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

//Get points for specific mail
app.get('/points', validateMail, (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({ errors: errors.array() });
    }
    getUserPointsFromDatabase(req.query.mail).then(result => {
        res.send(result);
    });
});


/* ------------------------------ POST requests ----------------------------- */

//Post request, check if user is in db, If it's not the it will be added.
app.post('/user', validateMail, (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({ errors: errors.array() });
    }
    const mail = req.body.mail;
    checkUserInDatabase(mail).then(result => {
        res.send(result);
    });
});

//Accept a task
app.post('/accTask', validateMail, async function(req, res) {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({errors: errors.array});
    }
    const taskId = req.body.task_id; //Might be the wrong name "task_id";
    const userId = await getUserIdWithMail(req.body.mail);
    if (userId == -1) return res.send('Ogiltig mail');
    setTaskStatus(taskId, userId).then(result => {
        res.send(result);
    })
})

/* ------------------------------- PUT request ------------------------------ */
//Put request, chance latest accepted task status to done or cancel
app.put('/changeTask', validateMail, async function(req, res) {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({ errors: errors.array() });
    }
    const userId = await getUserIdWithMail(req.body.mail);
    if (userId == -1) return res.send('Not a valid mail');
    const status = req.body.status;
    changeTaskStatus(userId, status).then(result => {
        res.send(result);
    });
});


/* ------------------- DELETE request for testing purpose ------------------- */
app.delete('/user', validateMail, async function(req, res) {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(422).json({ errors: errors.array() });
    }
    const mail = req.body.mail;
    const pw = req.body.pw;
    if (pw == readConfig('API_KEY')) {
        await deleteUserFromDatabase(mail).then(result => {
            if (result.affectedRows == 0) {
                return res.send('Denna användare finns inte')
            }
            return res.send('Användare Borttagen');
        });
    } else {
        res.send('Wrong password');
    }
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
            return 'Ny användare';
        }
        return 'Välkommen tillbaka';
    }
}

/* --------------------------- Get a mails user id -------------------------- */
async function getUserIdWithMail(mail) {
    let conn;
    let result;
    try {
        conn = await pool.getConnection();
        result = await conn.query('SELECT user_id FROM users WHERE user_mail = ?', mail); //Get the user id from a mail adress
    } catch (err) {
        console.error(err);
    } finally {
        if (conn) conn.end();
        result = result[0];
        if (result === undefined) {
            return -1; 
        }
        return result['user_id']; //If no user
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

/* -------- Confirm task and add the task_id, user_id and task_state to the db -------- */
async function setTaskStatus(userId, taskId) {
    let conn;
    let result;
    try {
        conn = await pool.getConnection();
        result = await conn.query('INSERT INTO task_state (user_id, task_id, task_status, task_history) VALUES (?, ?, ?, ?)', [taskId, userId, 2, null]); //Add task_state to database taskState can be 1,2 or 3 //1 = done, 2 = in progress, 3 = canceled
    } catch (err) {
        console.error(err);
    } finally {
        if (conn) conn.end();
        return result;
    }
}

/* ----------- Change the latest taskState a mail has to 1,2 or 3 ----------- */
async function changeTaskStatus(mail, taskState) {
    let conn;
    let result;
    try {
        conn = await pool.getConnection();
        result = await conn.query('UPDATE task_state SET task_status = ? WHERE user_id = (SELECT user_id FROM users WHERE user_id = ?) ORDER BY task_history DESC LIMIT 1', [taskState, mail]); //Change the latest taskState a mail has to 1 or 3
    } catch (err) {
        console.error(err);
    } finally {
        if (conn) conn.end();
        return result; 
    }
}

/* -------------------- Delete user from database by mail ------------------- */
async function deleteUserFromDatabase(mail) {
    let conn;
    let result;
    try {
        conn = await pool.getConnection();
        result = await conn.query('DELETE FROM users WHERE user_mail = ?', mail); //Delete user from database
    } catch (err) {
        console.error(err);
    } finally {
        if (conn) conn.end();
        return result;
    }
}

/* ------------------------- Read file to get config ------------------------ */
function readConfig(key) {
    const json = fs.readFileSync('../trayls.json');
    const parsedJson = JSON.parse(json);
    return parsedJson[key];
}

/* -------------------------------------------------------------------------- */
/*                                 Middleware                                 */
/* -------------------------------------------------------------------------- */

//Middleware takes care of 404
//If higher up in code, it will be called first for some reason, and will not go through with any API calls
app.use(function(req, res) {
    res.status(404).send({url: '404 Error'}); //send back 404
});


/* -------------------------------------------------------------------------- */
/*                                 API startup                                */
/* -------------------------------------------------------------------------- */


//Starts the API for it to listen
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});