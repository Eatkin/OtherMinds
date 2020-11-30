firerate=300;

var diff=scr_return_difficulty();
if (diff>=DIFFICULTY.HARD)
	{
		firerate-=50;
	}
else if (diff<=DIFFICULTY.EASY)
	{
		firerate+=150;
	}