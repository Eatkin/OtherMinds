/// @description

/*What do:
Decide what buttons to draw and find the max width
Create the buttons where they should be
Move buttons to x-room_width
Create the chevron too
*/
draw_set_font(global.font);			//If I don't do this it isn't alreayd set...for some reason? Which is very strange

text[0]=scr_return_text(44);
ref[0]=-1;
status[0]=TODOSTATUS.UNDISCOVERED;
description[0]=scr_return_text(66);

//Determine which todo to use
var isPlayer=(object_is_ancestor(global.currentinstance.object_index,parent_main_character))	?	true	:	false;
var linkedTodo=global.todo;
if (!isPlayer)
	linkedTodo=global.currentinstance.localtodo;
	
//Now we loop through the todo to get all the text
var len=ds_grid_height(linkedTodo);
var textNum=0;

for (var i=0; i<len; i+=1)	{
	if (linkedTodo[# TODO.STATUS, i]!=TODOSTATUS.UNDISCOVERED)	{
		text[textNum]		=linkedTodo[# TODO.NAME, i];
		ref[textNum]		=linkedTodo[# TODO.REF, i];
		status[textNum]		=linkedTodo[# TODO.STATUS,i];
		description[textNum]=linkedTodo[# TODO.DESCRIPTION,i];
		textNum+=1;		

	}
}

//Find the widest text
var maxLength=0;
var len=array_length_1d(text);
for (var i=0; i<len; i+=1)
	maxLength=max(maxLength,string_width(text[i]));
	
var buttonPadding=6;							//Either side of the button
buttonPadding+=sprite_get_width(spr_tick);		//We also need room for a tick or cross

maxLength+=buttonPadding*2;

maxLength=16*ceil(maxLength/16);
var buttonhreps=(maxLength/16)-2;		//How many middle section repeats for the buttons

buttonSpacing=sprite_get_height(spr_menuButton)*1.5;		//We use this to offset y coordinates
																//I.e. area occupied is buttonSpacing*len-buttonSpacing/3;
																//BUT I want it slightly higher anyway so ignore the final buttonSpacing/3
																//Change to buttonSpacing*(len-1)
//var totalSpace=buttonSpacing*(len-1);			//Unneeded

//Set starting coordinates for buttons
//x is essentially starting at 0.4, but shifted one room width to the left so it starts off screen
xButtonTarget=480*0.1;			//480 being the view width
var xx=xButtonTarget+480;		//Off to the right
var yy=buttonSpacing;			//We start at the top because these might span multiple "pages"
button=0;
buttonSelected=0;

/*Side note: How many buttons can fit on screen?
Buttonspacing <---Blank space
Then each button takes up "buttonSpacing" amount of screen space
so it's floor(view_height/buttonSpacing)-1
*/

buttonsPerScreen=floor((270-global.helpbar*sprite_get_height(spr_HUD_box))/buttonSpacing)-2;
menuyOffset=0;		//The offset for where the menu draws	-	This should be an integer for how many "buttonSpacings" the menu is offset by

//Now loop thru and create some buttons
//if textNum==0 then the todo list is empty so it's a special case

for (i=0; i<len; i+=1)	{
	button[i]=instance_create_layer(xx,yy+buttonSpacing*i,layer,obj_todoButton);
	button[i].text=text[i];
	button[i].hrepeats=buttonhreps;
	if (i==buttonSelected)	{
		button[i].highlighted=true;
		button[i].x+=28;
		chevron=instance_create_layer(xx,yy+buttonSpacing*i,layer,obj_pauseMenuChevron);
		chevron.attachedTo=button[i];
	}
	
	//Here we add the supplementary details
	//If our list is empty, we just skip this and use defaults
	if (textNum==0)
		break;
		
	button[i].ref		=ref[i];
	button[i].status	=status[i];
	button[i].linkedList=linkedTodo;
	button[i].description=description[i];
}

//Now we have created all the buttons we need a timer for easings
timer=0;
activated=false;

//Cooldown
vinputCooldownMax=20;
vinputCooldown=0;
vinputClicks=0;

//Create some arrows
arrow[0]=instance_create_layer(500,20,layer,obj_upIcon);
arrow[1]=instance_create_layer(500,270-20-global.helpbar*sprite_get_height(spr_HUD_box),layer,obj_downIcon);

if (len-1>buttonsPerScreen)
	arrow[1].alpha=1;			//Set target alpha to 1 if we can scroll down