firerate=60;

var diff=scr_return_difficulty();

if (diff>DIFFICULTY.NORMAL)
	firerate=50;
		
if (diff<DIFFICULTY.NORMAL)
	firerate=90;