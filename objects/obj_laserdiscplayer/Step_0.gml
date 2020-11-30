/// @description

// Inherit the parent event
event_inherited();

if active=true
	{
		active=false;
		if (haslaserdisc==true)
			{
				instance_create_layer(x,y,layer,obj_laserdisc_menu);
			}
		else
			{
				scr_queue_dialogue_box(scr_return_text(443))
			}
	}