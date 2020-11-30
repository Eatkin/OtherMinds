/// @description

if (ds_list_size(blocklist)>2)
	{
		var block=ds_list_find_value(blocklist,0);
		with (block)
			{
				instance_create_layer(x+sprite_width*0.5,y+sprite_height*0.5,layer,obj_smoke);
				var emitter=instance_create_layer(x+sprite_width*0.5,y+sprite_height*0.5,layer,obj_sound_emitter);
				emitter.soundid=snd_pop;
				instance_destroy();
			}
		ds_list_delete(blocklist,0);
	}