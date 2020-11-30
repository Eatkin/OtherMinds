/// @description Insert description here
// You can write your code in this editor

//We don't pause during a pause screen because I don't think that's necessary

if alarm[0]=clamp(alarm[0],180,240)
	{
		alpha=lerp(alpha,1,0.05);
	}
if alarm[0]<60
	{
		alpha=lerp(alpha,0,0.05);
	}