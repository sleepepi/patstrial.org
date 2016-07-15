$(document)
  .on('mouseenter', '.col-hover', ->
    $('.col-hover').removeClass('active')
    $($(this).data('target')).addClass('active')
  )
  .on('mouseleave', '.col-hover', ->
    $('.col-hover').removeClass('active')
  )
