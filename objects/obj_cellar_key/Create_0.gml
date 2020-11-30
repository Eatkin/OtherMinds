/// @description Set a speed and trajectory
// You can write your code in this editor

event_inherited();

//Shove the key to the left so we don't instantly collide with the player
while(place_meeting(x,y,parent_main_character))
	{
		x-=1;
	}

//We want a trajectory probably 45-60 degrees
traj=irandom(15)+45;
traj+=75; //set it to the second quadrant

//Now set a speed between 5 and 8 and get the vectors
var spd=irandom(3)+5;
xspeed=spd*dcos(traj);
yspeed=-spd*dsin(traj);

//Also coefficient of restitution
restitution=0.5;

//Make sure it doesn't fall down a hole
xsafe=x;
ysafe=y;

//Play creation sound (obviously, why do I need to comment that)
scr_play_sound(snd_item_create,false,0);