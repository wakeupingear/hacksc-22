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
draw_text(room_width/2, 64, pointsStr);

//make dots smaller
for(var xx = 0; xx < gameSize; xx++){
	for(var yy = 0; yy < gameSize; yy++){
		selectionDots[xx][yy] = clamp(selectionDots[xx][yy]-0.1, 0, 1);
	}
}

//Make selected dots larger and draw lines
draw_set_color(make_color_rgb(68,140,203));
if(swipeState == 2){
	for(var i = 0; i < ds_list_size(selectionXs); i++){
		if(i > 0){
			draw_line_width(gameToScreenX(selectionXs[| i-1])+64,
							gameToScreenY(selectionYs[| i-1])+64,
							gameToScreenX(selectionXs[| i])+64,
							gameToScreenY(selectionYs[| i])+64,
							10);
		}
		selectionDots[selectionXs[| i]][selectionYs[| i]] = clamp(selectionDots[selectionXs[| i]][selectionYs[| i]] + 0.2, 0, 1);
	}
}

//draw dots
for(var xx = 0; xx < gameSize; xx++){
	for(var yy = 0; yy < gameSize; yy++){
		if(selectionDots[xx][yy] > 0.05){
			draw_circle(gameToScreenX(xx)+tileSize/2,gameToScreenY(yy)+tileSize/2, 16*selectionDots[xx][yy], false);
		}
	}
}
draw_set_color(c_white);


//Draw selected word
var drawWord = false;
var wordColor = c_white;
var wordXOffset = 0;
var wordYOffset = 0;
var wordAlpha = 1;
if(swipeState == 2){
	drawWord = true;
}else if(wordDisplayState == 1 && wordDisplayTimer < 30){
	drawWord = true;
	wordColor = c_green;
	wordAlpha = 1-clamp(wordDisplayTimer/30, 0, 1);
	wordYOffset = -wordDisplayTimer;
}else if(wordDisplayState == 2 && wordDisplayTimer < 30){
	drawWord = true;
	wordAlpha = 1-clamp(wordDisplayTimer/30, 0, 1);
	wordColor = c_yellow;
}else if(wordDisplayState == 3 && wordDisplayTimer < 30){
	drawWord = true;
	wordColor = c_red;
	wordXOffset = random_range(-5, 5);
	wordYOffset = random_range(-5, 5);
}
if(drawWord){
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_set_color(wordColor);
	draw_set_font(fnt_bigText);
	draw_set_alpha(wordAlpha);
	draw_text(room_width/2 + wordXOffset, room_height-64 + wordYOffset, displayWord);
	draw_set_color(c_white);
	draw_set_alpha(1);
}
