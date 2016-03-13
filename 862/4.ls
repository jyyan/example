<- $(document).ready

color = d3.scale.linear!domain [2 12] .range <[#090 #f00]>
tick = ->
  for n in nodes => 
    r = Math.sqrt((n.y - 200)**2 + (n.x - 400)**2)
    if r < 110 and r!=0 => 
      n.x += 1.1 * (n.x - 400) / r
      n.y += 1.1 * (n.y - 200) / r
    else if r > 140 and r!=0 => 
      n.x -= 1.1 * (n.x - 400) / r
      n.y -= 1.1 * (n.y - 200) / r
    /*if ( n.y - 200 )+ n.r >= 300 => 
      n.y = 300 - n.r
      n.vy = -1 * Math.abs(n.vy)
    n.vy = n.vy * 0.9*/
  circles.attr do
    cx: -> it.x
    cy: -> it.y
    r: -> it.r
    fill: -> color it.r
  force.alpha 0.01

nodes = [1 to 30].map -> do
  idx: it
  r: parseInt(Math.random!*10) + 2
  vy: 0
  ay: 0.3
force = d3.layout.force!size [800 400]  .charge(->-it.r * 30).alpha 0.01 
force.nodes(nodes) .on(\tick, tick) .start!
circles = d3.select \svg .selectAll \circle .data nodes .enter!append \circle
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
