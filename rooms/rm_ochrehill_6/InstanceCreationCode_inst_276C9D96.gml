firerate=160;
if (scr_return_difficulty()>=DIFFICULTY.HARD)
	firerate=110;
else if (scr_return_difficulty()<=DIFFICULTY.EASY)
	firerate*=1.5;