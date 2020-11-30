/// @description

if (!instance_exists(obj_transition) and !global.hardpause and parent_main_character.x>736)
	{
		//Depends where we are, if we haven't viewed the firts cutscene it createes that
		//If we have and we're also returning to EdSpace, create that
		//Otherwise just destroy
		if (!scr_event_check_complete(global.tutorialTownEvents,TutorialTownEvents.ThirdCutscene))	{
			//create return home from menu dialogue
			instance_create_layer(0,0,layer,obj_TT3_Ctuscene);		//Typo lol
			global.tutorialTownEvents=scr_event_set_complete(global.tutorialTownEvents,TutorialTownEvents.ThirdCutscene);
		}
		instance_destroy();
	}