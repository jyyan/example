<- $(document).ready

rate = 50
color = d3.scale.linear!domain [2 12] .range <[#090 #f00]>
tick = ->
  for n in nodes => 
    n.vy += n.ay
    n.y2 += n.vy
    if n.y2 + n.r >= 300 => 
      n.y2 = 300 - n.r
      n.vy = -1 * Math.abs(n.vy)
      n.y = n.y2
    n.vy = n.vy * 0.95
  circles.attr do
    cx: -> it.x
    cy: -> it.y2
    r: -> it.r
    fill: -> color it.r
  force.alpha 0.01

nodes = [1 to 30].map -> do
  idx: it
  r: parseInt(Math.random!*10) + 2
  vy: 0
  ay: 1.2
  y2: Math.random!*300

force = d3.layout.force!size [800 400]  .charge(->-it.r * rate).alpha 0.01 
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
    n.x = n.px = Math.random!*400 + 200
    n.y2 = n.y = n.py = Math.random!*300 + 50
