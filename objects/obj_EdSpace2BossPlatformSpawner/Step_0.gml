/// @description

if (global.hardpause or !activated)
	exit;
	
//Clean up off-screen platforms - make sure they're sufficiently far left though
with (obj_edspace2LiftPlatform)
	if (!scr_on_camera() and x<848)
		instance_destroy();

timer-=1;

if (timer==0)
	{
		timer=timerMax;
		var plat=instance_create_layer(spawnX,spawnY[platToSpawn],"blocks",obj_edspace2LiftPlatform);
		plat.xspeed=spawnSpeed;
		platToSpawn+=1;
		platToSpawn=platToSpawn%3;
	}