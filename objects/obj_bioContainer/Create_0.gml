/// @description

/*What do:
Decide what buttons to draw and find the max width
Create the buttons where they should be
Move buttons to x-room_width
Create the chevron too
*/
draw_set_font(global.font);			//If I don't do this it isn't alreayd set...for some reason? Which is very strange
//Start the text array
var player=global.currentinstance;
text[0]=player.name;
text[1]=scr_return_text(43) + " " + string(player.powerlevel);
text[2]=player.bio[0];
text[3]=player.bio[1];

mySpr=player.bio[2];
sprImageIndex=0;

hrepeats=13;

//Get the heights of the bios incase the wrap
var padding=6;
padding*=2;
var maxwidth=hrepeats*16-padding;
var lines=4;
if (string_width(text[2])>maxwidth)
	lines+=1;
if (string_width(text[3])>maxwidth)
	lines+=1;
	
vrepeats=2+lines;

//Set coords
x=480-(hrepeats+1)*16+480;
xstart=x;
y=32;
ystart=y;

//timer for easings
timer=0;