$(document).keyup(function(event) {
  if (
    event.keyCode == 13 &&
    (
      $("#command").is(":focus")
    )
  ) {
    $("#run").click();
  }
});
