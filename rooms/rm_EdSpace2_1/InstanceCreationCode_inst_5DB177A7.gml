spawnx=x;
spawny=y;
spawn_yspeed=-2;
spawn_xspeed=-1;
spawn_miny=-16;
activated=false;
spawnratemax+=4;

var diff=scr_return_difficulty();
if (diff>=DIFFICULTY.HARD)
	spawn_xspeed-=1;
else if (diff<=DIFFICULTY.EASY)
	{
		spawn_yspeed+=1;
		spawnratemax*=2;
	}