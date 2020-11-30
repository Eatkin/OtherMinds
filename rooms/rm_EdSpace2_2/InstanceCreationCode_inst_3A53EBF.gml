firerate=60;

scr_difficultyDestroy(DIFFICULTY.NORMAL);

var diff=scr_return_difficulty();

if (diff>DIFFICULTY.NORMAL)
	firerate=50;