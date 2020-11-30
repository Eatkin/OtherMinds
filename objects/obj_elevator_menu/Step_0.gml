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
		back=global.inputs[7];
	}
	
//I'll handle the lerping in the step event this time instead of draw because that's more sensible
if moveenabled=0
	{
		if movedir=1
			{
				var xtarget=display_get_gui_width()*.90-menuwidth*1.2;
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
		menu_y_selection+=sign(vinput);
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

var optionselected=false;
//We'll now give the option of selecting the option
if select=1
	{
		var snd=audio_play_sound(snd_elevator_button,0,0);
		optionselected=true;
		select=0;
	}

if back=1
	{
		var snd=audio_play_sound(snd_menu_shift,0,0);
		audio_sound_pitch(snd,0.9);
		moveenabled=false;
		movedir=-1;
		with (obj_elevator_doors)
			{
				doorsopening=true;
			}
		back=0;
	}

if optionselected=true
	{
		var dest;
		dest=destinations[menu_y_selection];
		if (dest==room)
			{
				var snd=audio_play_sound(snd_menu_shift,0,0);
				audio_sound_pitch(snd,0.9);
				moveenabled=false;
				movedir=-1;
				with (obj_elevator_doors)
					{
						doorsopening=true;
					}
			}
		else
			{
				//Lerp the menu away but it wont get destroyed with changingrooms=true
				changingrooms=true;
				moveenabled=false;
				movedir=-1;
				//Now if we've selected an option we need to behave as if this is a door moving to its destination
				//So instead of doing anything sensible, I'm going to create a door, set its destination to to the target and activate the door
				var door=instance_create_layer(x,y,layer,obj_door);
				with (door)
					{
						destination=dest;
						visible=false;
						active=true;
						event_perform(ev_step,ev_step_normal);
						if (audio_is_playing(snd_door_open))
							{
								audio_stop_sound(snd_door_open);
							}
					}
			}
	}
	
//Also ned to update the HUD bar now
//THIS NEEDS CHANGING - IT SAYS EXIT DREAM DIARY
scr_HUD_tips_clear();
scr_HUD_set_tips_text(scr_return_text(273), scr_return_text(541));
scr_HUD_set_tips_buttons(global.kb_b_one,global.kb_b_four);

//Set snd volume
if snd!=noone
	{
		audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
	}
	
if (changingrooms==true)
	{
		var movingup=true;
		//Find our room
		var ourroomindex=0;
		for (var i=0; i<counter; i+=1)
			{
				if (room=destinations[i])
					{
						ourroomindex=i;
						break;
					}
			}
		if (ourroomindex>menu_y_selection)
			{
				movingup=false;
			}
		with (parent_main_character)
			{
				if (visible==true)
					{
						scr_play_sound(snd_elevator_loop,0,false);
					}
				state=PlayerState.debug;
				visible=false;
				if (movingup==true)
					{
						if (y-5>0)
							{
								y-=5;
							}
					}
				else
					{
						if (y+5<room_height)
							{
								y+=5;
							}
					}
			}
	}