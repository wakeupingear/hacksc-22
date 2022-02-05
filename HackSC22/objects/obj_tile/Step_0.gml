///Step

x = lerp(x,gameToScreenX(gameX),0.2);
y = lerp(y,gameToScreenY(gameY),0.2);

if(dying){
	scale = lerp(scale, 0, 0.2);
	if(scale < 0.05){
		instance_destroy();
	}
}else{
	scale = lerp(scale, 1, 0.2);
}