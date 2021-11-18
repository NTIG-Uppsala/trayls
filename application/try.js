$(function () {
    $.ajax({
        type: 'GET',
        url: 'http://localhost:8080/getTrip/uppsala',
        success: function (data) {     
            $('#apiRes').text(data.name);
        }
    })
})