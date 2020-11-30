/// @description fades out then in

// Inherit the parent event
event_inherited();

if (active==true)
	{
		global.softpause=true;
		//Emergency exit to avoid crashes
		//The transition object destroys itself when complete, but apparently this code is still running
		//So it destroys itself then this goes "Oh but the object existed one moment ago, I'm going t ocrash and die
		if (!instance_exists(transitionobj) and transitionobj!=noone)
			{
				transitionobj=noone;
				active=false;
				global.softpause=false;
				var playerhp=parent_main_character.hp;
				var dialogue=438;
				if (healthbeforesleeping!=playerhp)
					{
						dialogue=437;
					}
				scr_queue_dialogue_box(scr_return_text(dialogue));
				obj_dialogue.x=parent_main_character.x;
				obj_dialogue.y=parent_main_character.y;
				exit;
			}
		if (transitionobj==noone)
			{
				transitionobj=scr_create_transition(0,TRANSITION.FADE_IN);
				healthbeforesleeping=parent_main_character.hp;
			}
		if (transitionobj.transitioncomplete==true)
			{
				if (transitionobj.transition_type==TRANSITION.FADE_IN)
					{
						with (parent_main_character)
							{
								hp=hpmax;
								global.Edhealth=hp;
							}
						//This seems a bit ridiculous but there's stuttering with the fade
						tobedestroyed=transitionobj;
						alarm[0]=1;
						transitionobj=scr_create_transition(0,TRANSITION.FADE_OUT);
						if (targetLocation!=noone)	{
							room_goto(targetLocation);
							//Complete "head to bed"
							if (targetLocation==rm_EdSpace2_3)
								scr_todo_complete(18);
						}
					}
			}
	}