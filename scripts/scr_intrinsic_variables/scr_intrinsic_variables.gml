//Created 05/07/19
//Last updates 05/07/19

//I want to make sure each instance has its important variables set up using this script

//Default
talking=0;
xspeed=0;
yspeed=0;

name=argument0;
acceleration=argument1;
accelerationreductionfactor=argument2;
maxxspeed=argument3;
maxyspeed=argument4;
jumpheight=-argument5;
powerlevel=argument6;
hasdialogue=argument7;
hp=argument8;
hpmax=hp;

coyotetimemax=5; //5 frames
coyotetime=0;
jumpbuffertimemax=10;
jumpbuffertime=0;
directionfacing=1;
pushspeed=0;

previousstate=-1;
timeinstate=0;
canmove=1;

if object_get_parent(object_index)!=parent_main_character
	{
		localinventory=ds_grid_create(6,0);
		localtodo=ds_grid_create(4,0);
	}

felloffcliff=0; //If you fall off a cliff and still have health you respawn at the last safe location
xsafe=x;
ysafe=y;
xsafeInvert=x;
ysafeInvert=y;
iframes=0;

blinking=0;
waiting=0;
dustcounter=0;

//Marker for when off screen
//Have to manually change the image_index
marker_index=0;
markertimer=4;

//Variable for when we just got something the inventory
holding=noone;
holdingtimer=-1;

//Things for wall blim - lol whats a blim
onwalltimer=0; //This is when you aren't holding agianst the wall, you will start to slip down
wallholdawaytimer=0; //This is when you're holding away from a wall and you will fall off when the timer hits a certain number

//Things for the dash thing, standard variables or whatever lol
dashtimer=5;
dashspeed=maxxspeed*3;
candash=true;
dashcooldown=0;

//Simulated inputs
s_hinput=0;
s_vinput=0;
s_jump=0;
s_jumphold=0;
s_b_two=0; //Interact
s_b_three=0; //Possessing (for Sage), useful for cutscenes
s_b_four=0; //Pulling

//Whatever
outlineshader=false;

//Masks
maskduck=noone;
maskair=noone;

//Dialogue
dialoguecomplete=false; //This sets to true when all dialogue has been read

scaleoverride=1;

splatColour=c_white; //Only used for splat particles