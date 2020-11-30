/// @description

active=true;
timer=0;
linkedGame=0;

//text and options
headerText=scr_return_text(8);			//Control
option[0]=scr_return_text(20);			//Jump
option[1]=scr_return_text(21);			//Interact
option[2]=scr_return_text(22);			//Action
option[3]=scr_return_text(23);			//Sage
option[4]=scr_return_text(24);			//Left
option[5]=scr_return_text(25);			//Right
option[6]=scr_return_text(26);			//Up
option[7]=scr_return_text(27);			//Down
option[8]=scr_return_text(30);		//Restore defauilts
optionSelected=0;

hrepeats=18;
vrepeats=12;								//1 for header, 1 for each option, 2 padding

//Set initial coordinates
x=480*1.5-hrepeats*8;
y=270*0.5-vrepeats*8;		//Room height is double view height so we use 0.75 to get half way down the screen

xstart=x;
ystart=y;

//Inputs cooldown
vinputCooldownMax=20;
vinputCooldown=0;
vinputClicks=0;

//Chevron draw positions
chevronX=x;
chevronY=y+vrepeats*16-string_height("A");

chevronTimer=0;