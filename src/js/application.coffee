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
  map = new GMaps
    el: '#map'
    lat: 55.049123
    lng: 73.261420
    zoom: 16
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

  map.addMarker
    lat: 55.0494894
    lng: 73.2628688
    title: 'Омская Областная Федерация Кендо'
    infoWindow:
      content: '<p><strong>Омская Областная Федерация Кендо</strong><br/>ул. Заводская, д.1</p>'
    icon:
      url: 'images/map-marker.png'
      size: new google.maps.Size(22, 40)
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(11, 40)
