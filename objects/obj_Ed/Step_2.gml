/// @description get smushed by blocks

if state=PlayerState.ledgeclimb or state=PlayerState.debug or state=PlayerState.dead
	{
		exit;
	}

event_inherited();

/*
if place_meeting(x,y,obj_solid) and state!=PlayerState.dead and state!=PlayerState.debug and state!=PlayerState.ledgeclimb
	{
		scr_play_sound(snd_pop,0,0);
		instance_create_layer(x,y,layer,obj_smoke);
		visible=false;
		state=PlayerState.dead;
		if distance_to_object(global.currentinstance)<240
			{
				scr_set_vibration(1,1,15);
			}
	}*/
	
image_xscale=image_xscale*(1+global.fatmode*5);