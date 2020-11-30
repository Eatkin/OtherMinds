/// @description create transition

var trans=instance_create_layer(0,0,layer,obj_transition);
trans.transition_type=TRANSITION.FADE_OUT;

activeMenu=Menu.PressAnyKey;

//Transition the camera down when active menu is the main menu
cameraTimer=0;
anyKeyDeactivated=false;

rectAlpha=0;

obj_HUD.HUDalpha=0

attractTimer=0;
attractTimerMax=10*room_speed;
//attractTimerMax=120; //Uncomment to test attract screens