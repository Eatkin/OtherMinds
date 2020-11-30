/// @description Insert description here
// You can write your code in this editor

dir=1;
state=PlayerState.idle;
xtarget=x;
coordinatequeue=ds_queue_create();
sagedist=16;
sageyoffset=0;
offsetcounter=0;
xspeed=0;
sagex=x-dir*sagedist;
sagey=y-16;
sagesubimg=0;

//We don't reaallly need this but whatever
scr_intrinsic_variables("Ed",0.05,1,8,10,9,0,0,global.Edhealth);

//fill the queue with these coordinates
repeat (15)
	{
		ds_queue_enqueue(coordinatequeue,x-dir*sagedist);
	}