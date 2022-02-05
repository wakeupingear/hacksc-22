///Create

gameX = -1;
gameY = -1;
letter = "a";


moveTo = function(nX, nY){
	gameX = nX;
	gameY = nY;
	x = gameToScreenX(gameX);
	y = gameToScreenY(gameY);
}