/// @description Destroy and data management
// You can write your code in this editor

with (obj_boss_controller)
	{
		laseractive=0;
		laserdestroyedtimer=0;
		alarm[4]=-1;
	}
with (owner)
	{
		shots-=1;
		mylaser=noone;
	}
instance_destroy();