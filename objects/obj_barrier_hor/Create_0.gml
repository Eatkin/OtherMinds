/// @description Insert description here
// You can write your code in this editor

event_inherited();

state=BARRIER.NORMAL;

barrierrepeats=0;

//Find how many times to repeat the sprite
var i;
var imax=ceil(room_width/32);
for (i=0;i<imax;i+=1)
	{
		if place_meeting(x+32*i,y,obj_solid)
			{
				break;
			}
		if x+32*i>room_width
			{
				break;
			}
	}
barrierrepeats=i;
flashtime=5;
numberofflashes=8;
drawbarrier=1;
hueshift=0;
satshift=0;

//Set our collision mask
//This is the stupid way of doing it
var x1=x;
var y1=y+2;
var x2=x1+sprite_width*barrierrepeats;
var y2=y1+sprite_height-4;
/*
mask_index=sprite_create_from_surface(application_surface, x1, y1, x2-x1, y2-y1, false, false, 0, 0);
*/
//Now create the block to block Sage going thru
//This is good and smart, good job past me you smart man
myblock=instance_create_layer(x1,y1,"blocks",obj_block);
scr_object_resize(myblock,x2-x1,y2-y1);


//The galaxy brain approach:
scr_object_resize(id,sprite_width*barrierrepeats,sprite_height);

//Create a sound emitter
sound_emitter=instance_create_layer(x,y,layer,obj_barrier_sound);
sound_emitter.owner=id;

scr_barriermap_check();