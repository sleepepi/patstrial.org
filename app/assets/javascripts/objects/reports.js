"use strict";

function reportRowsSort() {
  $("[data-object~=report-rows-sortable]").each(function() {
    var $this = $(this);
    $this.sortable({
      axis: "y"
    });
  });
}

$(document)
  .on("click", "[data-object~=remove-report-row]", function() {
    $(this).closest("[data-object~=report-row]").remove();
    return false;
  });
