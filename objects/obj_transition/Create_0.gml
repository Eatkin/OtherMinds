/// @description Create transition variables
// You can write your code in this editor
depth=-10001;		//Yes this is important
//Have to create this first because otherwise the variable is undefined and the cleanup event dies
transitionsurface=noone;

//Transition stuff
//Default to circle_out but can be overridden
transition_type=TRANSITION.CIRCLE_OUT;
transitioncounter=0;
transitioncountermax=20;
lerpamount=0.1;
guiwidth = display_get_gui_width();
guiheight = display_get_gui_height();

//Declare variables
transitionx=0;
transitiony=0;
circlemaxradius=0;
transitionalpha=0;

//Also
transitioncomplete=0;
global.softpause=true;

if (global.transitions==false)
	transitioncomplete=true;