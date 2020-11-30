/// @description

// Inherit the parent event
event_inherited();

if (global.hardpause==true)
	{
		exit;
	}

//Reset timer if w tiurn on and off
if (!activated)
	time=0;

if (activated==true)
	{
		time+=1;
		y+=time*global.gravstrength*2;
	}
	
if (y>room_height)
	{
		instance_destroy();
	}