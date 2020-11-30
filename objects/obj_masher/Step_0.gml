/// @description

event_inherited()

if activated=true
	{
		if image_yscale=1
			{
				scr_set_vibration(1,1,30);
				var emit=instance_create_layer(x,y,layer,obj_sound_emitter);
				emit.soundid=snd_cannon_into_wall;
			}
		image_yscale=lerp(image_yscale,3,0.5);
	}