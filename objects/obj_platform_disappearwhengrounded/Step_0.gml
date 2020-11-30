/// @description

// Inherit the parent event
event_inherited();

if (global.hardpause==true)
	{
		exit;
	}
	
var player=global.currentinstance;

if (player.state!=PlayerState.air)
	{
		image_alpha=lerp(image_alpha,0,0.1);
	}
else
	{
		image_alpha=lerp(image_alpha,1,0.5);
	}