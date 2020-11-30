//Created 02/12/19
//Last updated 02/12/19

//arg0 = left motor strength
//arg1 = right motor strength
//arg2 = duration

/*Dear future Ed, here are some nice presets!
Anything below 0.5 doesn't really do anything
A vib of 1 isn't that strong if the duration is small
So longer duration -> lower strength vibration
scr_set_vibration(0.5,0.5,1); //This will set a mild constant rumble
scr_set_vibration(1,1,1); //This will set a strong constant rumble
scr_set_vibration(1,1,10); //This is the smallest response you should use, for mild activities such as collecting an item
scr_set_vibration(1,1,15); //Mild events such as sign spinning
scr_set_vibration(1,1,30); //More major events such as teleportin -- this is still short though so not too annoying
*/

if global.vibration=false
	{
		exit;
	}

with (obj_rumble)
	{
		leftspeed=max(leftspeed,argument0);
		rightspeed=max(rightspeed,argument1);
		var duration=argument2;
		if duration=1
			{
				//A duration of 1 doesn't actually work so set to two and halve speed
				duration=2;
				leftspeed*=0.5;
				rightspeed*=0.5;
			}
		time=max(time,duration);
		alarm[0]=duration;
		//One exception here - this is used to completely halt all vibration
		if argument0=0 and argument1=0 and argument2=0
			{
				leftspeed=0;
				rightspeed=0;
				time=0;
			}
	}