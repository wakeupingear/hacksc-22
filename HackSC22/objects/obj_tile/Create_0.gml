///Create

gameX = -1;
gameY = -1;
letter = obj_game.getRandomLetter();


moveTo = function(nX, nY){
	gameX = nX;
	gameY = nY;
	x = gameToScreenX(gameX);
	y = gameToScreenY(gameY);
}

die = function(){
	instance_destroy();
}