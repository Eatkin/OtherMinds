/// @description

/*What do:
Decide what buttons to draw and find the max width
Create the buttons where they should be
Move buttons to x-room_width
Create the chevron too
*/
draw_set_font(global.font);			//If I don't do this it isn't alreayd set...for some reason? Which is very strange
//Start the text array
text[0]=scr_return_text(520);		//Tut Town
text[1]=scr_return_text(275);		//ES Z1
text[2]=scr_return_text(287);		//Ed's house
text[3]=scr_return_text(329);		//Overworld
text[4]=scr_return_text(347);		//Ochre
text[5]=scr_return_text(539);		//Ofice
text[6]=scr_return_text(619);		//ES Z2

var target=0;
target[0]=room_Tutorials_1;
target[1]=rm_EdSpace1_1;
target[2]=rm_Edbedroom;
target[3]=rm_overworld_edhouse;
target[4]=rm_ochrehill_1;
target[5]=rm_office_reception;
target[6]=rm_EdSpace2_3;


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
	button[i]=instance_create_layer(xx,yy+buttonSpacing*i,layer,obj_levelSelectButton);
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

//Cooldown
vinputCooldownMax=20;
vinputCooldown=0;
vinputClicks=0;

//Text fade in n out
textAlpha=0;
headerText=scr_return_text(812);