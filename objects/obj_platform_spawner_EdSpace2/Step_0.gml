/// @description

if (global.hardpause==true or !activated)
	exit;
	
if (spawnrate==0)
	{
		var plat=instance_create_layer(spawnx,spawny,"blocks",obj_edspace2LiftPlatform);
		plat.xspeed=spawn_xspeed;
		plat.yspeed=spawn_yspeed;
		plat.minx=spawn_minx;
		plat.maxx=spawn_maxx;
		plat.miny=spawn_miny;
		plat.maxy=spawn_maxy;
		spawnrate=spawnratemax+1;
	}
	
spawnrate=max(0,spawnrate-1);