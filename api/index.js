'use strict';

//basic api express
const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

app.get('/getTrip/:id', (req, res) => { // Note to self. :id is the parameter. Don't need to put it in the url. Dont need : in the url
    const { id } = req.params;
    res.send(getLocation(id));
});

//read from json
function readFromJson() {
    const fs = require('fs');
    let rawdata = fs.readFileSync('location.json');
    return JSON.parse(rawdata);
}

//write to json
async function writeToJson(newLocation) {
    const fs = require('fs');
    fs.writeFile('location.json', JSON.stringify(newLocation), (err) => {
        if (err) throw err;
        console.log('The file has been saved!');
    });
}