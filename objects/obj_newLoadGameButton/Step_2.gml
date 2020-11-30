/// @description shake to show we can't load the game

//This should apply a perturbation because the controller determines the x-position

if (shake)	{
	if (shakeTimer>=1)	{
		shakeTimer=0;
		shake=false;
		exit;
	}
	
	shakeTimer+=0.05;		//Animate for 20 frames
	var strength=4;				//Max amount of movement
	var perturbation=(scr_easeInOutBack(shakeTimer)-0.5)*strength;
	x+=perturbation;
}