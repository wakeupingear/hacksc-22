///Draw

var x1 = x;
var y1 = y;
var x2 = x + size*dcos(dir);
var y2 = y - size*dsin(dir);
var x3 = lerp(x1, x2, time*time);
var y3 = lerp(y1, y2, time*time);
var x4 = lerp(x1, x2, 1-(time-1)*(time-1));
var y4 = lerp(y1, y2, 1-(time-1)*(time-1));
draw_set_color(color);
draw_line_width(x3,y3,x4,y4,thickness);
draw_circle(x3,y3,thickness/2,false);
draw_circle(x4,y4,thickness/2,false);
draw_set_color(c_white);