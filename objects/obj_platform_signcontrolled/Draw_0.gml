/// @description Set shaders
// You can write your code in this editor
//So we want to set the rateof flashing based on where the alarm is

var shaderon=0;
if alarm[0]>120
	{
		shaderon=0;
	}
else if alarm[0]>=60
	{
		if (alarm[0]/15)%1<=0.5
			{
				shaderon=1;
			}
	}
else if alarm[0]>=30
	{
		if (alarm[0]/12)%1<=0.5
			{
				shaderon=1;
			}
	}
else if alarm[0]>=15
	{
		if (alarm[0]/10)%1<=0.5
			{
				shaderon=1;
			}
	}
else
	{
		if (alarm[0]/5)%1<=0.5
			{
				shaderon=1;
			}
	}
	
if alarm[0]=-1
	{
		shaderon=0;
	}
	
if shaderon=0
	{
		draw_self();
		exit;
	}
else
	{
		shader_set(shd_whitesprite);
		draw_self();
		shader_reset();
	}