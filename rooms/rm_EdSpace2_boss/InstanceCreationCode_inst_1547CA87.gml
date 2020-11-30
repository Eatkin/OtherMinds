activated=false;

var diff=scr_return_difficulty();

if (diff==DIFFICULTY.NORMAL)
	firerate*=1.5;
else if (diff>DIFFICULTY.NORMAL)
	firerate*=2;