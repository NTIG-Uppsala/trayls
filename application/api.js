function UserAction() {
    console.log("___________");
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
         if (this.readyState == 4 && this.status == 200) {
             alert(this.responseText);
         }
    };
    xhttp.open("open", "http://localhost:8080/getTrip/uppsala/Ekolns%20segelkubb", true);
    xhttp.setRequestHeader("Content-type", "application/json");
    /*line 12: "Failed to load resource: net::ERR_FAILED"*/
    xhttp.send('');
    let data = {'uppsala':'svandammen'}
}