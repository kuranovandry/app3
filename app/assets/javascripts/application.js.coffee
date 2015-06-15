# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require jquery-ui
#= require jquery.fileupload
#= require jquery.iframe-transport
#= require masonry/jquery.masonry
#= require tinymce
#= require jsapi
#= require chartkick
#= require underscore
#= require gmaps/google

@App3 = {
  init: (a) ->
    @moviesMap() if a.map
    @movieEdit() if a.movieEdit
    @datePicker() if a.datePicker
    @moviesImages() if a.moviesImages
    @registrationPopup() if a.registrationPopup
    @uploadsGallery() if a.uploadsGallery
    return

  moviesMap: ->
    handler = Gmaps.build("Google")
    handler.buildMap
      provider: {maxZoom: 7}
      internal:
        id: "map"
    , ->
      markers = $('#map').data('markers')
      markers = handler.addMarkers markers
      handler.bounds.extendWith markers
      handler.fitMapToBounds()
  movieEdit: ->
    tinyMCE.init selector: 'textarea.tinymce'

    $(document).on 'click', 'form .remove_fields', (event) ->
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('fieldset').remove()
      event.preventDefault()

    $(document).on 'click', 'form .add_fields', (event) ->
      time = new Date().getTime()
      regexp = new RegExp($(this).data('id'), 'g')
      $(this).before($(this).data('fields').replace(regexp, time))
      event.preventDefault()

  datePicker: ->
    $('.datepicker').datepicker
      format: 'mm.dd.yyyy'

  moviesImages: ->
    $('#movies_gallery').imagesLoaded ->
      $('#movies_gallery').masonry
        itemSelector: '.box'
        isFitWidth: true

  registrationPopup: ->
    popupCenter = (url, width, height, name) ->
      left = screen.width / 2 - (width / 2)
      top = screen.height / 2 - (height / 2)
      popupValue = 'on'
      window.open url, name, 'menubar=no, toolbar=no, status=no, width=' + width + ', height=' + height + ', toolbar=no, left=' + left + ', top=' + top


    $('.popup').click (e) ->
      popupCenter $(this).attr('href'), $(this).attr('data-width'), $(this).attr('data-height'), 'authPopup'
      e.stopPropagation()
      false

    if window.opener and window.opener.popupValue == 'on'
      delete window.opener.popupValue
      window.opener.location.reload true
      window.close()
    return

  uploadsGallery: ->
    window.reIntializeMasonry = (reinitial) ->
      setTimeout (->
        $container = $('#container')
        if reinitial
          $container.masonry('destroy')
        # initialize
        $container.masonry
          itemSelector: '.item'
      ), 100

    window.reIntializeMasonry()

    $('#fileupload').fileupload
      dataType: 'json'
      done: (e, data) ->
        file = data.result
        $("<div class='item col-md-3'><img class=\"img-responsive\" src='#{file}' /></div>").prependTo $('#container')
        window.reIntializeMasonry(true)
      fail: (e, data) ->
        $('#container').prepend($("<div></div>").text('File is not uploaded.'));

    $(window).scroll ->
      url = $('.pagination .next a').prop('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $.getScript(url)
}
