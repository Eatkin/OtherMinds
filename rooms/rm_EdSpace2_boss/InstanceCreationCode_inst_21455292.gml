var diff=scr_return_difficulty();
with (obj_bomb_spawner)
	{
		if (diff>DIFFICULTY.NORMAL)
			respawntimermax*=0.5;
		else if (diff<DIFFICULTY.NORMAL)
			respawntimermax*=2;
	}