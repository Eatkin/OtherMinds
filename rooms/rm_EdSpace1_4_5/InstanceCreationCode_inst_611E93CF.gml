firerate=120;

var diff=scr_return_difficulty();

if (diff>DIFFICULTY.NORMAL)
	firerate=90;
if (diff>DIFFICULTY.NORMAL)
	firerate=150;
	
timer=firerate/3;