/// @description

// Inherit the parent event
event_inherited();

if (visible==false and parent_main_character.state!=PlayerState.air and place_meeting(x,y-1,parent_main_character))
	{
		emit=instance_create_layer(x,y,layer,obj_sound_emitter);
		emit.soundid=snd_menu_slider;
		emit.pitchoverride=0.5;
		visible=true;
	}