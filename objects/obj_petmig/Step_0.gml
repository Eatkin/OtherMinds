/// @description
// Inherit the parent event
event_inherited();

x=owner.x-sprite_width*0.5;
y=owner.y-sprite_height*0.5;

if active=true
	{
		user=instance_nearest(x,y,parent_main_character);
		//Let's make sure Mig is in idle state for this to work
		var exitstate=false;
		if owner.state!=PlayerState.idle
			{
				exitstate=true;
			}
		//Also make sure that the user is not going to get stuck in a block or be placed above a cliff
		var Edx=user.x;
		var Migx=owner.x;
		//Ed lerps to Mig.x+sign(Ed.x-Mig.x)*17
		var Edtargetx=Migx+scr_sign_nonzero(Edx-Migx)*11;
		with (user)
			{
				if place_meeting(Edtargetx,y,obj_solid)
					{
						exitstate=true;
					}
				if !place_meeting(Edtargetx,y+1,obj_solid) and !place_meeting(Edtargetx,y+1,obj_semisolid)
					{
						exitstate=true;
					}
			}
		
		if exitstate=true
			{
				active=false;
				scr_play_sound(snd_menu_no,0,0);
				exit;
			}
		user.state=PlayerState.petcat;
		owner.state=PlayerState.petcat;
		active=2;
	}