'use strict';

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
app.get('/getTrip/:id', (req, res) => { // Note to self. :id is the parameter. Don't need to put it in the url. Dont need : in the url
    const { id } = req.params;
    res.send(getLocation(id));
});

//POST request
app.post('/addTrip', (req, res) => {
    const { name, town } = req.body;
    console.log(name, town);
    if (isNewLocationInLocation(name, town)) {
        res.send('Location already exists');
        return;
    }
    addMoreDataToLocation(name, town);
    res.send('Location added to database');
});

//read from json
function readFromJson() {
    const fs = require('fs');
    let rawdata = fs.readFileSync('location.json');
    return JSON.parse(rawdata);
}

//write to json
//Add more data to location.json
function addMoreDataToLocation(name, townName) {
    const fs = require('fs');
    let rawdata = fs.readFileSync('location.json');
    let data = JSON.parse(rawdata);
    data.town[townName].spots.push({
        "name": name
    });
    fs.writeFile('location.json', JSON.stringify(data), (err) => {
        if (err) throw err;
        console.log('The file has been saved!');
    });
}

function isNewLocationInLocation(name, townName) {
    const fs = require('fs');
    let rawdata = fs.readFileSync('location.json');
    let json = JSON.parse(rawdata);
    let location = json.town[townName];
    let spots = location.spots;
    for (let i = 0; i < spots.length; i++) {
        if (spots[i].name === name) {
            return true;
        }
    }
    return false;
}

//Find a location based on town name
function getLocation(town) {
    const locations = readFromJson();
    try {
        return locations.town[town].spots[0].name;
    } catch (e) {
        return 'No such location';
    }
}

//Middleware takes care of 404
//If higher up in code, it will be called first for some reason. And wont go through with any api calls
app.use(function(req, res) {
    res.status(404).send({url: req.originalUrl + ' not found. ERROR: 404'}) //send back 404
});
