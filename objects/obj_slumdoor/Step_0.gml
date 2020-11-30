/// @description

event_inherited();

if active=1
	{
		//This is temp, we will do events etc later on
		scr_queue_dialogue_box(scr_return_text(371));
		obj_dialogue.x=x+sprite_width*0.5;
		obj_dialogue.y=y+sprite_height*0.5;
		active=0;
		exit;
		global.softpause=1;
		if transitionobj=noone
			{
				scr_set_vibration(1,1,10);
				scr_play_sound(snd_door_open,false,0);
				transitionobj=scr_create_transition(TRANSITION.T_IN);
			}
		else
			{
				if !instance_exists(transitionobj) or transitionobj.transitioncomplete=true
					{
						global.softpause=0;
						//DEFAULT SETTING AS I DON'T HAVE A ROOM TO GO TO
						if destination=noone
							{
								room_restart();
								exit;
							}
						//REMOVE THIS LATER^ or don't because it'll never be triggered
						global.localdeaths=-1;
						room_goto(destination);
					}
			}
	}