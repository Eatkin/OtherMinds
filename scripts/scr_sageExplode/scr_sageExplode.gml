//This makes Sage explode and return to Ed

with (obj_sage)	{
	//Destroy in a puff of smoke!
	instance_create_layer(x,y,"players",obj_smoke);
	global.currentinstance=instance_nearest(x,y,parent_main_character);
	instance_destroy();
	var emitter=instance_create_layer(x,y,"players",obj_sound_emitter)
	emitter.soundid=snd_pop;
	scr_set_vibration(1,1,15);
	with (parent_possessable)
		outlineshader=false;
}