//Created 26/02/20
//Last updated 26/02/20

var winx=window_get_x();
var winy=window_get_y();
var winwidth=window_get_width();
var winheight=window_get_height();
var rects;
rects=window_get_visible_rects(winx,winy,winwidth,winheight);
var displaynum=array_length_1d(rects)/8;

//If there is only one display attached we can just centre the window
//Actually can bypass this, but guessing it is a bit faster than going through a totally unecessary for loop lol
//This is also a failsafe for if displaynum=0, which does happen on Linux for some stupid idiot reason
if (displaynum<=1)
	{
		window_center();
		exit;
	}
	
//Now we need to get the overlaps
//This basically sees which display holds the largest amount of the window
var displaytouse=0;
var visiblearea=0;
var visibleareamax=0;
for (var i=0; i<displaynum; i+=1)
	{
		var display_x=rects[4+8*i];
		var display_y=rects[5+8*i];
		var displaywidth=rects[6+8*i];
		var displayheight=rects[7+8*i];
		var x1=min(winx-display_x,displaywidth);
		x1=max(x1,0);
		var x2=min(winx+winwidth-display_x,displaywidth);
		x2=max(x2,0);
		var y1=min(winy-display_y,displayheight);
		y1=max(y1,0);
		var y2=min(winy+winheight-display_y,displayheight);
		y2=max(y2,0);
		visiblearea=(x2-x1)*(y2-y1);
		/*//Debug output
		show_debug_message("Num "+string(i));
		show_debug_message("display_x="+string(display_x)+" display_y="+string(display_y));
		show_debug_message("displaywidth="+string(displaywidth)+" displayheight="+string(displayheight));
		show_debug_message("X1="+string(x1)+" Y1="+string(y1));
		show_debug_message("X2="+string(x2)+" Y2="+string(y2));
		show_debug_message("visible area="+string(visiblearea));*/
		if (visiblearea>visibleareamax)
			{
				visibleareamax=visiblearea;
				displaytouse=i;
			}
	}
	
//So now we know what display to use we will get the display details
var display_x=rects[4+displaytouse*8];
var display_y=rects[5+displaytouse*8];
var displaywidth=rects[6+displaytouse*8]-display_x;
var displayheight=rects[7+displaytouse*8]-display_y;

//Now we will centre the window!
var windowpos_x=display_x+displaywidth*0.5-winwidth*0.5;
var windowpos_y=display_y+displayheight*0.5-winheight*0.5;
window_set_position(windowpos_x,windowpos_y);