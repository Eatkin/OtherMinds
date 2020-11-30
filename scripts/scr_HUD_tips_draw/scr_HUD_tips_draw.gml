//Created: 17/06/19
//Last updated: 31/08/19

//This is super annoying
//I basically need a way to link different inputs to different sprites
//I did set this up in previous game
//I've only got keyboard input at the moment so easy for now

/*Anyway what to do:
-Draw the button
-Draw the text next to it
-Get the spacing right
-Repeat up until it finds a null (-1) value
*/
var screenwidth=display_get_gui_width();
var screenheight=display_get_gui_height();
var x1, x2, y1, y2;

var width=0;

//Define coordinates to draw at
x1=0;
x2=screenwidth;
y1=screenheight-hudheight*global.helpbar; //global.helpbar is 0 if turned off
y2=screenheight;

//These are annoyingly variable local to the input grabbing object
//^ What the fuck does that comment mean?
var keyboard=1;

//Let's start by drawing a box
//Jk haha lets draw a sprite instead
/*
draw_set_colour(c_black);
draw_rectangle(x1,y1,x2,y2,0);*/
/*Commenting out - no outline
draw_set_colour(c_white);
draw_rectangle(x1,y1,x2,y2,1);*/

//Draw the hearts
var i, xdraw, ydraw, subimg;
xdraw=16;
if (global.hpposition==POSITION.TOPLEFT)
	ydraw=24;
else
	ydraw=y1-24;
	
var inst=global.currentinstance;
var sprite=spr_heart;
if (global.difficulty==DIFFICULTY.EXTRAEASY)
	sprite=spr_weenie;

//Draw health bar but we don't want that on the setup screens
//Also don't draw it if we're paused
if (!scr_is_disallowed_room(room) and !global.hardpause)
	{
		if (inst.hp==HP.INF)
			draw_sprite(spr_infheart,0,xdraw,ydraw);	//draw infinite heart
		else if (inst.hpmax==0)
			draw_sprite(sprite,1,xdraw,ydraw);
		else
			for (i=0;i<inst.hpmax;i+=1)
				{
					subimg=inst.hp<=i;
					draw_sprite(sprite,subimg,xdraw+20*i,ydraw);
				}
	}


//If the HUD bar is off we exit here
if (global.helpbar==false)
	exit;
	
//draw_sprite(spr_HUD_box,0,x1,y1);
var sprwidth=sprite_get_width(spr_HUD_box);
var repeats=ceil(480/sprwidth); //I know this is 120 but whatever
for (var i=0; i<repeats; i+=1)
	draw_sprite(spr_HUD_box,0,x1+sprwidth*i, y1);

var surfacereplaced=false;
if (!surface_exists(HUD_surf))
	{
		HUD_surf=surface_create(maxwidth*2,hudheight);
		surfacereplaced=true;
	}
	
//Drawing to surface
surface_set_target(HUD_surf);

draw_clear_alpha(0,0);

