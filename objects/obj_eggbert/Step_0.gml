/// @description States and stuff
// You can write your code in this editor

event_inherited();

scr_states_step();

//We need some additional code that when we hit the floor, we create a baby chick, which becomes the current instance
//Then create the broken egg on top
/*This is now in the defeated code so we can jump on him to break him
if y>448 and state!=PlayerState.air
	{
		//instance create eggbert the bird
		var bird=instance_create_layer(x,y,layer,obj_eggbert_hatched);
		instance_create_layer(x,y,"Lighting",obj_eggbertbroken);
		instance_create_layer(x,y,layer,obj_smoke);
		global.currentinstance=bird;
		global.overworld_events=scr_event_set_complete(global.overworld_events,OVERWORLD_EVENTS.EGGBERTHATCHED);
		var emit=instance_create_layer(x,y,layer,obj_sound_emitter);
		emit.soundid=snd_pop;
		bird.alarm[0]=30;
		global.softpause=true;
		instance_destroy();
	}*/