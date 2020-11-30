/// @description Create transition, move to next room after transition
// You can write your code in this editor

event_inherited();

if (active==true)
	{
		if (global.maincharacter==obj_Charlotte and destination==rm_Edcellar)
			{
				scr_queue_dialogue_box(scr_return_text(484));
				obj_dialogue.x=x;
				obj_dialogue.y=y;
				active=false;
				exit;
			}
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
						var player=global.currentinstance;
						player=player.object_index;
						if (object_get_parent(player)==parent_main_character)
							{
								global.maincharacter=player;
							}
							
						if (destination==rm_main_menu)
							scr_quit_to_menu();
						else
							room_goto(destination);
					}
			}
	}