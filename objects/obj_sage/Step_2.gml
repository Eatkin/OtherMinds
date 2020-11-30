/// @description

//Let's try get unstuck first
//A bit of code to get unstuck
//Let's make sure we're not stuck in a wall because that can happen

var _xscale=image_xscale;
var _yscale=image_yscale;
image_xscale=1;
image_yscale=1;
var counter=0;
var ysp=scr_sign_nonzero(y-yprevious);
var xsp=scr_sign_nonzero(x-xprevious);
var maxsteps=32;
if place_meeting(x,y,obj_solid)
	{
		while (place_meeting(x,y-ysp,obj_solid) and counter<maxsteps)
			{
				y+=ysp;
				counter+=1;
			}
		counter=0;
		while (place_meeting(x,y+ysp,obj_solid) and counter<maxsteps)
			{
				y-=ysp;
				counter+=1;
			}
		counter=0;
		while (place_meeting(x-xsp,y,obj_solid) and counter<maxsteps)
			{
				x+=xsp;
				counter+=1;
			}
		counter=0;
		while (place_meeting(x+xsp,y,obj_solid) and counter<maxsteps)
			{
				x-=xsp;
				counter+=1;
			}
	}

if place_meeting(x,y,obj_solid)
	{
		scr_play_sound(snd_pop,0,0);
		instance_create_layer(x,y,layer,obj_smoke);
		instance_destroy();
		scr_set_vibration(1,1,15);
		global.currentinstance=instance_nearest(x,y,parent_main_character);
	}
	
image_xscale=_xscale;
image_yscale=_yscale;