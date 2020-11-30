/// @description

/*What do:
Decide what buttons to draw and find the max width
Create the buttons where they should be
Move buttons to x-room_width
Create the chevron too
*/
draw_set_font(global.font);			//If I don't do this it isn't alreayd set...for some reason? Which is very strange
//Start the text array
text[0]=scr_return_text(1);		//To do
text[1]=scr_return_text(2);		//Inventory
text[2]=scr_return_text(3);		//Guidebook
text[3]=scr_return_text(4);		//Options
text[4]=scr_return_text(187);		//View map
var n=5;

var canLeaveLevel=false;
var timeTrial=false;
if (global.canleavelevel)	{
		text[n]=scr_return_text(10);		//Return to Ed's house
		n+=1;
		canLeaveLevel=true;
	}
else if (instance_exists(obj_timetrial))	{
		//timetrial=true;			//idk what this is for
		text[n]=scr_return_text(449);
		n+=1;
		timeTrial=true;
	}
text[n]=scr_return_text(42);		//Save and quit

//Find the widest text
var maxLength=0;
var len=array_length_1d(text);
for (var i=0; i<len; i+=1)
	maxLength=max(maxLength,string_width(text[i]));
	
var buttonPadding=6; //Either side of the button

maxLength+=buttonPadding*2;

maxLength=16*ceil(maxLength/16);
var buttonhreps=(maxLength/16)-2;		//How many middle section repeats for the buttons

var buttonSpacing=sprite_get_height(spr_menuButton)*1.5;		//We use this to offset y coordinates
																//I.e. area occupied is buttonSpacing*len-buttonSpacing/3;
																//BUT I want it slightly higher anyway so ignore the final buttonSpacing/3
																//Change to buttonSpacing*(len-1)
var totalSpace=buttonSpacing*(len-1);

//Set starting coordinates for buttons
//x is essentially starting at 0.4, but shifted one room width to the left so it starts off screen
xButtonTarget=480*0.1;		//480 being the view width
var xx=xButtonTarget-480;
var buttonSpacing=sprite_get_height(spr_menuButton)*1.5;
var yy=(270-totalSpace)*0.5;
yy=buttonSpacing;				//Overwrite, this sets it near the top which is more consistent
button=0;
buttonSelected=0;

//Now loop thru and create some buttons
	
for (i=0; i<len; i+=1)	{
	button[i]=instance_create_layer(xx,yy+buttonSpacing*i,layer,obj_pauseButton);
	button[i].text=text[i];
	button[i].hrepeats=buttonhreps;
	if (i==buttonSelected)	{
		button[i].highlighted=true;
		button[i].x+=28;
		chevron=instance_create_layer(xx,yy+buttonSpacing*i,layer,obj_pauseMenuChevron);
		chevron.attachedTo=button[i];
	}
	switch (i)	{
		case 0:
			button[i].targetMenu=PauseMenu.ToDo;
			button[i].attachedScript=scr_setActivePauseMenu;
			break;
		case 1:
			button[i].targetMenu=PauseMenu.Inventory;
			button[i].attachedScript=scr_setActivePauseMenu;
			break;
		case 2:
			button[i].targetMenu=PauseMenu.Guide;
			button[i].attachedScript=scr_setActivePauseMenu;
			break;
		case 3:
			button[i].targetMenu=PauseMenu.Options;
			button[i].attachedScript=scr_setActivePauseMenu;
			break;
		case 4:
			button[i].attachedScript=scr_loadMapFromPause;
			break;
	}
	
	//A couple of dynamically loaded buttons
	if (i==5)	{
		if (canLeaveLevel)
			button[i].attachedScript=scr_returnEdsHouseFromPause;
		else if (timeTrial)
			button[i].attachedScript=scr_restartTrialFromPause;
	}
	
	//Last option is always to quit
	if (i==(len-1))
		button[i].attachedScript=scr_saveAndQuitFromPause;
}

//Now we have created all the buttons we need a timer for easings
timer=0;
activated=false;

//Cooldown
vinputCooldownMax=20;
vinputCooldown=0;
vinputClicks=0;