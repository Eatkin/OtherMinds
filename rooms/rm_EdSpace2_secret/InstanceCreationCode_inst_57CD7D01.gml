scr_difficultyDestroy(DIFFICULTY.NORMAL);		//Destroy on easy

firerate=180;

var diff=scr_return_difficulty();

if (diff>DIFFICULTY.NORMAL)
	firerate=120;