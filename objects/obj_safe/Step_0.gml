/// @description

event_inherited();

if active=true
	{
		if !instance_exists(obj_safe_overlay)
			{
				instance_create_layer(0,0,layer,obj_safe_overlay);
			}
		active=false;
	}