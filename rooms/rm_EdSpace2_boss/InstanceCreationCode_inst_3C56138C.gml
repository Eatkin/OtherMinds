spawn_yspeed=1;

spawnratemax=45;

var diff=scr_return_difficulty();
if (diff==DIFFICULTY.NORMAL)
	spawn_yspeed+=1;
if (diff>DIFFICULTY.NORMAL)
	spawn_yspeed+=2;