spawn_yspeed=1;

spawnrate=75;

var diff=scr_return_difficulty();
if (diff==DIFFICULTY.NORMAL)
	spawn_yspeed+=1;
if (diff>DIFFICULTY.NORMAL)
	spawn_yspeed+=2;