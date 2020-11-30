/// @description Insert description here
// You can write your code in this editor
event_inherited();

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

state=BARRIER.NORMAL;
flashtime=5;
numberofflashes=8;
drawbarrier=1;
alpha=0.75;

//Set our collision mask
var x1=x+2;
var y1=y;
var x2=x1+sprite_width-4;
var y2=y1+sprite_width*barrierrepeats;
scr_object_resize(id,sprite_width,sprite_height*barrierrepeats);

//Now create the block to block Sage going thru
//This should actually be a line
myblock=instance_create_layer(x1+0.5*(x2-x1),y1,"blocks",obj_block);
scr_object_resize(myblock,2,y2-y1);

//visibility counter
visiblecounter=0;

//Create a sound emitter
sound_emitter=instance_create_layer(x,y,layer,obj_barrier_sound);
sound_emitter.owner=id;

if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.BOSSDEFEATED)
	{
		state=BARRIER.DISAPPEAR;
		alarm[0]=flashtime;
	}