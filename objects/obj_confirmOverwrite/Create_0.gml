/// @description

active=true;
timer=0;
linkedGame=0;

//text and options
text=scr_return_text(808);		///Wwarning
text+="\n";
text+=scr_return_text(809);		//Confirm?
option[0]=scr_return_text(810);	//Yes
option[1]=scr_return_text(811);	//No
optionSelected=0;

//Drawing parameters and coordinates
var strWidth=string_width(text);		//Get the width of the box
strWidth=strWidth+strWidth%16;			//Make it divisible by 16

hrepeats=strWidth/16+2;
vrepeats=4;

//Set initial coordinates
x=room_width*1.5-hrepeats*8;
y=room_height*0.75-vrepeats*8;		//Room height is double view height so we use 

xstart=x;
ystart=y;

//Inputs cooldown
hinputPressed=false;

//Chevron draw positions
chevronX=x;
chevronY=y+vrepeats*16-string_height("A");
chevronXPotential[0]=x+4;
chevronXPotential[1]=x+hrepeats*16-4-string_width(option[1]);

chevronTimer=0;