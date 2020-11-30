/// @description zip

//Let's try get unstuck first
//A bit of code to get unstuck
//Let's make sure we're not stuck in a wall because that can happen
var counter=0;

if place_meeting(x,y,obj_solid)
	{
		while (place_meeting(x,y+1,obj_solid) and counter<16)
			{
				y-=1;
				counter+=1;
			}
		counter=0;
		while (place_meeting(x,y-1,obj_solid) and counter<16)
			{
				y+=1;
				counter+=1;
			}
		counter=0;
		while (place_meeting(x-1,y,obj_solid) and counter<16)
			{
				x+=1;
				counter+=1;
			}
		counter=0;
		while (place_meeting(x+1,y,obj_solid) and counter<16)
			{
				x-=1;
				counter+=1;
			}
	}
	
if place_meeting(x,y,obj_solid) and state!=PlayerState.dead
	{
		scr_play_sound(snd_pop,0,0);
		instance_create_layer(x,y,layer,obj_smoke);
		state=PlayerState.dead;
		visible=false;
		if distance_to_object(global.currentinstance)<240
			{
				scr_set_vibration(1,1,15);
			}
	}