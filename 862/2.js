$(document).ready(function(){var r,n,t,e,a,o,c,u;for(r=d3.scale.linear().domain([2,12]).range(["#090","#f00"]),n=function(){return a.attr({cx:function(r){return r.x},cy:function(r){return r.y},r:function(r){return r.r},fill:function(n){return r(n.r)}})},t=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50].map(function(r){return{idx:r,r:parseInt(10*Math.random())+2}}),e=d3.layout.force().size([800,400]).charge(function(r){return 5*-r.r}),e.nodes(t).on("tick",n).start(),a=d3.select("svg").selectAll("circle").data(t).enter().append("circle"),o=0,c=t.length;c>o;++o)u=t[o],u.x=u.px=400*Math.random()+200,u.y=u.py=300*Math.random()+50;return n(),e.stop(),window.reset=function(){var r,n,a,o;for(e.start(),r=0,a=(n=t).length;a>r;++r)o=n[r],o.x=o.px=400*Math.random()+200,o.y=o.py=300*Math.random()+50;return e.alpha(1)}});