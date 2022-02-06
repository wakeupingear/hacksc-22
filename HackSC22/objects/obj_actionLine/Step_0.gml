/// @description Insert description here
// You can write your code in this editor
time = clamp(time + spd, 0, 1);
if(time == 1){
	instance_destroy();
}