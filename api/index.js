'use strict';

//basic api express
const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

app.get('/getWalk', (req, res) => {
    return res.send(getWalk());
});


function getWalk() {
    const fs = require('fs');
    const rawdata = fs.readFileSync('location.json');
    let location = JSON.parse(rawdata);
    console.log(location.town);
    //let thisWalk = location.city.uppsala.svandammen];
    return 'hej';
}