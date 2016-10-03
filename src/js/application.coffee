window.isMobile = ->
  /(mobile|phone|tablet|android|ipad|ipod|symbian)/i.test(navigator.userAgent)

jQuery ->
  $('.js-year').text new Date().getFullYear()

  # Smooth scrolling
  $('a[href^=#]').click (e) ->
    e.preventDefault()

    href = $(this).attr('href')
    scrollTo = if href == '#' then 0 else $(href).offset().top

    $('html,body').animate { scrollTop: scrollTo },
      duration: 800


  # Fixed header
  unless isMobile()
    $jsFixed = $('.js-fixed')

    $(window).scroll ->
      $jsFixed.css
        top: window.scrollY


  # Hide video for mobile devices
  unless isMobile()
    $('.js-home-video').show()


  # Map in contacts
  lat = 55.0033046
  lng = 73.3585915

  map = new google.maps.Map $("#map").get(0),
    zoom: 16
    mapTypeId: google.maps.MapTypeId.ROADMAP
    center: new google.maps.LatLng(lat, lng)
    scrollwheel: false
    zoomControl : false
    panControl : false
    streetViewControl : false
    mapTypeControl: false
    overviewMapControl: false
    styles: [
      { 'featureType': 'all', 'stylers': [{ 'saturation': -100 }, { 'gamma': 0.5 }] },
      { 'featureType': 'poi', 'elementType': 'labels', 'stylers': [{ 'visibility': 'off' }]}
    ]

  marker = new google.maps.Marker
    title: 'Омская Областная Федерация Кендо'
    position: new google.maps.LatLng(lat, lng)
    map: map
    draggable: false
    icon:
      url: 'images/map-marker.png'
      size: new google.maps.Size(22, 40)
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(11, 40)

  infowindow = new google.maps.InfoWindow
    content: '<p><strong>Омская Областная Федерация Кендо</strong><br/>ул. 5 Армии, 12</p>'

  google.maps.event.addListener marker, 'click', () ->
    infowindow.open map,marker
