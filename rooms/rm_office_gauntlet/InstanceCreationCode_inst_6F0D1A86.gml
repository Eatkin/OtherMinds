dir=-1;
maxspeed=5;
xbound=160;

var diff=scr_return_difficulty();
if (diff>=DIFFICULTY.HARD)
	{
		maxspeed+=2;
	}
else if (diff<=DIFFICULTY.EASY)
	{
		maxspeed-=2;
	}