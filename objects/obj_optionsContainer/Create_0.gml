/// @description

/*What do:
Decide what buttons to draw and find the max width
Create the buttons where they should be
Move buttons to x-room_width
Create the chevron too
*/
draw_set_font(global.font);			//If I don't do this it isn't alreayd set...for some reason? Which is very strange
//Start the text array
text[0]=scr_return_text(5);		//Gameplay
text[1]=scr_return_text(6);		//Graphics
text[2]=scr_return_text(7);		//Audio
text[3]=scr_return_text(8);		//Control


//The targets in this case are specific objects that contain all the options that we need
var target=0;
target[0]=obj_gameplayMenuPanel;
target[1]=obj_graphicsMenuPanel;
target[2]=obj_audioMenuPanel;
target[3]=obj_controlMenuPanel;

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
xButtonTarget=room_width*0.3;
var xx=xButtonTarget+room_width;
var yy=(270-totalSpace)*0.5+270;		//Add 270 to move it one screen size down
button=0;
buttonSelected=0;

//Now loop thru and create some buttons
	
for (i=0; i<len; i+=1)	{
	button[i]=instance_create_layer(xx,yy+buttonSpacing*i,layer,obj_mainOptionButton);
	button[i].text=text[i];
	button[i].hrepeats=buttonhreps;
	button[i].target=target[i];
	if (i==buttonSelected)	{
		button[i].highlighted=true;
		button[i].x+=28;
		chevron=instance_create_layer(xx,yy+buttonSpacing*i,layer,obj_menuChevron);
		chevron.attachedTo=button[i];
	}
}

//Now we have created all the buttons we need a timer for easings
timer=0;
activated=false;
optionPanelActive=false;
toTheLeft=false;

//Cooldown
vinputCooldownMax=20;
vinputCooldown=0;
vinputClicks=0;