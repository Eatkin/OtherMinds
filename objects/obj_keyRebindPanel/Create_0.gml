/// @description

keyToRebind=-1;		//This is an index which is linked to a key - same order as the list that is later written out
keyString="I AM ERRRORORORROROROROROGREROERSUS";
success=false;		//Key was rebound succesfully!
conflict=false;		//Key was rebound but another key was changed to avoid conflict
conflictIndex=-1;
invalid=false;		//Key bound not allowed
noKey=true;			//No key has been pressed
keyboard_lastkey=-1;			//Make sure we don't auto-rebind instantly

headerText=scr_return_text(816);		//Rebinding

hrepeats=16;
vrepeats=10;

//Update coords
x=room_width*0.5-hrepeats*8;
y=room_height*.75-vrepeats*8;

//Set up a list of keyboard indices
//IMPORTANT OTHERWISE IT'LL ALWAYS DETECT A CONFLICT:
//We need to delete the index we're binding at some point
//We can just do that when we check for a conflict
_list=ds_list_create();
if (global.input==1)	{		//KEYBOARD
	//Add all the keys to the ds list
	//The order is EXTREMELY important
	//This will needs updating if any keys are added!
	ds_list_add(_list,global.kb_b_one);
	ds_list_add(_list,global.kb_b_two);
	ds_list_add(_list,global.kb_b_four);
	ds_list_add(_list,global.kb_b_three);
	ds_list_add(_list,global.kb_left);
	ds_list_add(_list,global.kb_right);
	ds_list_add(_list,global.kb_up);
	ds_list_add(_list,global.kb_down);
}
else	{						//PAD
	ds_list_add(_list,global.gp_b_one);
	ds_list_add(_list,global.gp_b_two);
	ds_list_add(_list,global.gp_b_four);
	ds_list_add(_list,global.gp_b_three);
	ds_list_add(_list,global.gp_left);
	ds_list_add(_list,global.gp_right);
	ds_list_add(_list,global.gp_up);
	ds_list_add(_list,global.gp_down);
}

releaseKeysTimer=60;				//"Release all keys..."
countdownTimer=90;					//"3, 2, 1..." (30f per number)
pressKeyTimer=120;					//"Press a key"	- this times out after 2 seconds and says no key found
confirmationMessageTimer=120;		//"Successful/conflict/not allowed etc"

output=scr_return_text(813);