/// @description layy Mlao
// You can write your code in this editor

/*We draw the first menu - gamepad type with < and > as applicable and the type name
Then Just use keyboard
Then underneath have a graphic of keyboard or gamepad

Draw second menu
It's a list of difficulties
A description displays underneath with an associated symbol
*/
//First menu

//Backing to the text
var menuSprite=spr_controlSetupMenu;
var menuyOffset=30;
draw_sprite(menuSprite,0,240,135+v_spacing*0.5-menuyOffset); //Centre aligned + a bit

//The difficulty menu too (it's centred)
draw_sprite(spr_difficultyMenu,0,720,135-menuyOffset);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var highlightcolour=make_colour_rgb(235,211,31);


//Nested for loops to draw because I'm a smart ass lololol
for (var j=0; j<2; j+=1)
	{
		var xdraw=240+j*480; //Half screen width
		var ydraw=135-(maxSelection[j]-j)*v_spacing*0.5-menuyOffset; //-j because it's -1 for menu 1, but not for menu 0
		for (var i=0; i<=maxSelection[j]; i+=1)
			{
				if (selection[j]==i)
					{
						draw_set_colour(highlightcolour);
					}
				draw_text(xdraw,ydraw+v_spacing*i*(2-j),menuText[i,j]);
				if (selection[j]==i)
					{
						draw_set_colour(c_white);
					}
				//Extra text for gamepad
				if (j==0 and i==0)
					{
						//Two spaces so it stays spaced properly
						var gamepadText="  ";
						if (global.gamepadtype>0)
							{
								gamepadText="< ";
							}
						gamepadText=gamepadText+scr_return_text(51+global.gamepadtype);
						if (global.gamepadtype<2)
							{
								gamepadText=gamepadText+" >";
							}
						draw_text(xdraw,ydraw+v_spacing,gamepadText);
					}
			}
	}


//Draw gamepad or keyboard outlined, depending on what is selected
var outlinedsprite=(selection[0]==0) ? spr_gamepad : spr_keyboard;
shader_set(shd_outline);
var w=shader_get_uniform(shd_outline,"pixelwidth");
var h=shader_get_uniform(shd_outline,"pixelheight");
var _tex = sprite_get_texture(outlinedsprite,0);
var tex_width = texture_get_texel_width(_tex);
var tex_height = texture_get_texel_height(_tex);
var whitesprite=shader_get_uniform(shd_outline,"whitesprite");
shader_set_uniform_f(whitesprite,false);
shader_set_uniform_f(w,tex_width);
shader_set_uniform_f(h,tex_height);

var x1=190;
var x2=290;
var y1=210;
draw_sprite(spr_gamepadContainer,0,240,y1);
if (selection[0]==0)
	{
		draw_sprite(spr_gamepad,0,x1,y1);
		shader_reset()
		draw_sprite(spr_keyboard,0,x2,y1);
	}
else
	{
		draw_sprite(spr_keyboard,0,x2,y1);
		shader_reset()
		draw_sprite(spr_gamepad,0,x1,y1);
	}
	
//Now draw cursors
for (var i=0; i<2; i+=1)
	{
		var xdraw=240+i*480;
		var ydraw=135-(maxSelection[i]-i)*v_spacing*0.5-menuyOffset;
		draw_sprite(spr_menucursor,0,xdraw+cursor[i,0],ydraw+cursor[i,1]-2);
	}
	
//And FINALLY draw the difficulty blurb
//Choose the heart sprite to draw
var sprite;
var sprindex=0;
switch(selection[1])
	{
		case DIFFICULTY.EXTRAEASY:
			{
				sprite=spr_weenie;
				break;
			}
		case DIFFICULTY.EASY:
			{
				sprite=spr_heart_plusone;
				break;
			}
		case DIFFICULTY.NORMAL:
			{
				sprite=spr_heart;
				break;
			}
		case DIFFICULTY.HARD:	
			{
				sprite=spr_heart_minusone;
				break;
			}
		case DIFFICULTY.EXTRAHARD:
			{
				sprite=spr_heart;
				sprindex=1;
				break;
			}
														
	}

//Draw above the difficulty menu
var spry=135-(maxSelection[1]-1)*v_spacing*0.5-v_spacing-menuyOffset;
draw_sprite(sprite,sprindex,720-sprite_get_width(sprite)*0.5,spry-sprite_get_height(sprite));

//Draw the container for difficulty blurb
var difficultyBlurbBack=spr_dialogue_box;
var backWidth=sprite_get_width(difficultyBlurbBack);
var backHeight=sprite_get_height(difficultyBlurbBack);
var menuX=720-backWidth*0.5;
var menuY=185;
draw_sprite(difficultyBlurbBack,0,menuX,menuY);



if (difficultySurface==noone or !surface_exists(difficultySurface))
	{
		var surfWidth, surfHeight;
		surfWidth=backWidth;
		surfHeight=backHeight*5; //1 for each difficulty
		difficultySurface=surface_create(surfWidth, surfHeight);
		
		surface_set_target(difficultySurface);
		//Draw text on the surface
		//This will be moved to a surface eventually which means it will only need to be drawn once
		draw_set_font(global.font);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		draw_set_colour(c_white);
		var maxWidth=backWidth-8
		var textHeight=string_height("A")-1;		//Minus 1 to squeeze it a little smaller
		var blurbSeperation=backHeight;
		for (var i=0; i<=maxSelection[1]; i+=1)
			{
				var difficultyBlurb=menuText[i,2];
				draw_text_ext(4,4+blurbSeperation*i,difficultyBlurb,textHeight,maxWidth);
			}
		surface_reset_target();
	}
	
//Now we've define the surface let's focus on the relevant part and draw it
difficultySurfY=lerp(difficultySurfY,backHeight*selection[1],0.2);
if (abs(difficultySurfY-backHeight*selection[1])<2)
	{
		difficultySurfY=backHeight*selection[1];
	}
	
//Draw the surface
draw_surface_part(difficultySurface,4,difficultySurfY+4,backWidth-8,backHeight-8,menuX+4,menuY+4);