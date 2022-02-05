///Create

tileSize = 128;
xOffset = 128;
yOffset = 256;


for(var xx = 0; xx < 4; xx++){
	for(var yy = 0; yy < 4; yy++){
		board[xx][yy] = instance_create_layer(0, 0, "Tiles", obj_tile);
		board[xx][yy].moveTo(xx, yy);
	}
}



