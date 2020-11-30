/// @description Create transition, move to next room after transition
// You can write your code in this editor

event_inherited();

if active=0 and place_meeting(x,y,parent_main_character)
	{
		var inst=instance_place(x,y,parent_main_character)
		if global.currentinstance=inst
			{
				//Discover the bonus room in Ochre Hill
				if (destination==rm_ochrehill_bonus)
					{
						scr_roomarray_set_secret_completed();
					}
				active=1;
			}
	}

if active=1
	{
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