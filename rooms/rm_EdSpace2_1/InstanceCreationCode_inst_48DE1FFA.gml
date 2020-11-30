spawnx=x;
spawny=y;
spawn_yspeed=-2;
spawn_xspeed=1;
spawn_miny=-16;
spawnratemax-=2;

activated=false;

scr_difficultyDestroy(DIFFICULTY.HARD,true);
if (scr_return_difficulty()<=DIFFICULTY.EASY)
	{
		spawn_yspeed+=1;
		spawnratemax*=2;
	}