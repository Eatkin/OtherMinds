spawnx=x;
spawny=y;
spawn_yspeed=-2;
spawn_maxy=y+1;
spawnrate=120;
spawnratemax=120;

var diff=scr_return_difficulty();
if (diff!=DIFFICULTY.NORMAL)
	spawn_yspeed+=1;