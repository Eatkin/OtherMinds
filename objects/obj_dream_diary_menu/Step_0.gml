/// @description

var snd=noone;

if global.softpause=false
	{
		global.softpause=true;
	}

//Grab inputs
var vinput=0;
var select=0;
var back=0;

//Inputs not accepted if we're lerping the menu in or out or changing rooms
if moveenabled=1 and changingrooms=false and global.hardpause=false
	{
		vinput=global.inputs[1];
		select=global.inputs[4];
		back=global.inputs[5];
	}
	
//I'll handle the lerping in the step event this time instead of draw because that's more sensible
if moveenabled=0
	{
		if movedir=1
			{
				var xtarget=display_get_gui_width()*.99-menuwidth*1.2;
				var movement=lerp(menu_x,xtarget,0.2)-menu_x;
				movement=sign(movement)*max(2,abs(movement));
				menu_x+=movement;
				if abs(menu_x-xtarget)<2
					{
						menu_x=xtarget;
						moveenabled=1;
					}
					
				//Now update the image position
				xtarget=display_get_gui_width()*0.1;
				movement=lerp(image_surfx,xtarget,0.2)-image_surfx;
				movement=sign(movement)*max(2,abs(movement));
				image_surfx+=movement;
				if (abs(image_surfx-xtarget)<2)
					{
						image_surfx=xtarget;
						moveenabled=1;
					}
			}
		else
			{
				xtarget=display_get_gui_width()*1.25;
				var movement=lerp(menu_x,xtarget,0.2)-menu_x;
				movement=sign(movement)*max(2,abs(movement));
				menu_x+=movement;
				//If we've moved sufficiently far down we exit the menu or start a loading transition depending on state
				if menu_x>display_get_gui_width()*1.1 and changingrooms=false
					{
						instance_destroy();
						exit;
					}
					
				//Image surface pos
				var imagesize=262;
				xtarget=-imagesize*1.5;
				movement=lerp(image_surfx,xtarget,0.2)-image_surfx;
				image_surfx+=movement;
			}
		
	}
	
//Now we do menu navigation
menu_cool=max(0,menu_cool-1);
	
if sign(vinput)!=0 and menu_cool=0
	{
		menu_cool=menu_cool_max;
		menu_y_selection-=sign(vinput);
		if menu_y_selection=clamp(menu_y_selection,0,counter-1)
			{
				var snd=audio_play_sound(snd_menu_move,0,0);
			}
		else
			{
				var snd=audio_play_sound(snd_menu_no,0,0);
			}
	}
//Set menu cool to 0 if we release vinput
if (vinput==0)
	{
		menu_cool=0;
	}
//Make sure our selection doesn't go below 0 or above counter-1
menu_y_selection=clamp(menu_y_selection,0,counter-1);

//Now do the scrolling, I think this works by magic
var rowscrolling=2; //How far down before we start scrolling
var targetyoffset;
var maxrows=9; //How many rows displayed
var spacing=18;
if menu_y_selection*spacing-menu_yoffset<rowscrolling*spacing
	{
		targetyoffset=(menu_y_selection-rowscrolling)*spacing;
	}
else if menu_y_selection*spacing-menu_yoffset>(maxrows-rowscrolling)*spacing
	{
		targetyoffset=(menu_y_selection-maxrows+rowscrolling)*spacing;
	}
else
	{
		targetyoffset=menu_yoffset;
	}
targetyoffset=max(0,targetyoffset);
if targetyoffset!=menu_yoffset
	{
		var movement=lerp(menu_yoffset,targetyoffset,0.2)-menu_yoffset
		movement=sign(movement)*max(2,abs(movement));
		menu_yoffset+=movement;
		if abs(menu_yoffset-targetyoffset)<=2
			{
				menu_yoffset=targetyoffset;
			}
	}
		
//Update the cursor position
//The only problem with this is it doesn't take into account any extra lines
var target_cursory=menu_y_selection*spacing;
var movement=lerp(menu_cursor_y,target_cursory,0.2)-menu_cursor_y;
movement=sign(movement)*max(2,abs(movement));
menu_cursor_y+=movement;
if abs(menu_cursor_y-target_cursory)<=2
	{
		menu_cursor_y=target_cursory;
		image_displaying=destinations[menu_y_selection,2];
	}
else
	{
		image_displaying=noone;
	}

var optionselected=false;
//We'll now give the option of selecting the option
if select=1
	{
		var snd=audio_play_sound(snd_menu_confirm,0,0);
		optionselected=true;
		select=0;
	}

if back=1
	{
		var snd=audio_play_sound(snd_menu_shift,0,0);
		audio_sound_pitch(snd,0.9);
		moveenabled=false;
		movedir=-1;
		back=0;
	}

if optionselected=true
	{
		//Lerp the menu away but it wont get destroyed with changingrooms=true
		changingrooms=true;
		moveenabled=false;
		movedir=-1;
		//Now if we've selected an option we need to behave as if this is a door moving to its destination
		//So instead of doing anything sensible, I'm going to create a door, set its destination to to the target and activate the door
		var dest;
		dest=destinations[menu_y_selection,1];
		var door=instance_create_layer(x,y,layer,obj_door);
		with (door)
			{
				destination=dest;
				visible=false;
				active=true;
				event_perform(ev_step,ev_step_normal);
				if audio_is_playing(snd_door_open)
					{
						audio_stop_sound(snd_door_open);
					}
			}
	}
	
//Also ned to update the HUD bar now
scr_HUD_tips_clear();
scr_HUD_set_tips_text(scr_return_text(273), scr_return_text(274));
scr_HUD_set_tips_buttons(global.kb_b_one,global.kb_b_two);

//Set snd volume
if snd!=noone
	{
		audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
	}