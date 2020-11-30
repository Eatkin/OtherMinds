firerate=180;

var diff=scr_return_difficulty();

if (diff>DIFFICULTY.NORMAL)
	firerate=120;
		
if (diff<DIFFICULTY.NORMAL)
	firerate=220;