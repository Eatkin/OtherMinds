/// @description Set a speed and trajectory
// You can write your code in this editor

event_inherited();

//We want a trajectory probably 45-60 degrees
traj=irandom(15)+45;
traj+=choose(0,75); //50% of the time set it to the second quadrant

//Now set a speed between 5 and 8 and get the vectors
var spd=irandom(3)+5;
var gravMultiplier=(global.gravdirection==90)	?	1	:	-1;
xspeed=spd*dcos(traj);
yspeed=-spd*dsin(traj)*gravMultiplier;

//Also coefficient of restitution
restitution=0.5;

//Make sure it doesn't fall down a hole
xsafe=x;
ysafe=y;

//Play creation sound (obviously, why do I need to comment that)
scr_play_sound(snd_item_create,false,0);

//Don't become collectible for one second
tangible=false;
alarm[0]=60;