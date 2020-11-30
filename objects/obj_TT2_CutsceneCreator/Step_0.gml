/// @description

if (!instance_exists(obj_transition) and !global.hardpause and parent_main_character.x>288)
	{
		//Depends where we are, if we haven't viewed the firts cutscene it createes that
		//If we have and we're also returning to EdSpace, create that
		//Otherwise just destroy
		if (!scr_event_check_complete(global.tutorialTownEvents,TutorialTownEvents.SecondCutscene))	{
			//create return home from menu dialogue
			instance_create_layer(0,0,layer,obj_TT2_Ctuscene);		//Typo lol
			global.tutorialTownEvents=scr_event_set_complete(global.tutorialTownEvents,TutorialTownEvents.SecondCutscene);
		}
		instance_destroy();
	}
	
//If we are already using Sage, it just cancels the cutscene
if (instance_exists(obj_sage) and obj_sage.x>288)	{
	global.tutorialTownEvents=scr_event_set_complete(global.tutorialTownEvents,TutorialTownEvents.SecondCutscene);
	instance_destroy();
}