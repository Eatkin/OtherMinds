/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

alarm[1]=120;

owner=noone;

barrierrepeats=0;

var cam=view_camera[0];
var camx=camera_get_view_x(cam);
//Find how many times to repeat the sprite
var i;
var imax=ceil(room_width/32);
for (i=0;i<imax;i+=1)
	{
		if x-32*i<camx
			{
				break;
			}
	}
barrierrepeats=i;

//Set our collision mask
image_xscale=barrierrepeats;
depth-=1;

emit=instance_create_layer(x,y,layer,obj_sound_emitter);
emit.soundid=snd_laser_blast;