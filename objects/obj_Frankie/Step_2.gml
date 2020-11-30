/// @description get smushed by blocks

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

if place_meeting(x,y,obj_solid)
	{
		scr_play_sound(snd_pop,0,0);
		instance_create_layer(x,y,layer,obj_smoke);
		scr_spawn_Sage();
		state=PlayerState.dead;
	}