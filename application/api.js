function UserAction() {
    console.log("hej");
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
         if (this.readyState == 4 && this.status == 200) {
             alert(this.responseText);
         }
    };
    xhttp.open("GET", "localhost:8080/getTrip/uppsala/Ekolns%20segelkubb", true);
    xhttp.setRequestHeader("Content-type", "application/json");
    xhttp.send();
}