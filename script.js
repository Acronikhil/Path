/**
 * Create google maps Map instance.
 * @param {number} lat
 * @param {number} lng
 * @return {Object}
 */
const createMap = ({ lat, lng }) => {
  return new google.maps.Map(document.getElementById('map'), {
    center: { lat, lng },
    zoom: 18,
  });
};

/**
 * Create google maps Marker instance.
 * @param {Object} map
 * @param {Object} position
 * @return {Object}
 */
const createMarker = ({ map, position }) => {
  return new google.maps.Marker({ 
          map,
          position,
          icon: 'arrow.png'
   });
};

/**
 * Track the user location.
 * @param {Object} onSuccess
 * @param {Object} [onError]
 * @return {number}
 */
const trackLocation = ({ onSuccess, onError = () => { } }) => {
  if ('geolocation' in navigator === false) {
    return onError(new Error('Geolocation is not supported by your browser.'));
  }

  return navigator.geolocation.watchPosition(onSuccess, onError, {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0
  });
};

/**
 * Get position error message from the given error code.
 * @param {number} code
 * @return {String}
 */
const getPositionErrorMessage = code => {
  switch (code) {
    case 1:
      return 'Permission denied.';
    case 2:
      return 'Position unavailable.';
    case 3:
      return 'Timeout reached.';
  }
}

