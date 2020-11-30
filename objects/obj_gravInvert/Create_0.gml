/// @description

activated=false;

maxTime=360;
time=-1;

var diff=scr_return_difficulty();

//Variable time based on difficulty
if (diff>DIFFICULTY.NORMAL)
	maxTime-=60;
else if (diff<DIFFICULTY.EASY)
	maxTime+=60;
	
//Dfeault max time to 300 if it's a time trial level
if (instance_exists(obj_timetrial))
	maxTime=300;