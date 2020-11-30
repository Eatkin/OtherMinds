/// @description

active=true;
timer=0;
linkedGame=0;

//text and options
headerText=scr_return_text(7);			//Audio
option[0]=scr_return_text(31);			//Enable sound		select
option[1]=scr_return_text(32);			//Enable music		select
option[2]=scr_return_text(35);			//Enable 3d			select
option[3]=scr_return_text(33);			//Sound volume		hinput
option[4]=scr_return_text(34);			//Music volume		hipnut
optionSelected=0;

hrepeats=22;
vrepeats=8;								//1 for header, 1 for each option, 2 padding

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