/// @description

//Exit if we do not interact with blocks!!!!
if interactwithblocksenabled=false or state=PlayerState.digging
	{
		exit;
	}
//Let's try get unstuck first
//A bit of code to get unstuck
//Let's make sure we're not stuck in a wall because that can happen
var counter=0;
var gravMultiplier=dsin(global.gravdirection)
if (place_meeting(x,y,obj_solid))
	{
		while (place_meeting(x,y+gravMultiplier,obj_solid) and counter<16)
			{
				y-=gravMultiplier
				counter+=1;
			}
		counter=0;
		while (place_meeting(x,y-gravMultiplier,obj_solid) and counter<16)
			{
				y+=gravMultiplier
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

if (place_meeting(x,y,obj_solid))
	{
		scr_play_sound(snd_pop,0,0);
		instance_create_layer(x,y,layer,obj_smoke);
		scr_spawn_Sage();
		state=PlayerState.dead;
		if (distance_to_object(global.currentinstance)<240)
			scr_set_vibration(1,1,15);
	}