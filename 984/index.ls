<- $(document).ready

[w,h] = [800,600]

data = [0 til 20]map (idx)->
  [x,y] = [Math.random!*w, Math.random!*h]
  rx = ry = 40
  charge = -100
  {x,y,idx,rx,ry,charge}

voronoi = d3.geom.voronoi!.clipExtent [[0,0], [w,h]] .x(->it.x) .y(->it.y)

recalc = ->
  polygons = voronoi(data)
  count = 40
  data.map((d,idx) -> 
    ext = d3.geom.polygon([0 til count].map(->[
      d.x + d.rx * Math.cos(3.14 * (360/count) * it / 180),
      d.y - d.ry * Math.sin(3.14 * (360/count) * it / 180)
    ]))
    if d.jump => 
      d.px = d.x + Math.random! * 100
      d.py = d.y + Math.random! * 100
      d.jump = 0
    d.polygon = if polygons[idx].length =>
      ext.clip(d3.geom.polygon(polygons[idx]))
    else []
  )
    
recalc!
svg = d3.select \svg
path = svg.selectAll \path.voronoi .data data .enter!append \path 
  ..attr \class, \voronoi
  ..on \mouseover -> it.jump = 1

render = ->
  recalc!
  path.data(data).attr do
    stroke: \#000
    "stroke-width": \1
    fill: "rgba(0,0,0,0.1)"
    d: -> if it.polygon.length => "M#{it.polygon.join(\L)}Z"
  force.alpha 0.9
force = d3.layout.force!size [w,h] .nodes data
force.charge -> if Math.random!<0.1 => -10 else it.charge
force.on \tick, render .start!
