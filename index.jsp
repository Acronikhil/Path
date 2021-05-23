<!DOCTYPE html>
<html>

<head>
  <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
  <meta charset="utf-8">
  <title>Directions Service</title>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
    integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
  <link rel="stylesheet" href="styles.css">
  <link rel="stylesheet" href="help.css">
  <style>
    /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
    html {
      font-family: sans-serif;
      line-height: 1.15;
      height: 100%;
    }

    body {
      margin: 0;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
      font-size: 1rem;
      font-weight: 400;
      line-height: 1.5;
      color: #1a1a1a;
      text-align: left;
      height: 100%;
      background-color: #fff;
    }

    .containers {
      display: flex;
      flex-direction: column;
      height: 75vh;
    }

    #map {
      flex: 1;
      background: #f0f0f0;
    }

    .info {
      padding: 0.2rem;
      margin: 0;
    }

    .info.error {
      color: #fff;
      background: #dc3545;
    }

    .curLoc {
      width: 100vw;
      margin: auto;
      height: 30px;
      color: #fff;
      background: darkblue;
    }

    #map {
      height: 100%;
    }

    /* Optional: Makes the sample page fill the window. */
    html,
    body {
      height: 100%;
      margin: 0;
      padding: 0;
    }

    #floating-panel {
      position: absolute;
      top: 10px;
      left: 25%;
      z-index: 5;
      background-color: #fff;
      padding: 5px;
      border: 1px solid #999;
      text-align: center;
      font-family: 'Roboto', 'sans-serif';
      line-height: 30px;
      padding-left: 10px;
    }

    .modal {
      display: none;
      position: fixed;
      z-index: 1000;
      top: 0;
      left: 0;
      height: 100%;
      width: 100%;
      background: rgba(0, 0, 0, .8) url('http://i.stack.imgur.com/FhHRx.gif') 50% 50% no-repeat;
    }

    /* When the body has the loading class, we turn
   the scrollbar off with overflow:hidden */
    body.loading .modal {
      overflow: hidden;
    }

    body.loading .modal {
      display: block;
    }

    body.loading .modal .waitInfo {
      position: relative;
      margin-top: 200px;
      color: #fff;
    }

  </style>
</head>

