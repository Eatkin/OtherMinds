activated=false;

spawnx=x;
spawny=y;
spawn_xspeed=2;
spawn_minx=0;
spawn_maxx=992;
spawn_miny=0;
spawn_maxy=room_height;

spawnrate=60;
spawnratemax=spawnrate;

var diff=scr_return_difficulty();

if (diff>DIFFICULTY.NORMAL)
	spawn_xspeed*=2;
else if (diff<DIFFICULTY.NORMAL)
	spawn_xspeed*=0.5;