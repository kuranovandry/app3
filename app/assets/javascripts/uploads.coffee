$(document).ready ->
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
