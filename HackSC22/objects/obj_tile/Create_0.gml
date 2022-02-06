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
	
	//make the lines
	for(var i = 0; i < 360; i+=45){
		var l = instance_create_layer(x+obj_game.tileSize/2, y+obj_game.tileSize/2, "Particles", obj_actionLine);
		l.dir = i;
		l.x += 20*dcos(i);
		l.y -= 20*dsin(i);
	}
}