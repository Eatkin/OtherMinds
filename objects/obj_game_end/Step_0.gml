/// @description Menu things
// You can write your code in this editor

var snd=noone;

//Grab inputs
var vinput=global.inputs[1];
var select=global.inputs[4];
select=max(select,global.inputs[14]); //You can also use the start button
	
//Reset cooldown
if vinput=0
	{
		menucool=0;
	}
	
if sign(vinput)!=0 and menucool=0
	{
		menucool=menucoolmax;
		menu_y-=sign(vinput);
		if menu_y=clamp(menu_y,0,options-1)
			{
				var snd=audio_play_sound(snd_menu_move,0,0);
			}
		else
			{
				var snd=audio_play_sound(snd_menu_no,0,0);
			}
	}
menu_y=clamp(menu_y,0,options-1);

//Update the cursor position
var target_cursory=room_height*0.6-options*v_spacing*0.5+v_spacing*menu_y-sprite_get_height(spr_menucursor)*0.5; //Ah yes the very obvious formula
var movement=lerp(cursor_y,target_cursory,0.2)-cursor_y;
movement=sign(movement)*max(2,abs(movement));
cursor_y+=movement;
if abs(cursor_y-target_cursory)<=2
	{
		cursor_y=target_cursory;
	}
			
//Update the cursor x too!
var target_cursorx=(room_width-string_width(option[menu_y]))*0.5-8;
var movement=lerp(cursor_x,target_cursorx,0.2)-cursor_x;
movement=sign(movement)*max(2,abs(movement));
cursor_x+=movement;
if abs(cursor_x-target_cursorx)<=2
	{
		cursor_x=target_cursorx;
	}

//This will do whatever and then end the game
if (select==true)
	{
		var snd=audio_play_sound(snd_menu_confirm,0,0);
		var url="";
		switch (menu_y)
			{
				case 0:
					{
						//Just quit!
						game_end();
						break;
					}
					/*
				case 1:
					{
						//Google form
						url="https://forms.gle/iZ2tkfjWNwZnNCbH9";
						break;
					}*/
				case 1:
					{
						//Discord
						url="https://discord.gg/AeFeu43";
						break;
					}
				case 2:
					{
						//Twitter
						url="https://twitter.com/EAtkin";
						break;
					}
					/*
				case 4:
					{
						//Itch
						url="https://eatkin.itch.io/other-minds";
						break;
					}*/
			}
		if (url!="")
			{
				url_open(url);
			}
	}
	
//Final thing - set the gain of the audio!
if snd!=noone
	{
		audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
	}