/// @description

if (activeMenu==Menu.Main)	{
	//Ease the camera down
	if (cameraTimer<1)	{
		cameraTimer+=0.02;
		var cam=view_camera[0];
		var ease=scr_easeInOutSin(cameraTimer);
		camera_set_view_pos(cam,0,270*ease);
		rectAlpha=0.4*ease;
		obj_HUD.HUDalpha=ease;		//Fade in the HUD!
	}
	else if (!anyKeyDeactivated)		//Deactivate the "press any key" object off screen because it's never seen again once we've scrolled down
		instance_deactivate_object(obj_pressAnyKeyManager);
}

//Set the HUD stuff
scr_HUD_set_tips_buttons(global.kb_b_one);
scr_HUD_set_tips_text(scr_return_text(279));
if (activeMenu!=Menu.Main)	{
		scr_HUD_add_tips_buttons(global.kb_b_two);
		scr_HUD_add_tips_text(scr_return_text(280));
	}

//Nothing when rebinding a key!
if (instance_exists(obj_keyRebindPanel))
	scr_HUD_tips_clear();
	
	
//Then load the attract screen
var hinput=global.inputs[0];
var vinput=global.inputs[1];
var select=global.inputs[4];
var back=global.inputs[5];

var inputsPressed=sign(abs(hinput)+abs(vinput)+select+back);
if (inputsPressed==0)
	attractTimer+=1;
else
	attractTimer=0;
	
if (attractTimer>=attractTimerMax and !instance_exists(obj_transition) and !instance_exists(obj_keyRebindPanel))		//Checking for the rebind panel is unecessary but you never know
	scr_loadAttractFromMenu();