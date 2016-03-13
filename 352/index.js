d3.json("world.json", function(world) {

var projection = d3.geo.orthographic().scale(245).translate([400,300]).clipAngle(90);
var path = d3.geo.path().projection(projection);
var countries = topojson.feature(world, world.objects.countries).features;
var color = d3.scale.category20();
console.log(countries);

var polygon = d3.select("#svg").selectAll("path").data(countries)
  .enter().append("path").attr({"d":path,"fill":function(d){return color(d.id);}});

d3.select("#svg").call(d3.behavior.drag()
    .origin(function() {
      r = projection.rotate();
      return {x: r[0], y: -r[1]};
    })
    .on("drag", function() {
    rotate = projection.rotate();
    projection.rotate([d3.event.x, -d3.event.y, rotate[2]]);
    d3.select("#svg").selectAll("path").attr("d", path);
  }));

});

