/// @description Accepts inputs
// You can write your code in this editor

scr_dialogue_step();

//Pause the cursor blinking alarm if necessary
if dialogueended=0
	{
		alarm[0]+=1;
	}