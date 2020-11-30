var diff=scr_return_difficulty();
if (diff>=DIFFICULTY.HARD)
	{
		maxspeed+=1;
		xbound-=16;
	}
else if (diff<=DIFFICULTY.EASY)
	{
		maxspeed-=1;
		xbound+=8;
	}