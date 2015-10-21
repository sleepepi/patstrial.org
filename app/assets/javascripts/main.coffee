@ready = () ->
  Turbolinks.enableProgressBar()
  fileDragReady()

$(document).ready(ready)
$(document)
  .on('page:load', ready)
