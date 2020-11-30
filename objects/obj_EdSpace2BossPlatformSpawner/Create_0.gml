/// @description

activated=false;

spawnX=1392;
spawnY[0]=720;
spawnY[1]=664;
spawnY[2]=616;

var diff=scr_return_difficulty();
timerMax=60;
spawnSpeed=-3;
if (diff<DIFFICULTY.NORMAL)
	spawnSpeed=-2;
if (diff>DIFFICULTY.NORMAL)
	spawnSpeed=-4;
	
timer=timerMax;
platToSpawn=0;