/// @description Insert description here
// You can write your code in this editor

event_inherited();

//state=PlayerState.moving; //Don't need states
xspeed=0;
yspeed=0;
instancesontop=0;
destroyed=false;
destroyedtimer=0;
flashwhite=false;

//Perturbation variables
perturb=0;
perturbamount=8;
perturbationdir=1;
yunperturbed=y;

minx=-sprite_width;
maxx=room_width;
miny=-sprite_height;
maxy=room_height;