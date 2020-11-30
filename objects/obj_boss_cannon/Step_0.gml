/// @description Insert description here
// You can write your code in this editor

event_inherited();

if destroyed=true and mysmoke=noone
	{
		scr_play_sound(snd_cannon_destroy,false,0);
		mysmoke=instance_create_layer(x,y,layer,obj_smoke_billowing);
		mysmoke.layer=layer;
		mysmoke.depth=depth-1;
	}
	
if mysmoke!=noone
	{
		mysmoke.x=x;
	}