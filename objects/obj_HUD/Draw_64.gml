/// @description Just draws the HUD
// You can write your code in this editor

//We check if we're following something (i.e a little cutscene) and if we are we skip the event
var follow=false
with (obj_camera)
	{
		if (following!=noone and following!=global.currentinstance)
			{
				follow=true;
			}
	}
//Make sure we're ALSO SOFT PAUSED!!
//Wtf does this mean?
if (follow==true and !instance_exists(obj_transition) and  global.softpause==true)
	{
		exit;
	}

if ds_queue_empty(global.dialoguequeue)=false
	{
		exit;
	}
//Don't draw on the main menu or other exceptions
//Also have exceptions to the exceptions
if (scr_is_disallowed_room(room)==true and room!=rm_language_select and room!=rm_firsttime and room!=rm_main_menu)
	{
		exit;
	}

draw_set_alpha(HUDalpha);

if (global.brightness!=1)
	{
		shader_set(shd_brightness);
		var b=shader_get_uniform(shd_brightness,"brightness");
		shader_set_uniform_f(b,global.brightness);
		var greyscale=shader_get_uniform(shd_brightness,"greyscale");
		shader_set_uniform_f(greyscale,0);
	}

scr_HUD_tips_draw();

if (global.brightness!=1)
	{
		shader_reset();
	}

draw_set_alpha(1);