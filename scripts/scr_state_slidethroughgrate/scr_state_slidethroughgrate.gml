//Created 06/10/19
//Last updated 06/10/19

//We just play animation then translate coords and go to air state
//lerp towards grate if not in the correct osition
var gravMultiplier=dsin(global.gravdirection);
var grate=instance_place(x,y+gravMultiplier,obj_grate);
var targetx=grate.x+sprite_get_width(grate.sprite_index)*0.5;
x=lerp(x,targetx,0.25);
if (abs(x-targetx)<1)
	x=targetx;

xspeed=0;
							
//Now handle sprites
if (sprite_index!=sprite_throughgrate)
	{
		scr_play_sound(snd_slide_through_grate,0,0);
		canbehurtenabled=false; //This temporarily stops the instance being hurt while sliding through a grate
		sprite_index=sprite_throughgrate;
		image_index=0;
	}
	
if (image_index>image_number-0.5)
	{
		iframes=0;
		canbehurtenabled=true;
		y+=64*gravMultiplier;
		state=PlayerState.air;
		sprite_index=sprite_air;
	}
	
if (timeinstate<60)
	{
		var vibamount=2*abs(dcos(timeinstate));
		vibamount=clamp(vibamount,0.5,0.8);
		scr_set_vibration(vibamount,vibamount,1);
	}