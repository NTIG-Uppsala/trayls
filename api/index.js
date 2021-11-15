const { log } = require('console');

const app = require('express')();
const PORT = 8060;

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});

app.get('/getWalk', (req, res) => {
    return res.send(getWalk());
});


function getWalk() {
    const fs = require('fs');
    const rawdata = fs.readFileSync('location.json');
    let location = JSON.parse(rawdata);
    console.log(location.city.uppsala[0]);
    //let thisWalk = location.city.uppsala.svandammen];
    return "hej";
}