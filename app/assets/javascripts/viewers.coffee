$(document)
  .on('click', "[data-object~='click-to-view']", () ->
    $(this).html($(this).data('content'))
    $(this).removeClass('masked')
  )
