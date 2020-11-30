activated=false;
firerate=120;

var diff=scr_return_difficulty();
if (diff>=DIFFICULTY.HARD)
	firerate-=30;
else if (diff<=DIFFICULTY.EASY)
	firerate+=30;