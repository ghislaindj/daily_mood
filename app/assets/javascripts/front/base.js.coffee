# Base JS file for Front

unless Modernizr.svg
  $("img[src*=\"svg\"]").attr "src", ->
    $(this).attr("src").replace ".svg", ".png"