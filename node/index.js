'use strict';

const { json } = require('express');
//basic api express
const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

//Middleware to parse json
app.use(express.json());

//Start upp api to listen
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

//Simple GET request
app.get('/getTask', (req, res) => {
    res.send(randomTask())
});

app.get('/getApiTest', (req, res) => {
    res.send('API works')
});

//read from json
function readFromJson() {
    const fs = require('fs');
    let rawdata = fs.readFileSync('task.json');
    return JSON.parse(rawdata);
}

function randomTask() {
    const tasks = readFromJson();
    const arrayPos = Math.floor(Math.random() * tasks.task.motivation.length);
    let hej = tasks.task.motivation[arrayPos].daily;
    return hej;
}

//Middleware takes care of 404
//If higher up in code, it will be called first for some reason. And wont go through with any api calls
app.use(function(req, res) {
    res.status(404).send({url: req.originalUrl + ' not found. ERROR: 404'}) //send back 404
});
