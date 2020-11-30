/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (global.hardpause==false and irandom(60)==0)
	{
		var xx=random(sprite_width)-sprite_xoffset*image_xscale;
		var yy=random(sprite_height)-sprite_yoffset*image_yscale;
		part_particles_create(global.partSys,x+xx,y+yy,global.collectibleParticle,1);
	}

if place_meeting(x,y,parent_main_character)
	{
		var char=instance_place(x,y,parent_main_character)
		if (char.state==PlayerState.defeated or char.state==PlayerState.dead)
			exit;
		//This assumes every item will be considered a secret
		scr_roomarray_set_secret_completed();
		scr_itemmap_setcollected();
		scr_obj_collect();
		scr_inventory_add();
		var emit=instance_create_layer(x,y,layer,obj_sound_emitter)
		emit.soundid=snd_orb_collect;
	}