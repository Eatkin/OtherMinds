/// @description

active=true;
timer=0;
linkedGame=0;

//text and options
headerText=scr_return_text(5);			//Gameplay
option[0]=scr_return_text(36);			//Help bar
option[1]=scr_return_text(39);			//Difficulty
option[2]=scr_return_text(301);			//Vibration
optionSelected=0;


hrepeats=22;
vrepeats=6;								//1 for header, 1 for each option, 2 padding

//Set initial coordinates
x=room_width*1.5-hrepeats*8;
y=room_height*0.75-vrepeats*8;		//Room height is double view height so we use 0.75 to get half way down the screen

xstart=x;
ystart=y;

//Inputs cooldown
hinputPressed=false;
vinputCooldownMax=20;
vinputCooldown=0;
vinputClicks=0;

//Chevron draw positions
chevronX=x;
chevronY=y+vrepeats*16-string_height("A");

chevronTimer=0;