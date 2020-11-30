firerate=300;
if (scr_return_difficulty()<=DIFFICULTY.EASY)
	{
		firerate+=150;
	}
else if (scr_return_difficulty()>=DIFFICULTY.HARD)
	{
		firerate-=50;
	}