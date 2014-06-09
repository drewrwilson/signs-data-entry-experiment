  var counter = 0;
  var x = $("#location");
  function getLocation() {
      if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(showPosition);
      } else {
          x.html("Geolocation is not supported by this browser.");
      }
  }
  function showPosition(position) {
      if (position.coords.accuracy <= 5) {
        gps = 100;
      } else if ((position.coords.accuracy > 5) && (position.coords.accuracy <= 10)) {
        gps = 85;
      } else if ((position.coords.accuracy > 10) && (position.coords.accuracy <= 35)) {
        gps = 40;
      } else if ((position.coords.accuracy > 35) && (position.coords.accuracy <= 60)) {
        gps = 20;
      } else if (position.coords.accuracy > 65) {
        gps = 5;
      } else {
        gps = 0;
      }
      if (gps >= 85 ) {
        statusClass = 'success';
      } else if ((gps < 85 ) && (gps >= 40)) {
        statusClass = 'info';
      } else if ((gps < 40) && (gps >= 20)) {
        statusClass = 'warning';
      } else {
        statusClass = 'danger';
      }
      $('#gps-strength')
        .width(gps + '%')
        .removeClass()
        .addClass('progress-bar progress-bar-' + statusClass);
      $('#strength').html(gps + '%');
      $('#gps-details').html("Latitude: " + position.coords.latitude + ", Longitude: " + position.coords.longitude + ', Accuracy: '+ position.coords.accuracy);
  }

  var iFrequency = 1000; // expressed in miliseconds
  var myInterval = 0;

  // STARTS and Resets the loop if any
  function startLoop() {
      if(myInterval > 0) clearInterval(myInterval);  // stop
      myInterval = setInterval( "getLocation()", iFrequency );  // run
  }
  window.onload = function(){
    getLocation();
    startLoop();
  }
