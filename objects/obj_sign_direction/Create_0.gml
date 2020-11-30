/// @description Sets up some variables
// You can write your code in this editor

event_inherited();

gainoverride=0;
scr_play_sound(snd_sign_spin,1,0);
//But firstly
//Okay this makes sure dir is never 0, because once it spins once it will never ever be 0 again
image_speed=0;
if image_index=0
	{
		image_index=image_number;
	}
//Image_index+1 should be divisible by 11 for starters ALWAYS when created!
//But we floor it because the first image_index is 0 and that means it'll have a dir of 1/11
dir=floor((image_index+1)/11);

//Remember order of dirs is the same as angles
//An oversight in the animation caused right to be 4 instead of 0, oops lol hahaha fuck
//dir 4 is right, 1 is up, 2 is left, 3 is down

//Uhh..and that's it

//Okay some more variables
active=0;
state=PlayerState.idle; //Two states - idle and spinning
label=scr_return_text(160);

previousstate=-1;
timeinstate=0;

child=instance_create_layer(x,y,layer,obj_sign_directionMask);
child.owner=id;

//For camera control
maxxspeed=3;
maxyspeed=3;