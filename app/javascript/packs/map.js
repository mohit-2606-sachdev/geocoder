function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 8,
      center: { lat: -33.8688, lng: 151.2093 }
    });
  
    var marker = new google.maps.Marker({
      position: { lat: -33.8688, lng: 151.2093 },
      map: map,
      title: 'My Location'
    });
  }