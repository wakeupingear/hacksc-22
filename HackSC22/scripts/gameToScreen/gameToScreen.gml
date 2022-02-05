// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function screenToGameX(x_){
	return floor((x_ - obj_game.xOffset)/obj_game.tileSize);
}

function screenToGameY(y_){
	return floor((y_ - obj_game.yOffset)/obj_game.tileSize);
}

function gameToScreenX(x_){
	return x_*obj_game.tileSize + obj_game.xOffset;
}

function gameToScreenY(y_){
	return y_*obj_game.tileSize + obj_game.yOffset;
}

function dirX(dir_){
	switch(dir_%4){
	case(0): return 1;
	case(2): return -1;
	default: return 0;
	}
}

function dirY(dir_){
	switch(dir_%4){
	case(1): return -1;
	case(3): return 1;
	default: return 0;
	}
}