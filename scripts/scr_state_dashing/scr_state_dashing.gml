//Created 12/12/19
//Last updated 12/12/19

//Firstly halt v momentum because i'll forget otherwise
yspeed=0;
xspeed=dashspeed*directionfacing;
candash=false;

if sprite_index!=sprite_dash
	{
		sprite_index=sprite_dash;
		var smoke=instance_create_layer(x-abs(sprite_width)*0.25*directionfacing,y,layer,obj_smokering);
		smoke.image_xscale=-directionfacing;
		scr_play_sound(sound_dash,0,0);
	}

//Movement - I think this actually clamps the speed
scr_xmove_loop(0);

if timeinstate>dashtimer
	{
		if !place_meeting(x,y+1,obj_solid) and !place_meeting(x,y+1,obj_semisolid)
			{
				state=PlayerState.air;
			}
		else
			{
				state=PlayerState.idle;
			}
		xspeed=0;
		dashcooldown=15;
		exit;
	}