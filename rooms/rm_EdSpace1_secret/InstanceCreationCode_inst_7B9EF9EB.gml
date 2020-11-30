var diff=scr_return_difficulty();

firerate=180;

if (diff<DIFFICULTY.NORMAL)
	firerate=240;
else if (diff>DIFFICULTY.NORMAL)
	firerate=120;