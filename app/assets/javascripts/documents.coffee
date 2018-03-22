$(document)
  .on("dragenter", "[data-object~=dropfile]", (e) ->
    $(this).addClass("hover")
    e.stopPropagation()
    e.preventDefault()
  )
  .on("dragleave", "[data-object~=dropfile]", (e) ->
    $(this).removeClass("hover")
    e.stopPropagation()
    e.preventDefault()
  )
  .on("dragover", "[data-object~=dropfile]", (e) ->
    e.stopPropagation()
    e.preventDefault()
  )
  .on("drop", "[data-object~=dropfile]", (e) ->
    $(this).removeClass("hover")
    e.stopPropagation()
    e.preventDefault()

    event = e.originalEvent || e
    data = new FormData()
    $.each(event.dataTransfer.files, (index, file) ->
      data.append "documents[]", file
    )

    file_count = event.dataTransfer.files.length

    if file_count == 1
      plural = ""
    else
      plural = "s"

    $(this).html("Uploading #{file_count} file#{plural}...")
    $this = $(this)
    $.ajax(
      url: $this.data("upload-url")
      type: "POST"
      data: data         # The form with the file inputs.
      processData: false # Using FormData, no need to process data.
      contentType: false
    ).done( ->
      console.log("Success: Documents uploaded!")
    ).fail( ->
      url = $this.data("fallback-url")
      $this.html("<div>An error occurred, the documents could not be uploaded!<br /><br />Please try again or <a href=\"#{url}\">upload the documents</a> manually.</div>")
    )
  )
