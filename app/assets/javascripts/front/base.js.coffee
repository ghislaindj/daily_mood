# Base JS file for Front

unless Modernizr.svg
  $("img[src*=\"svg\"]").attr "src", ->
    $(this).attr("src").replace ".svg", ".png"

@graph_color = d3.scale.linear().domain([-1,0,1]).range(["#d9534f","#b3d4fc","#5cb85c"])