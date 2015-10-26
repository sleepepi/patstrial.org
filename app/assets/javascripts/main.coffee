@ready = () ->
  Turbolinks.enableProgressBar()
  fileDragReady()
  affixReady()

$(document).ready(ready)
$(document)
  .on('page:load', ready)
