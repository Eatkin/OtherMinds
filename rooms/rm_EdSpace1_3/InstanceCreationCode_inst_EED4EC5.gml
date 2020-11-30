var diff=scr_return_difficulty();

if (diff<DIFFICULTY.NORMAL)
	firerate=360;
else if (diff<DIFFICULTY.HARD)
	firerate=240;
else
	firerate=180;