<- $(document).ready

rate = 0.01
color = d3.scale.linear!domain [2 12] .range <[#090 #f00]>
tick = ->
  for n in nodes => 
    [mv,mx,my] = [1000000, 0, 0]
    for dx from -1 to 1
      for dy from -1 to 1
        nx = rate * dx + n.x
        ny = rate * dy + n.y
        if nx > 590 => nx = 590
        if nx < 210 => nx = 210
        if ny < 150 =>
          v = -Math.sqrt(1 - (Math.abs((nx - 400)/100) - 1)**2) * 50 + 150
        else
          v = 3 * Math.sqrt(1 - (Math.sqrt(Math.abs((nx - 400)/100)/2))) * 50 + 150
        v = Math.abs(ny - v)
        if v < mv => [mv,mx,my] = [v,nx,ny]
    [n.x, n.y] = [mx, my]
    if rate < 0.5 => rate *= 1.0005
  circles.attr do
    cx: -> 
      it.x
    cy: -> it.y
    r: -> it.r
    fill: -> color it.r
  force.alpha 0.01

nodes = [1 to 60].map -> do
  idx: it
  r: parseInt(Math.random!*10) + 2
  vy: 0
  ay: 0.3
  x: Math.random! * 400 + 200
  y: Math.random! * 300 + 50
force = d3.layout.force!size [800 400]  .charge(->-it.r * 20).alpha 0.01 
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
    n.x = n.px = Math.random!* 400 + 200
    n.y = n.py = Math.random!* 300 + 50
  rate := 0.01
