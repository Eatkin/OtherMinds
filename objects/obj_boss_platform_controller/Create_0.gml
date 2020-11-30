/// @description

platspeed=2;
if (scr_return_difficulty()>=DIFFICULTY.HARD)
	{
		platspeed+=1;
	}
if (scr_return_difficulty()<=DIFFICULTY.EASY)
	{
		platspeed-=1;
	}
activated=false;
currentspeed=0;

alarm[0]=1;