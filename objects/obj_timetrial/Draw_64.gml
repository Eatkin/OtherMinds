/// @description

draw_set_valign(fa_middle);
draw_set_halign(fa_left);
draw_set_colour(c_white);

/*var minutes=floor(time/60);
minutes=string(minutes);
if (string_length(minutes)==1)
	{
		minutes="0"+minutes;
	}
var seconds=floor(time);
seconds=string(seconds)
if (string_length(seconds)==1)
	{
		seconds="0"+seconds;
	}
var mseconds=frac(time);
mseconds=string(mseconds);
//Copy the last two digits, after the decimal point
if (mseconds=="0")
	{
		mseconds="00";
	}
else
	{
		mseconds=string_copy(mseconds,3,2);
		while (string_length(mseconds)<2)
			{
				mseconds=mseconds+"0";
			}
	}
seconds=seconds+"."+mseconds;*/

var hudheight=sprite_get_height(spr_HUD_box);
var xpos=display_get_gui_width()*0.8;
var ypos=display_get_gui_height()-hudheight*global.helpbar-36;

//var text=minutes+":"+seconds;
var text=scr_timetostring(time);
draw_sprite(spr_stopwatch,0,xpos-12,ypos);
scr_draw_text_outlined(xpos,ypos,text);


draw_set_halign(fa_center);

xpos=display_get_gui_width()*0.5;
ypos=display_get_gui_height()*0.5;
if (alarm[0]>-1)
	{
		if (newbesttime==true)
			{
				draw_text_transformed(xpos,ypos-36,string_upper(scr_return_text(447)),2,2,0);
			}
		if (blink==true)
			{
				draw_text_transformed(xpos,ypos,text,2,2,0);
			}
	}