xdraw=16;
var surfaceresize=0;
var textoffset=6; //How many pixels to shift text to the left
repeat(2)
	{
		var text, textwidth, sprite, repeats;
		ydraw=hudheight/2;
		width=16;

		//Set up font
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_font(global.font);
		for (i=0;i<ds_grid_width(global.tipsgrid);i+=1)
			{
				//Break conditions
				if global.tipsgrid[# i,HUDTips.BUTTON]=-1
					{
						break;
					}
		
				//Drawing
				if global.input=keyboard
					{
						//First we see if it's a sprite we've predefined
						sprite=scr_return_kb_sprite(global.tipsgrid[# i,HUDTips.BUTTON]);
						if sprite!=-1
							{
								draw_sprite(sprite,-1,xdraw,ydraw);
								//Advance xdraw position
								//This is consistent with the drawing below
								xdraw+=40; //This is sprite width (24) +16 for text
								//Then draw the accompanying text
								draw_set_color(c_white);
								text=global.tipsgrid[# i,HUDTips.TEXT];
								textwidth=string_width(text);
								draw_text(xdraw+textwidth/2-textoffset,ydraw,text);
								xdraw+=textwidth+24;
								width+=textwidth+64;
							}
						else
							{
								//Okay we get the width of the text
								//We divide that by 8 and round up
								//This gives us how many keyboard 'middles' to draw
								//Then we draw the keyboard 'middles' that many times
								//Then draw the text over the top
								var buttontext=scr_string_keycheck(global.tipsgrid[# i,HUDTips.BUTTON]);
								textwidth=string_width(buttontext);
								repeats=ceil(textwidth/8);
								draw_sprite(spr_keyboardedge,-1,xdraw,ydraw);
								var j=0;
								for (j=0;j<repeats;j+=1)
									{
										draw_sprite(spr_keyboardmiddle,-1,xdraw+8*(j+1),ydraw);
									}
								draw_sprite(spr_keyboardedgeright,-1,xdraw+8*(j+1),ydraw);
								draw_set_color(c_black);
								//The xdraw position is xdraw+ 1/2 the size of the sprites drawn
								//(Because a standard keyboard key sprite width is 24)
								draw_text(xdraw+12+(repeats-1)*4,ydraw,buttontext);
								//draw_text(xdraw+12+(repeats-1)*4,ydraw,scr_string_keycheck(global.tipsgrid[# i,HUDTips.BUTTON]),0.5,0.5,0);
								//Advance xdraw position
								xdraw+=32+8*j;
								//Then draw the accompanying text
								draw_set_color(c_white);
								text=global.tipsgrid[# i,HUDTips.TEXT];
								textwidth=string_width(text);
								draw_text(xdraw+textwidth/2-textoffset,ydraw,text);
								xdraw+=textwidth+24;
								//Update width - Future Ed here - WHAT THE FUCK DOES THIS MEAN WHAT DOES IT MEAN WHY IS IT SO STUPID
								//Widths - the width of the keyboard sprite, i.e. 16+repeats*8
								//The xdraw position is advanced 16, so +16
								//Then finally the textwidth, +24
								width+=16+repeats*8;
								width+=16;
								width+=textwidth;
								width+=24;
								/*Saving this stupid shit incase I need it (I won't)
								width+=12+(repeats-1)*4;
								width+=32+8*j;
								width+=textwidth+24;*/
							}
					}
				else
					{
						//Urgh sorry for this confusing function
						//We convert the tip button to its equivalent gamepad button then get the sprite for that button
						sprite=scr_return_gp_sprite(scr_keyboard_to_gamepad(global.tipsgrid[# i,HUDTips.BUTTON]));
						draw_sprite(sprite,-1,xdraw,ydraw);
				
						//Advance drawing location to draw text
						xdraw+=32;
						draw_set_color(c_white);
						text=global.tipsgrid[# i,HUDTips.TEXT];
						textwidth=string_width(text);
						draw_text(xdraw+textwidth/2-textoffset,ydraw,text);
						xdraw+=textwidth+24;
						width+=32;
						width+=textwidth+24;
					}
				
			}
			
		//If width of drawing exceeds the bounds of the box we start to marquee, else we break the repeat loop as it is unecessary
		//Surface replaced variable is because the surface ceases to exist when you change from full screen etc
		if width-24>maxwidth and (marquee=0 or surfacereplaced=true)
			{
				marquee=1;
				surfaceresize=1;
			}
		else if width-24<=maxwidth
			{
				marquee=0;
				surf_x=0;
				break;
			}
		xdraw=width;
		//Why is it width-40? I don't actually know lol haha :D
		if abs(surf_x)=width-16
			{
				surf_x=0;
			}
	}
	
surface_reset_target();

//Arbitrary resize but sufficiently large
if surfaceresize=1
	{
		surface_resize(HUD_surf,width*2,hudheight);
	}

//Now draw the surface
draw_surface(HUD_surf,surf_x,y1);