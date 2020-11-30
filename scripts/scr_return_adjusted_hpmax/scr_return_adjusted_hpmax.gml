//Created 18/09/19
//Last updated 18/09/19

//I use this to return the max HP available based on difficulty

var hpadjusted;
var diff=scr_return_difficulty();
switch (diff)
	{
		case DIFFICULTY.EXTRAHARD:
			{
				hpadjusted=0;
				break;
			}
		case DIFFICULTY.HARD:
			{
				hpadjusted=global.Edhealthmax-1;
				break;
			}
		case DIFFICULTY.NORMAL:
			{
				hpadjusted=global.Edhealthmax;
				break;
			}
		case DIFFICULTY.EASY:
			{
				hpadjusted=global.Edhealthmax+1;
				break;
			}
		case DIFFICULTY.EXTRAEASY:
			{
				hpadjusted=global.Edhealthmax+1;
				break;
			}
	}

return hpadjusted;