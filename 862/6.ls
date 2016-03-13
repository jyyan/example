<- $(document).ready

color = d3.scale.linear!domain [2 12] .range <[#090 #f00]>
tick = ->
  spline.update nodes, links
  circles.attr do
    cx: -> it.x
    cy: -> it.y
    r: -> it.r
    fill: -> color it.r
  paths.attr do
    d: -> it.d
    fill: \none
    stroke: \#444
  force.alpha 0.01

nodes = [0 til 60].map -> do
  idx: it
  r: parseInt(Math.random!*10) + 2
  x: Math.random! * 400 + 200
  y: Math.random! * 300 + 50
links = [0 til 59].map -> {source: nodes[it], target: nodes[it + 1]}
force = d3.layout.force!size [800 400]  .charge(->-it.r * 10).alpha 0.01  .gravity 0.1
force.nodes(nodes) .links(links) .on \tick tick .start!

circles = d3.select \svg .selectAll \circle .data nodes .enter!append \circle
paths = d3.select \svg .selectAll \path .data links .enter!append \path .each -> it.node = @
for n in nodes =>
  n.x = n.px = Math.random!* 400 + 200
  n.y = n.py = Math.random!* 300 + 50
tick!
force.stop!

window.reset = ->
  force.start!
  for n in nodes =>
    n.x = n.px = Math.random!* 400 + 200
    n.y = n.py = Math.random!* 300 + 50
