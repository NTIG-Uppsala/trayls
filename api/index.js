'use strict';

//basic api express
const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

//Middleware to parse json
app.use(express.json());

app.use(function (req, res, next) {

    // Website you wish to allow to connect
    res.setHeader('Access-Control-Allow-Origin', '*');

    // Request methods you wish to allow
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

    // Request headers you wish to allow
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

    // Set to true if you need the website to include cookies in the requests sent
    // Pass to next layer of middleware
    next();
});

//Start upp api to listen
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

//Simple GET request get specigic location
app.get('/getTrip/:id/:key', (req, res) => { // Note to self. :id is the parameter. Don't need to put it in the url. Dont need : in the url
    const { id } = req.params;
    const { key } = req.params;
    res.send(getLocation(id, key));
});

//Get req get random location in town
app.get('/getTrip/:id/', (req, res) => {
    const { id } = req.params;
    //Get random number 1-3
    const key = Math.floor(Math.random() * 3) + 1;
    console.log(key);
    res.send(getLocation(id, key));
});

//POST request
app.post('/addTrip', (req, res) => {
    const { spot, town } = req.body; //In body when sending data from client, varables need to be the same as the varables here
    console.log(spot, town);
    console.log(isNewLocationInLocation(town, spot));
    if (isNewLocationInLocation(town, spot) == false) {
        addMoreDataToLocation(town, spot);
        res.send('Location added to database');
        return;
    }
    res.send('Location already in database');
});

//read from json
function readFromJson() {
    const fs = require('fs');
    let rawdata = fs.readFileSync('location.json');
    return JSON.parse(rawdata);
}

//write to json
//Add more data to location.json
function addMoreDataToLocation(town, spot) {
    const fs = require('fs');
    let rawdata = fs.readFileSync('location.json');
    let data = JSON.parse(rawdata);
    data.town[town].spots.push({
        "name": spot
    });
    fs.writeFile('location.json', JSON.stringify(data), (err) => {
        if (err) throw err;
        console.log('The file has been saved!');
    });
}

function isNewLocationInLocation(town, spot) {
    const fs = require('fs');
    let rawdata = fs.readFileSync('location.json');
    let json = JSON.parse(rawdata);
    let location = json.town[town];
    let spots = location.spots;
    for (let i = 0; i < spots.length; i++) {
        if (spots[i].name === spot) {
            return i;
        }
    }
    return false;
}

//Find a location based on town name
function getLocation(town, spot) {
    const locations = readFromJson();
    //check if spot is a number
    if (isNaN(spot) == false) {
        return locations.town[town].spots[spot];
    }
    try {
        const arrayPos = isNewLocationInLocation(town, spot);
        return locations.town[town].spots[arrayPos].name;
    } catch (e) {
        return 'No such location';
    }
}

//Middleware takes care of 404
//If higher up in code, it will be called first for some reason. And wont go through with any api calls
app.use(function(req, res) {
    res.status(404).send({url: req.originalUrl + ' not found. ERROR: 404'}) //send back 404
});
