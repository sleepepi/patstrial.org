$(document)
  .on('click', '[data-object~=scroll-anchor]', (event) ->
    # Make sure this.hash has a value before overriding default behavior
    if @hash != '' and $(@hash).length > 0
      # Prevent default anchor click behavior
      event.preventDefault()
      # Store hash
      hash = @hash
      $('html, body').animate { scrollTop: $(hash).offset().top }, 700
  )
