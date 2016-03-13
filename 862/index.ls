<- $(document).ready

tick = ->
  circles.attr do
    cx: -> 
      it.x
    cy: -> it.y
    r: 5

nodes = [1 to 100].map(->{idx: it})
force = d3.layout.force!size [800 600] 
force.nodes(nodes).on \tick tick .start!

circles = d3.select \svg .selectAll \circle .data nodes .enter!append \circle
