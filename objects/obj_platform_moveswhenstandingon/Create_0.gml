/// @description Insert description here
// You can write your code in this editor

event_inherited();

state=PlayerState.idle;
xspeed=0;
yspeed=0;
acc=0.2;
maxspeed=1;
if (global.difficulty>DIFFICULTY.NORMAL)
	{
		maxspeed=2;
	}
//Need to set BOTH so starting dir can be restored after resetting position
dir=4; //Right, 2 for left I think
startdir=dir;
instancesontop=0;

//Perturbation variables
perturb=0;
perturbamount=8;
perturbationdir=1;
yunperturbed=y;