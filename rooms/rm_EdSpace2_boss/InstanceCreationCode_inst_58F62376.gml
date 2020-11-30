spawn_yspeed=-1;

spawnrate=90;


var diff=scr_return_difficulty();
if (diff==DIFFICULTY.NORMAL)
	spawn_yspeed-=1;
if (diff>DIFFICULTY.NORMAL)
	spawn_yspeed-=2;
	
spawn_maxy=y+1;
spawn_miny=352;