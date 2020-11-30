/// @description Draw the transition
// You can write your code in this editor

//Okay so from what I gather surfaces randomly disappear so we need to check it still exists
if !surface_exists(transitionsurface)
	{
	    transitionsurface = surface_create(guiwidth,guiheight);
	}
	
//Surfaces are confusing
//This draws a rectangle, then draws a circle over the top with bm_subtract
//Which by magic draws a rectangle with a circle in the middle
//Brilliant!
surface_set_target(transitionsurface);
draw_clear_alpha(0,0);
if transition_type=TRANSITION.CIRCLE_IN or transition_type=TRANSITION.CIRCLE_OUT
	{
		draw_set_color(c_black);
		draw_rectangle(0,0,guiwidth,guiheight,0);
		if transitioncomplete=0
			{
				gpu_set_blendmode(bm_subtract);
				draw_circle(transitionx,transitiony,circlemaxradius*transitioncounter/transitioncountermax,0);
				gpu_set_blendmode(bm_normal);
			}
	}
if transition_type=TRANSITION.FADE_IN or transition_type=TRANSITION.FADE_OUT
	{
		draw_set_colour(c_black);
		draw_set_alpha(transitionalpha);
		draw_rectangle(0,0,guiwidth,guiheight,false);
		draw_set_alpha(1);
	}

if transition_type=TRANSITION.BLOCK_IN or transition_type=TRANSITION.BLOCK_OUT
	{
		draw_set_colour(c_black);
		draw_rectangle(0,0,guiwidth,guiheight,false);
	}
surface_reset_target();
draw_surface(transitionsurface,0,0);