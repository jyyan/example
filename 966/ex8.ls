<- $ document .ready
data = [
  [\103/05 3.99] [\103/06 3.97] [\103/07 3.95] [\103/08 3.94]
  [\103/09 3.90] [\103/10 3.87] [\103/11 3.87] [\103/12 3.84]
  [\104/01 3.78] [\104/02 3.74] [\104/03 3.75] [\104/04 3.75]
]

d3.select "x3d scene" .selectAll \transform .data data .enter!append \transform

color = <[brown red orange yello green blue purple gray black]>
d3.select "x3d scene" .selectAll \transform .each (it, idx) -> 
  d3.select(@).attr do 
    translation: "#{idx/2 - 3} #{(it.1 - 3.7)*4} 0"
    scale: "0.1 #{(it.1 - 3.7) * 4} 0.1"
  shape = d3.select(@).append \shape
  shape.append \appearance .append \material .attr \diffuseColor, color[idx]
  shape.append \box

