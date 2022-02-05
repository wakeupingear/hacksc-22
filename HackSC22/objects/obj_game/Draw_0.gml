///Draw

//Draw score
var pointsStr = string(points);
while(string_length(pointsStr) < 4){
	pointsStr = "0" + pointsStr;
}
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_color(c_ltgray);
draw_set_font(fnt_bigText);
draw_text(room_width/2, 128, pointsStr);

//Draw selection overlay
if(swipeState == 2){
	draw_set_color(c_blue);
	for(var i = 0; i < ds_list_size(selectionXs); i++){
		if(i > 0){
			draw_line_width(gameToScreenX(selectionXs[| i-1])+64,
							gameToScreenY(selectionYs[| i-1])+64,
							gameToScreenX(selectionXs[| i])+64,
							gameToScreenY(selectionYs[| i])+64,
							10);
		}
		draw_circle(gameToScreenX(selectionXs[| i])+64,gameToScreenY(selectionYs[| i])+64, 16, false);
	}
	draw_set_color(c_white);
}

//Draw selected word
if(swipeState == 2){
	var selWord = string_upper(getSelectedWord());
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_set_color(c_white);
	draw_set_font(fnt_bigText);
	draw_text(room_width/2, room_height-128, selWord);
}