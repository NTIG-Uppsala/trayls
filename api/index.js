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


function getWalk() {
    const fs = require('fs');
    const rawdata = fs.readFileSync('location.json');
    let location = JSON.parse(rawdata);
    console.log(location.town);
    //let thisWalk = location.city.uppsala.svandammen];
    return 'hej';
}