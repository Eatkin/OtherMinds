//Created 16/07/19
//Last updated 16/07/19

//Checks if we're controlling the instance and also checks if we're soft paused


//Can move
if (global.currentinstance!=id or global.softpause)
	{
		canmove=0;
	}
if global.currentinstance=self and global.softpause=0
	{
		canmove=1;
	}