@ready = ->
  fileDragReady()
  chartsReady()
  lettersReady()

$(document).ready(ready)
$(document)
  .on('turbolinks:load', ready)
  .on('click', '[data-object~="suppress-click"]', -> false)
