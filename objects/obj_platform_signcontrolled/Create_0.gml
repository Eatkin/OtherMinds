/// @description Insert description here
// You can write your code in this editor

event_inherited();

state=PlayerState.idle;
xspeed=2;
yspeed=2;
if (scr_return_difficulty()>=DIFFICULTY.HARD)
	{
		xspeed+=2;
		yspeed+=2;
	}
	
//Need to set BOTH so starting dir can be restored after resetting position
dir=4; //Right
startdir=dir;
instancesontop=0;

//Perturbation variables
perturb=0;
perturbamount=8;
perturbationdir=1;
yunperturbed=y;