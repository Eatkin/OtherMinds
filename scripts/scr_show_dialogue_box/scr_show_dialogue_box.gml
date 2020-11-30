//Created 01/07/19
//Last updated 02/07/19

/*Plan?
Well we draw the box
Then we start writing in the box one character at a time
If we hit a \ character, we advance the characters an extra 1 to hit the new line trigger
In the step event I'll let the player press A to skip the nice display I put so much effort into
If the full string is displayed we'll show a little icon to skip
*/

if (instance_exists(obj_transition))
	exit;

if (!global.softpause)
	global.softpause=true;

var guiwidth=display_get_gui_width();
var guiheight=display_get_gui_height();
var x1, x2, y1, y2;

x1=guiwidth*0.1;
x2=guiwidth*0.9;
y1=guiheight*0.65;
y2=guiheight*0.95;

var _string=ds_queue_head(global.dialoguequeue);
var stringtoshow;
var stringlength=string_length(_string);

//This sets up the morse array and fills it with sounds
var morsestring=_string;
if (characters==1)
	{
		for (var i=0; i<stringlength;i+=1)
			{
				if (string_char_at(_string,i)==" ")
					{
						var _soundstring=string_copy(_string,0,i);
						morsestring=scr_to_morse_code(_soundstring);
						//We need to determine the length of all the sounds
						var soundlength=string_count(".",morsestring)*audio_sound_length(snd_morse_short)+string_count("-",morsestring)*audio_sound_length(snd_morse_long);
						soundlength=soundlength*60; //Convert to frames
						//Now check there is sufficient samples to cover the full length of the text box displaying
						//If there isn't, we move on to the next word
						//If we get to the end of the string (somehow), we'll already have saved the morse string
						if soundlength<string_length(_string)
							{
								continue;
							}
						break;
					}
			}
		//Now lets cycle through the morse string to create an array full of sound indices
		var snd;
		for (var i=0; i<string_length(morsestring);i+=1)
			{
				var code=string_char_at(morsestring,i);
				if (code==".")
					snd=snd_morse_short;
				else
					snd=snd_morse_long;
				ds_queue_enqueue(morsequeue,snd);
			}
	}

//Just show the full string if dialogue has finished
if dialogueended=1
	{
		stringtoshow=_string;
	}
else
	{
		//Ensure the line breaks are displayed properly
		if string_char_at(_string,characters)="\\"
			{
				characters+=1;
			}

		stringtoshow=string_copy(_string,1,characters);
	}

draw_set_font(global.font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);

//Draw the box
/*
draw_set_colour(c_black);
draw_rectangle(x1,y1,x2,y2,0);
draw_set_colour(c_white);
draw_rectangle(x1,y1,x2,y2,1);*/

//Now instead we draw the sprite!
var palette=scr_select_UI_palette();
scr_set_palette_swap_shader(spr_UI_palette,palette,true);
var hrepeats=24;
var vrepeats=4;

var lines=string_count("\n",_string);
vrepeats=2+lines;
//y1+=(4-vrepeats)*16;
for (var i=0; i<hrepeats; i+=1)
	for (var j=0; j<vrepeats; j+=1)	{
		//Bitmasks to select appropriate tile
		var tilenum=0;
		if (i>0)
			tilenum|=8;
		if (i<hrepeats-1)
			tilenum|=2;
		if (j>0)	
			tilenum|=1;
		if (j<vrepeats-1)
			tilenum|=4;
		
		//Now draw
		draw_sprite_part(spr_9slice,0,tilenum*16,0,16,16,x1+i*16,y1+j*16);
	}
shader_reset();

//Update x1, y1 for drawing text, just a 5 px buffer or 2px for y because that means we can fit 3 lines
x1+=5;
y1+=6;

//Re-define y2
y2=y1+16*vrepeats;

//draw_text(x1,y1,stringtoshow);
draw_text(x1, y1, stringtoshow);

//Temp sprite for showing what it'll look like
//Also clear out the ds queue
if dialogueended=1
	{
		draw_sprite(spr_dialogue_cursor,cursorblink,x2-24,y2-20);
		draw_set_colour(c_white);
		ds_queue_clear(morsequeue);
	}


//Add one to the number of characters to display
if characters<stringlength
	{
		characters+=1;
	}
else if dialogueended=0
	{
		dialogueended=1;
		cursorblink=1;
	}
	
if !ds_queue_empty(morsequeue)
	{
		var playsound=false;
		if morsesound=noone
			{
				playsound=true;
			}
		else if !audio_is_playing(morsesound)
			{
				playsound=true;
			}
		if playsound=true
			{
				morsesound=audio_play_sound(ds_queue_head(morsequeue),0,0);
				audio_sound_gain(morsesound,global.sound_fx_volume*global.sound_fx_on,0);
				ds_queue_dequeue(morsequeue);
			}
	}