dir=-1;
xbound=room_width*2;
maxspeed=5;

var diff=scr_return_difficulty();
if (diff>=DIFFICULTY.HARD)
	{
		maxspeed+=2;
	}
else if (diff<=DIFFICULTY.EASY)
	{
		maxspeed-=2;
	}