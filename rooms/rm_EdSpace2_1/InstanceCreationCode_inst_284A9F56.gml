spawnx=x;
spawny=y;
spawn_yspeed=2;
spawn_miny=y-1;
spawnrate=120;
spawnratemax=120;

var diff=scr_return_difficulty();
if (diff>=DIFFICULTY.HARD)
	spawn_yspeed+=1;
else if (diff<=DIFFICULTY.EASY)
	spawn_yspeed-=1;