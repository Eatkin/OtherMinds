/// @description

//Exit if we're using keyboard input
if global.input=1
	{
		exit;
	}
	
if leftspeed=0 and rightspeed=0
	{
		gamepad_set_vibration(global.pad,0,0);
		exit;
	}
	
//This is REALLY REALLY IMPORTANT because it avoids a divide by 0 error
if time=0
	{
		gamepad_set_vibration(global.pad,0,0);
		leftspeed=0;
		rightspeed=0;
		exit;
	}

gamepad_set_vibration(global.pad,leftspeed,rightspeed);