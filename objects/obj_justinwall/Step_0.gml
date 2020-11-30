/// @description Step code for movement etc
// You can write your code in this editor

event_inherited();

scr_states_step();

if (state==PlayerState.wallfall)
	{
		global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.JUSTIN_WALLED);
		if sprite_index!=spr_justin_explode
			{
				sprite_index=spr_justin_explode;
				image_index=0;
			}
		if (image_index==clamp(image_index,10,11) and soundplayed[0]==false)
			{
				var emit=instance_create_layer(x,y,layer,obj_sound_emitter);
				emit.soundid=snd_spikes_eject;
				soundplayed[0]=true;
			}
		if (image_index==clamp(image_index,11,12) and soundplayed[1]==false)
			{
				var emit=instance_create_layer(x,y,layer,obj_sound_emitter);
				emit.soundid=snd_spikes_eject;
				soundplayed[1]=true;
			}
		if (image_index==clamp(image_index,image_number,image_number-1))
			{
				image_speed=0;
				if (myblock!=noone)
					{
						instance_destroy(myblock);
						myblock=noone;
						sprite_idle=spr_justin_idleexploded;
						sprite_blink=spr_justin_blinkexploded;
						scr_dialoguemap_init(2,3);
						state=PlayerState.idle;
						mask_index=spr_justin_exploded_mask;
						masknormal=mask_index;
					}
			}
	}