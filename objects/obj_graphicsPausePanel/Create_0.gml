/// @description

active=true;
timer=0;
linkedGame=0;

//text and options
headerText=scr_return_text(6);			//Graphics
option[0]=scr_return_text(13);			//Scale			Hinput		DONE
option[1]=scr_return_text(12);			//Full screen	Selecte		DONE
option[2]=scr_return_text(16);			//Vsync			Select		DONE
option[3]=scr_return_text(18);			//Gamepad icons	Hinput		DONE
option[4]=scr_return_text(17);			//Font			Hinput		DONE
option[5]=scr_return_text(15);			//Transitions	Hinput		DONE
option[6]=scr_return_text(14);			//Brightness	Hinput		DONE
optionSelected=0;

//Other variables for storage
var width=480;
var height=270;
var screenw=display_get_width();
var screenh=display_get_height();
maxScale=min(floor(screenw/width),floor(screenh/height));

hrepeats=22;
vrepeats=10;								//1 for header, 1 for each option, 2 padding

//Set initial coordinates
x=480*1.5-hrepeats*8;
y=270*0.5-vrepeats*8;		//Room height is double view height so we use 0.75 to get half way down the screen

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