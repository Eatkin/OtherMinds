var diff=scr_return_difficulty();

var spawnSpeed=3;
if (diff<DIFFICULTY.NORMAL)
	spawnSpeed=2;
if (diff>DIFFICULTY.NORMAL)
	spawnSpeed=4;
	
spawnx=x;
spawny=y;
spawn_xspeed=spawnSpeed;
spawn_maxx=2528;

activated=false;