/// @description

if (!instance_exists(obj_transition) and !global.hardpause)
	{
		//Depends where we are, if we haven't viewed the firts cutscene it createes that
		//If we have and we're also returning to EdSpace, create that
		//Otherwise just destroy
		if (!scr_event_check_complete(global.tutorialTownEvents,TutorialTownEvents.FirstCutscene))	{
			//create return home from menu dialogue
			instance_create_layer(0,0,layer,obj_TT1_Ctuscene);		//Typo lol
			global.tutorialTownEvents=scr_event_set_complete(global.tutorialTownEvents,TutorialTownEvents.FirstCutscene);
		}
		instance_destroy();
	}