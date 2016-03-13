<- $(document).ready

color = d3.scale.linear!domain [2 12] .range <[#090 #f00]>
tick = ->
  circles.attr do
    cx: -> 
      it.x
    cy: -> it.y
    r: -> it.r
    fill: -> color it.r

nodes = [1 to 50].map -> do
  idx: it
  r: parseInt(Math.random!*10) + 2
force = d3.layout.force!size [800 400]  .charge(->-it.r * 5)
force.nodes(nodes).on \tick tick .start!

circles = d3.select \svg .selectAll \circle .data nodes .enter!append \circle
for n in nodes =>
  n.x = n.px = Math.random!* 400 + 200
  n.y = n.py = Math.random!* 300 + 50
tick!
force.stop!

window.reset = ->
  force.start!
  for n in nodes =>
    n.x = n.px = Math.random! * 400 + 200
    n.y = n.py = Math.random! * 300 + 50
  force.alpha 1
