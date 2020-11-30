/// @description

var snd=noone;

if (releaseKeysTimer>=0)
	releaseKeysTimer-=1;
else if (countdownTimer>=0)	{
	output=string(max(ceil(countdownTimer/30),1));
	countdownTimer-=1;
	if (countdownTimer<0)
		keyboard_lastkey=-1;
}
else if (pressKeyTimer>=0)	{					//THIS IS THE MAIN FUNCTION
	pressKeyTimer-=1;
	output=scr_return_text(57);		//Define key
	
	/*
	Blah - loop thru to find what key has been pressed
	*/
	if (global.input==1)	{	//Keyboard
		//A key has been pressed!
		if (keyboard_lastkey!=-1)	{
			pressKeyTimer=-1;	//Immediately end the "press key" state
			noKey=false;		//Indicate that we have received input
			//Detect disallowed keys
			var keyToBind=keyboard_lastkey;
			if (keyToBind=global.kb_start or keyToBind=global.kb_select or keyToBind==vk_escape)	{
				invalid=true;
				snd=audio_play_sound(snd_menu_no,0,0);
			}
			else	{		//Valid keys!
				snd=audio_play_sound(snd_menu_confirm,0,0);
				success=true;					//Assume success, this will be overruled if a conflict is found
				//This actually binds the key
				#region boring
				switch(keyToRebind)	{
					case 0:
						global.kb_b_one=keyToBind;
						break;
					case 1:
						global.kb_b_two=keyToBind;
						break;
					case 2:
						global.kb_b_four=keyToBind;
						break;
					case 3:
						global.kb_b_three=keyToBind;
						break;
					case 4:
						global.kb_left=keyToBind;
						break;
					case 5:
						global.kb_right=keyToBind;
						break;
					case 6:
						global.kb_up=keyToBind;
						break;
					case 7:	
						global.kb_down=keyToBind;
						break;
					}
				#endregion
				//Now we erase the key from the list but preserve the size		--	-1 is the default error value if something isn't found in a list
				//																	So basically, we're simulating that it can't be found
				ds_list_set(_list,keyToRebind,-1);
				//Now we search the list, if we find that the key is already in use, this will return a value. Otherwise it returns -1.
				var index=ds_list_find_index(_list,keyToBind);
				
				if (index!=-1)	{		//This executes when a conflict HAS been found
					conflict=true;
					conflictIndex=index;
					//We reserve the first available letter that's not bound to a key to bind to the conflict
					keyToBind=ord("A");
					var _keyindex=ds_list_find_index(_list,keyToBind)
					while (_keyindex!=-1)
						{
							keyToBind+=1;
							_keyindex=ds_list_find_index(_list,keyToBind)
						}
					
					//Now we've found a key, we can re-assign the conflict using the same switch as before, except now based on the index of the conflicting key
					#region boring
					switch(index)	{
					case 0:
						global.kb_b_one=keyToBind;
						break;
					case 1:
						global.kb_b_two=keyToBind;
						break;
					case 2:
						global.kb_b_four=keyToBind;
						break;
					case 3:
						global.kb_b_three=keyToBind;
						break;
					case 4:
						global.kb_left=keyToBind;
						break;
					case 5:
						global.kb_right=keyToBind;
						break;
					case 6:
						global.kb_up=keyToBind;
						break;
					case 7:	
						global.kb_down=keyToBind;
						break;
					}
					#endregion
					
				}
				
			}
		}
	}
	else	{					//Gamepad
		//We have to cycle through every gamepad button to check if its been pressed
		var keyToBind=scr_detect_gamepad_input();
		if (keyToBind!=0)	{		//Returns false if nothing detected
			pressKeyTimer=-1;
			noKey=false;
			
			if (keyToBind==global.gp_start or keyToBind==global.gp_select)	{		//Invalid keys
				invalid=true;
				snd=audio_play_sound(snd_menu_no,0,0);
			}
			else	{																//Valid keys
				snd=audio_play_sound(snd_menu_confirm,0,0);
				success=true;					//Assume success, this will be overruled if a conflict is found
				//This actually binds the key
				#region boring
				switch(keyToRebind)	{
					case 0:
						global.gp_b_one=keyToBind;
						break;
					case 1:
						global.gp_b_two=keyToBind;
						break;
					case 2:
						global.gp_b_four=keyToBind;
						break;
					case 3:
						global.gp_b_three=keyToBind;
						break;
					case 4:
						global.gp_left=keyToBind;
						break;
					case 5:
						global.gp_right=keyToBind;
						break;
					case 6:
						global.gp_up=keyToBind;
						break;
					case 7:	
						global.gp_down=keyToBind;
						break;
					}
				#endregion
				//Now we erase the key from the list but preserve the size		--	-1 is the default error value if something isn't found in a list
				//																	So basically, we're simulating that it can't be found
				ds_list_set(_list,keyToRebind,-1);
				
				//Now we search the list, if we find that the key is already in use, this will return a value. Otherwise it returns -1.
				var index=ds_list_find_index(_list,keyToBind);
				
				if (index!=-1)	{		//This executes when a conflict HAS been found
					conflict=true;
					conflictIndex=index;
					
					//We reserve the first available BUTTON that's not bound to a key to bind to the conflict
					keyToBind=gp_face1;
					var _keyindex=ds_list_find_index(_list,keyToBind)
					while (_keyindex!=-1)
						{
							keyToBind+=1;
							_keyindex=ds_list_find_index(_list,keyToBind)
						}
					
					//Now we've found a BUTTON, we can re-assign the conflict using the same switch as before, except now based on the index of the conflicting key
					#region boring
					switch(index)	{
					case 0:
						global.gp_b_one=keyToBind;
						break;
					case 1:
						global.gp_b_two=keyToBind;
						break;
					case 2:
						global.gp_b_four=keyToBind;
						break;
					case 3:
						global.gp_b_three=keyToBind;
						break;
					case 4:
						global.gp_left=keyToBind;
						break;
					case 5:
						global.gp_right=keyToBind;
						break;
					case 6:
						global.gp_up=keyToBind;
						break;
					case 7:	
						global.gp_down=keyToBind;
						break;
					}
					#endregion
					
				}
			}
		}
	}
	
	//Now we can set up the text
	if (pressKeyTimer<0)	{
		//Priority conflict->success->invalid->nokey
		if (conflict)	{
			output=scr_return_text(54);		//Conflict found
			//[insert key here]
			output+=scr_return_text(55);	//[key] has been reassigned
		}
		else if (success)
			output=scr_return_text(814);
		else if (invalid)
			output=scr_return_text(56);
		else
			output=scr_return_text(815);
	}
}
else	{
	confirmationMessageTimer-=1;
	if (confirmationMessageTimer<0)
		instance_destroy();
}

if (snd!=noone)
	audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);