<body>
  <div id="floating-panel w3-responsive">
    <form class="position cbg" action="PolylineString" method="post">
      <!-- <b class="titles">Start: </b> -->

      <div class="input-group input-group-sm mt-2 mb-3">
        <span class="input-group-text fw-bold col-2" id="inputGroup-sizing-sm">Start</span>
        <input type="text" list=text_editors class="form-control text-capitalize" aria-label="Sizing example input"
          aria-describedby="inputGroup-sizing-sm">
      </div>
      <div class='w3-center cbg'>
        <datalist class="dtl" id="text_editors">
          <select id="start" name="start" class="d_data">
            <option value="chicago">Chicago</option>
            <option value="st louis">St Louis</option>
            <option value="joplin">Joplin, MO</option>
            <option value="oklahoma city">Oklahoma City</option>
            <option value="amarillo">Amarillo</option>
            <option value="gallup">Gallup, NM</option>
            <option value="flagstaff">Flagstaff, AZ</option>
            <option value="winona">Winona</option>
            <option value="kingman">Kingman</option>
            <option value="barstow">Barstow</option>
            <option value="san bernardino">San Bernardino</option>
            <option value="los angeles">Los Angeles</option>
            <option value="pune">Pune</option>
            <option value="Bhavarkuan">Bhavarkuan, Indore, India</option>
            <option value="Kendriya Vidhalaya, Khargone, Madhaya Padesh, 451001">Kendriya Vidhalaya, Khargone, Madhaya
              Padesh, 451001</option>
          </select></datalist>
      </div>
      <!-- <b class="titles">End: </b> -->

      <div class="input-group input-group-sm mb-3">
        <span class="input-group-text fw-bold col-2" id="inputGroup-sizing-sm">End</span>
        <input type="text" list=text_editors class="form-control text-capitalize" aria-label="Sizing example input"
          aria-describedby="inputGroup-sizing-sm">
      </div>
      <div class='w3-center'>
        <datalist class="dtl" id="text_editors">
          <select id="end" name="end" class="d_data">
            <option value="chicago">Chicago</option>
            <option value="st louis">St Louis</option>
            <option value="joplin">Joplin, MO</option>
            <option value="oklahoma city">Oklahoma City</option>
            <option value="amarillo">Amarillo</option>
            <option value="gallup">Gallup, NM</option>
            <option value="flagstaff">Flagstaff, AZ</option>
            <option value="winona">Winona</option>
            <option value="kingman">Kingman</option>
            <option value="barstow">Barstow</option>
            <option value="san bernardino">San Bernardino</option>
            <option value="los angeles">Los Angeles</option>
            <option value="pune">Pune</option>
            <option value="Bhavarkuan">Bhavarkuan, Indore, India</option>
            <option value="Kendriya Vidhalaya, Khargone, Madhaya Padesh, 451001">Kendriya Vidhalaya, Khargone, Madhaya
              Padesh, 451001</option>
          </select></datalist>

      </div>
      <div class='w3-center w3-margin'>
        <input type="submit" class="w3-btn w3-blue  obs" value="Show Obstacles">
      </div>
    </form>
    <div class="loc" onclick="zoomToLoc()">
      <i class="material-icons marker">my_location</i>
    </div>

    <div class="navigate">
      <!-- naviate button -->

    </div>
  </div>
  <main class="containers">
    <div id="map" class="map"></div>

    <!-- <button class="w3-btn w3-blue" onclick="zoomToLoc()">Get Current Location</button> -->
    <!-- <button class="w3-btn w3-blue" onclick="startNavigation()">Start Navigation</button> -->
    <p id="info" class="info"></p>
  </main>
  <div class="modal">
    <!-- Place at bottom of page -->
  </div>



  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="script.js"></script>
  <script>
    $body = $("body");
    // Loading Animation
    $(document).on({
      ajaxStart: function () {
        $body.addClass("loading");
        $('.modal').html("<h1 class='waitInfo' align='center'><b>Fetching Obstacles, Wait For A While</b></h1>");
      },
      ajaxStop: function () {
        $body.removeClass("loading");
        $('.modal').html('');
      }
    });

    // Backend Call
    let obstLatLng; // Obstaacle Lat Lng
    var markersArray = []; // Store all markers
    $(".position").submit(function (e) {
      e.preventDefault();

      var frm = $(this);

      $('.render').empty();
      $.ajax({
        type: frm.attr('method'),
        url: frm.attr('action'),
        data: frm.serialize(),
        // success: function (data) {
        // 	console.log('recieved');
        // },
        // error: function(data) {
        //     console.log('Not recieved');
        // }
      }).done(function (data) {
        console.log(data);
        var locations = JSON.parse(data);
        obstLatLng = Object.keys(locations);
        console.log(obstLatLng);
        setObstacles(locations);

        $(".navigate").html("<button class='startNav'>Start</button>");
      });
    });

    // start navigation

    $('.navigate').on('click', '.startNav', function () {
      map.setZoom(3);
      //map.setCenter(marker.getPosition());// start location, change it 
      /*geocoder = new google.maps.Geocoder();


    //In this case it gets the address from an element on the page, but obviously you  could just pass it to the method instead
	
    geocoder.geocode( { 'address' : document.getElementById('start').value }, function( results, status ) {
        if( status == google.maps.GeocoderStatus.OK ) {
	
            //In this case it creates a marker, but you can get the lat and lng from the location.LatLng
            map.setCenter( results[0].geometry.location );
            console.log(results[0].geometry.location);
            startLoc=results[0].geometry.location;  
           
        } else {
            alert( 'Geocode was not successful for the following reason: ' + status );
        }
    } );*/
      map.setCenter(startLoc);
      console.log("Hello");
      sleep(1500).then(() => {
        smoothZoom(map, 18, map.getZoom());
        turnTheStyle();
        startNavigation();
        var msg = new SpeechSynthesisUtterance('Navigation for your selected route has started');
        window.speechSynthesis.speak(msg);


      });
      $(".navigate").html("<button class='endNav'>End</button>");
    });

    //End navigation
    $('.navigate').on('click', '.endNav', function () {
      $(".navigate").html("");
      map.setOptions({
        styles: []
      });
      removeMarkers();
    });
    //var polyline = require('polyline');
    function initMap() {
      var directionsService = new google.maps.DirectionsService;
      var directionsDisplay = new google.maps.DirectionsRenderer;
      map = new google.maps.Map(document.getElementById('map'), {
        zoom: 7,
        center: { lat: 21.85, lng: 75.65 }
      });
      directionsDisplay.setMap(map);

      var onChangeHandler = function () {
        calculateAndDisplayRoute(directionsService, directionsDisplay);
      };
      document.getElementById('start').addEventListener('change', onChangeHandler);
      document.getElementById('end').addEventListener('change', onChangeHandler);


      setObstacles = (locations) => {
        for (coords in locations) {

          const image = `${locations[coords]}.png`;
          console.log(image);
          console.log(locations[coords]);
          var marker = new google.maps.Marker({
            position: { lat: JSON.parse(coords)[0], lng: JSON.parse(coords)[1] },
            map,
            title: "Hello World!",
            icon: locations[coords] + '.png'
          });
          console.log(coords);
          //console.log("key = ", JSON.parse(property)[0] );
          //console.log(locs[property]);
          markersArray.push(marker);
        }
      }
      removeMarkers = () => {
        for (i = 0; i < markersArray.length; i++) {
          markersArray[i].setMap(null);
        }
        directionsDisplay.setMap(null);
      }

    }

    function calculateAndDisplayRoute(directionsService, directionsDisplay) {
      directionsService.route({
        origin: document.getElementById('start').value,
        destination: document.getElementById('end').value,
        travelMode: 'DRIVING'
      }, function (response, status) {
        if (status === 'OK') {
          directionsDisplay.setDirections(response);
          //var resJson=response;
          console.log(response);
          console.log(response.routes[0]['overview_polyline']);
          console.log('Start loc lat - ');
          // getCoordinates(response);
          // console.log(polyline.decode(`response.routes[0]['overview_polyline']`)); 
          console.log(response.routes[0]['legs'][0].start_location);
          startLoc = response.routes[0]['legs'][0].start_location;


        } else {
          window.alert('Directions request failed due to ' + status);
        }
      });
    }

  </script>
  <script>

    datalist = document.querySelector("datalist");
    select = document.querySelector("select");
    options = select.options;

    /* on arrow button click, show/hide the DDL*/
    button.addEventListener("click", toggle_ddl);

    function toggle_ddl() {
      if (datalist.style.display === "") {
        datalist.style.display = "block";
        this.textContent = "▲";
        /* If input already has a value, select that option from DDL */
        var val = input.value;
        for (var i = 0; i < options.length; i++) {
          if (options[i].text === val) {
            select.selectedIndex = i;
            break;
          }
        }
      } else hide_select();
    }

    /* when user selects an option from DDL, write it to text field */
    select.addEventListener("change", fill_input);

    function fill_input() {
      input.value = options[this.selectedIndex].value;
      hide_select();
    }

  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
    crossorigin="anonymous"></script>

  <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDXGxffUP02Ooi5lHGja4GaedxK2BM5svo&callback=initMap">
    </script>
</body>

</html>
