///Create

gameX = -1;
gameY = -1;
letter = obj_game.getRandomLetter();

scale = 0;
dying = false;


moveTo = function(nX, nY){
	gameX = nX;
	gameY = nY;
}

die = function(){
	dying = true;
}