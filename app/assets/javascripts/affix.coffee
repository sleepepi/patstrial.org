@affixReady = () ->
  affix_height = 50
  border_adjustment = 1
  $('[data-object~="navbar-affix"]').affix(
    offset:
      top: () -> $('.logo-header').outerHeight(true) + affix_height + border_adjustment
      bottom: 0
  )

$(document)
  .on('click', '[data-object~="remove-collapse-in"]', () ->
    $($(this).data('target')).removeClass('in')
  )