/**
 * Initialize the application.
 * Automatically called by the google maps API once it's loaded.
*/
var obstNo=0; // keep track of next near obstacle
var obstMap={
	1:'speed breaker',
	2:'pothole',
	3:'blind spot',
	5:'hospital',
	6:'school',
	7:'trafic signal'
}
function startNavigation() {
  const initialPosition = startLoc;// start postion, change it
  //console.log('startLoc = ',startLoc);
  // const map = createMap(initialPosition);
  const markerNav =  createMarker({ map, position: initialPosition });
  const $info = document.getElementById('info');
  let watchId = trackLocation({
    onSuccess: ({ coords: { latitude: lat, longitude: lng } }) => {
      markerNav.setPosition({ lat, lng });
	  markersArray.push(markerNav);
	  //console.log('user location fetched = ',{ lat, lng });
      map.panTo({ lat, lng });
      $info.textContent = `Lat: ${lat.toFixed(5)} Lng: ${lng.toFixed(5)}`;
      $info.classList.remove('error');
	  console.log('lat and lng - ',lat, lng);
	  if(obstNo<obstLatLng.length){
		let dist=findObstDist(lat,lng);
	    console.log('distance = ',dist);
	    if(dist>0){
		  dist=Math.round((dist+Number.EPSILON)*100)/100;
		  console.log('onstNo - ',obstNo);
		  console.log('if condition');
		  var msg = new SpeechSynthesisUtterance(`There's a ${obstMap[obstNo]} ${dist} meters away Straight`);
		  window.speechSynthesis.speak(msg);
		  if(obstNo==3)
			obstNo+=2;
		  else obstNo+=1;
	    }
	  }
	  else{
		console.log('obstacles has been ended');
      }
	  
    },
    onError: err => {
      console.log($info);
      $info.textContent = `Error: ${err.message || getPositionErrorMessage(err.code)}`;
      $info.classList.add('error');
    }
  });
        // google.maps.event.addListener(marker, 'dblclick', function(event){
        //   // map = marker.getMap();    
        //   smoothZoom(map, 15, map.getZoom()); // call smoothZoom, parameters map, final zoomLevel, and starting zoom level
        // });

        // function rotate90() {
        //   const heading = map.getHeading() || 0;
        //   map.setHeading(heading + 180);
        // }
        
        // function autoRotate() {
        //   console.log("Func Rotate");
        //   // Determine if we're showing aerial imagery.
        //   if (map.getTilt() == 0) {
        //     console.log("Tile Rotate");
        //     window.setInterval(rotate90, 3000);
        //   }
        // }   
 }


 function findObstDist(lat,lng) {
		var rad = function(x) {
	  return x * Math.PI / 180;
	}
	console.log('obstcle - ', obstLatLng);
	lat2= JSON.parse(obstLatLng[obstNo])[0];
	lng2= JSON.parse(obstLatLng[obstNo])[1];
	//console.log(lat2,lng2);
	  var R = 6378137; // Earth’s mean radius in meter
	  var dLat = rad(lat2 - lat);
	  var dLong = rad(lng2 - lng);
	  var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
	    Math.cos(rad(lat)) * Math.cos(rad(lat2)) *
	    Math.sin(dLong / 2) * Math.sin(dLong / 2);
	  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	  var d = R * c;
	  return d; // returns the distance in meter
	
}
zoomToLoc = () => {
		  let infoWindow = new google.maps.InfoWindow();

			 
			    if (navigator.geolocation) {
			      navigator.geolocation.getCurrentPosition(
			        (position) => {
			          const pos = {
			            lat: position.coords.latitude,
			            lng: position.coords.longitude,
			          };
			          infoWindow.setPosition(pos);
			          infoWindow.setContent("Your Device's Location.");
			          infoWindow.open(map);
			          map.setCenter(pos);
			        },
			        () => {
			          handleLocationError(true, infoWindow, map.getCenter());
			        }
			      );
			    } else {
			      // Browser doesn't support Geolocation
			      handleLocationError(false, infoWindow, map.getCenter());
			    }
			  
			
			
			function handleLocationError(browserHasGeolocation, infoWindow, pos) {
			  infoWindow.setPosition(pos);
			  infoWindow.setContent(
			    browserHasGeolocation
			      ? "Error: The Geolocation service failed."
			      : "Error: Your browser doesn't support geolocation."
			  );
			  infoWindow.open(map);
			}

			  map.setZoom(5);
			  //map.setCenter(marker.getPosition());//user current position, change it
			  console.log("Hello");
			  sleep(1500).then(() => { 
			  smoothZoom(map, 18, map.getZoom()); 
			  // turnTheStyle();
			  // autoRotate();  
			   }); 
			}

        function sleep(ms) {
          return new Promise(resolve => setTimeout(resolve, ms));
        }

        turnTheStyle = () => {
          map.setOptions({
             styles: [
            { elementType: "geometry", stylers: [{ color: "#242f3e" }] },
            { elementType: "labels.text.stroke", stylers: [{ color: "#242f3e" }] },
            { elementType: "labels.text.fill", stylers: [{ color: "#746855" }] },
            {
              featureType: "administrative.locality",
              elementType: "labels.text.fill",
              stylers: [{ color: "#d59563" }],
            },
            {
              featureType: "poi",
              elementType: "labels.text.fill",
              stylers: [{ color: "#d59563" }],
            },
            {
              featureType: "poi.park",
              elementType: "geometry",
              stylers: [{ color: "#263c3f" }],
            },
            {
              featureType: "poi.park",
              elementType: "labels.text.fill",
              stylers: [{ color: "#6b9a76" }],
            },
            {
              featureType: "road",
              elementType: "geometry",
              stylers: [{ color: "#38414e" }],
            },
            {
              featureType: "road",
              elementType: "geometry.stroke",
              stylers: [{ color: "#212a37" }],
            },
            {
              featureType: "road",
              elementType: "labels.text.fill",
              stylers: [{ color: "#9ca5b3" }],
            },
            {
              featureType: "road.highway",
              elementType: "geometry",
              stylers: [{ color: "#746855" }],
            },
            {
              featureType: "road.highway",
              elementType: "geometry.stroke",
              stylers: [{ color: "#1f2835" }],
            },
            {
              featureType: "road.highway",
              elementType: "labels.text.fill",
              stylers: [{ color: "#f3d19c" }],
            },
            {
              featureType: "transit",
              elementType: "geometry",
              stylers: [{ color: "#2f3948" }],
            },
            {
              featureType: "transit.station",
              elementType: "labels.text.fill",
              stylers: [{ color: "#d59563" }],
            },
            {
              featureType: "water",
              elementType: "geometry",
              stylers: [{ color: "#17263c" }],
            },
            {
              featureType: "water",
              elementType: "labels.text.fill",
              stylers: [{ color: "#515c6d" }],
            },
            {
              featureType: "water",
              elementType: "labels.text.stroke",
              stylers: [{ color: "#17263c" }],
            },
          ],
          });
        }
// the smooth zoom function
function smoothZoom (map, max, cnt) {
    if (cnt >= max) {
      
        return;
    }
    else {
        z = map.addListener('zoom_changed', function(event){
            // map.removeListener(z);
            google.maps.event.removeListener(z);
            smoothZoom(map, max, cnt + 1);
        });
        setTimeout(function(){map.setZoom(cnt)}, 100); // 80ms is what I found to work well on my system -- it might not work well on all systems
    }
}  
