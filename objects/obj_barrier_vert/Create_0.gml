/// @description Insert description here
// You can write your code in this editor
event_inherited();

state=BARRIER.NORMAL;

barrierrepeats=0;

//Find how many times to repeat the sprite
var i;
var imax=ceil(room_height/32);
for (i=0;i<imax;i+=1)
	{
		if place_meeting(x,y+32*i,obj_solid)
			{
				break;
			}
		if y+32*i>room_height
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
//Small brain method for I have a small brain
var x1=x+2;
var y1=y;
var x2=x1+sprite_width-4;
var y2=y1+sprite_width*barrierrepeats;
/*
Dumb idiot thing to do right here:
mask_index=sprite_create_from_surface(application_surface, x1, y1, x2-x1, y2-y1, false, false, 0, 0);
*/
//Now create the block to block Sage going thru
myblock=instance_create_layer(x1,y1,"blocks",obj_block);
scr_object_resize(myblock,x2-x1,y2-y1);

//Big brain time
scr_object_resize(id,sprite_width,sprite_height*barrierrepeats);

//Create a sound emitter
sound_emitter=instance_create_layer(x,y,layer,obj_barrier_sound);
sound_emitter.owner=id;

scr_barriermap_check();