//Created 21/12/19
//Last updated 12/02/20

//We can use instance_exists to make this work for multiple cats or whatever
//Okay I'm doing that now, pick the correct cat
var cat, offset, sprpet, sprbeingpetted, pettingobj;
if (instance_exists(obj_petmig) and obj_petmig.active>0)
	{
		cat=obj_Mig;
		offset=11;
		sprpet=spr_Ed_petmig;
		sprbeingpetted=spr_Mig_petting;
		pettingobj=obj_petmig;
	}
if (instance_exists(obj_petsim) and obj_petsim.active>0)
	{
		cat=obj_Sim;
		offset=8;
		sprpet=spr_Ed_petsim;
		sprbeingpetted=spr_Sim_petted;
		pettingobj=obj_petsim;
	}
if (instance_exists(obj_petfrankie) and obj_petfrankie.active>0)
	{
		cat=obj_Frankie;
		offset=12;
		sprpet=spr_Ed_petfrankie;
		sprbeingpetted=spr_frankie_petted;
		pettingobj=obj_petfrankie;
	}
if (instance_exists(obj_petcyberpup) and obj_petcyberpup.active>0)
	{
		cat=obj_cyberpup;
		offset=10;
		sprpet=spr_Ed_petcyberpup;
		sprbeingpetted=spr_cyberpupwaiting;
		pettingobj=obj_petcyberpup;
	}
	
var catx=cat.x;
var Ed=instance_nearest(x,y,parent_main_character)
var Edx=Ed.x;
var signofpos=scr_sign_nonzero(Edx-catx); //Ed is to the right if this is positive, to the left otherwise

if (object_get_parent(object_index)==parent_main_character)
	{
		xspeed=0;
		//Lerp to the target position
		var xpet=catx+signofpos*offset;
		x=lerp(x,xpet,0.2);
		directionfacing=-signofpos;
		if sprite_index!=sprpet
			{
				sprite_index=sprpet
				image_index=0;
			}
		else
			{
				if image_index>=image_number-0.5
					{
						state=PlayerState.idle;
						//This is a fuckin hot mess, I don't know what order cats or Ed are entering and exiting state
						//So I just make sure it adds one to the active counter and when they've both added one, it sets its activation status to false
						pettingobj.active+=1;
						if (pettingobj.active==4)
							{
								pettingobj.active=0;
							}
					}
			}
	}
else
	{
		outlineshader=false;
		directionfacing=signofpos;
		if sprite_index!=sprbeingpetted
			{
				if (object_index!=obj_cyberpup)
					{
						scr_play_sound(snd_kitty_purr,false,0);
					}
				sprite_index=sprbeingpetted;
				image_index=0;
			}
		else
			{
				if image_index>=image_number-0.5
					{
						state=PlayerState.idle;
						pettingobj.active+=1;
						if (pettingobj.active==4)
							{
								pettingobj.active=0;
							}
					}
			}
	}