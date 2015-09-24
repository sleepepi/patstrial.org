@ready = () ->
  Turbolinks.enableProgressBar()

$(document).ready(ready)
$(document)
  .on('page:load', ready)
