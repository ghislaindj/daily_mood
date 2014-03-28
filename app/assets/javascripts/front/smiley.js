var smiley = function(selector, mood_value){
    var transition_time = 3000;
    var delay = 300;
    var mood_value
    var path = {
        bad: "M30,70 a 50 100 0 0 1 40,0",
        normal_bad: "M30,70 a 50 1 0 0 1 40,0",
        normal_good: "M30,70 a 50 1 0 0 0 40,0",
        good: "M30,70 a 50 100 0 0 0 40,0"
    };
    var to_path = ((mood_value > 0 ) ? path.good : path.bad);
    var from_path = ((mood_value > 0 ) ? path.normal_good : path.normal_bad);
    var color = d3.scale.linear()
        .domain([-1, 0, 1])
        .range(["#d9534f", "white", "#5cb85c"]);
    
    var s = d3.select(selector);
    
    var face = s.append("circle")
        .attr("cy", 50)
        .attr("cx", 50)
        .attr("r", 46)
        .style("stroke-width", 6)
        .style("stroke", "black" )
        .attr("fill", "none");
    
    var eye_1 = s.append("circle")
        .attr("cy", 35)
        .attr("cx", 35)
        .attr("r", 8)
        .attr("fill", "black");
    
    var eye_1 = s.append("circle")
        .attr("cy", 35)
        .attr("cx", 65)
        .attr("r", 8)
        .attr("fill", "black");
    
    var smile = s.append("svg:path")
                .attr("d", from_path)
                .style("stroke-width", 4)
                .style("stroke", "black")
                .style("fill", "none");
    
    smile.transition()
        .duration(transition_time) 
        .delay(delay)
        .ease("linear")
        .attrTween("d", function () { 
          return d3.interpolate(from_path, to_path); 
      });
    face.transition()
        .duration(transition_time) 
        .delay(delay)
        .attrTween("fill", function () { 
          return d3.interpolate("white", color(mood_value)); 
      });
    
    setTimeout(function(){
        smile.transition()
             .duration(0);
        face.transition()
             .duration(0);
     },Math.abs(transition_time*mood_value)+delay);
};