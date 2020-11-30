/// @description re-check time

if (global.rng==3)
	{
		hour-=1/10;
		minute+=6;
	}
else
	{
		hour=current_hour%12;
		minute=current_minute;
		hour=hour+minute/60;
	}

hourangle=(hour/12);
minuteangle=minute/60;

alarm[0]=60;