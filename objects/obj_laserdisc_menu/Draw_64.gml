/// @description

if !surface_exists(diarysurface)
	{
		diarysurface=surface_create(menuwidth,menuheight);
	}
if (!surface_exists(imagesurface))
	{
		var imagesize=134;
		imagesurface=surface_create(imagesize,imagesize);
	}
	
//Set up font variables
draw_set_colour(c_white);
draw_set_font(global.font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

surface_set_target(diarysurface)

draw_clear_alpha(0,0);
//Starting position for drawing
var h_spacing=8;
var v_spacing=18;
var text_x=h_spacing*2;
var text_y=6-menu_yoffset; //Standard starting position
//Aanyway lets draw the text now woo hoo
var i;
var extralines=0;
var arraylength=array_height_2d(destinations);
for (i=0; i<arraylength;i+=1)
	{
		if counter!=0
			{
				var text=destinations[i,0];
				text=scr_string_multiline(text,menuwidth-h_spacing*3);
				draw_text(text_x,text_y+v_spacing*(i+extralines),text);
				extralines+=string_count("\n",text);
				var spr=spr_cross;
				if (destinations[i,6]==true)
					{
						spr=spr_tick;
					}
				var textheight=string_height(text);
				draw_sprite(spr,0,menuwidth-h_spacing-sprite_get_width(spr),text_y+v_spacing*(i+extralines)+textheight*0.5);
			}
	}
	
//NOW HERE WE DRAW THE CURSOR AND SCROLLBAR!!!
var palette=scr_select_UI_palette();
scr_set_palette_swap_shader(spr_UI_palette,palette,true);
var textheight=string_height("A");
draw_sprite(spr_menucursor,0,text_x-h_spacing,menu_cursor_y+text_y+textheight*0.5-2);

//I do not know how this works, but it sure does work so fuck it
if counter>8
	{
		var scrollbarsize=menuheight-24;
		//Now we need to scale the scroll bar depending how many rows there are
		scrollbarsize=scrollbarsize*(1/max(1,counter-4));
		var scrollbarypos=12;
		var scrollbarposmax=menuheight-24-scrollbarsize;
		scrollbarypos+=(menu_y_selection/counter)*scrollbarposmax;
		var movement=lerp(menu_scrollbar_pos,scrollbarypos,0.1)-menu_scrollbar_pos;
		movement=sign(movement)*max(1,abs(movement));
		menu_scrollbar_pos+=movement;
		if abs(menu_scrollbar_pos-scrollbarypos)<=1
			{
				menu_scrollbar_pos=scrollbarypos;
			}
		draw_sprite_ext(spr_scrollbar,0,menuwidth-h_spacing*2,menu_scrollbar_pos,1,scrollbarsize/sprite_get_height(spr_scrollbar),0,c_white,1);
	}
surface_reset_target();

draw_sprite(spr_pausemenuthindoublewidth,0,menu_x,menu_y);


//Now we can draw the image surface
surface_set_target(imagesurface)
draw_sprite(spr_leveliconborder,0,0,0);
shader_reset();
var imagedrawoffset=3;
if (image_displaying==noone)
	{	
		shader_set(shd_noise);
		var _t=shader_get_uniform(shd_noise,"time");
		shader_set_uniform_f(_t,random(1));
		draw_sprite(spr_edspace_zone1,0,imagedrawoffset,imagedrawoffset);
		shader_reset();
	}
else
	{
		draw_sprite(image_displaying,0,imagedrawoffset,imagedrawoffset);
		//Draw times
		var xpos=imagedrawoffset+3;
		var ypos=imagedrawoffset+3;
		scr_draw_text_outlined(xpos,ypos,scr_return_text(444));
		ypos+=v_spacing;
		scr_draw_text_outlined(xpos,ypos,destinations[menu_y_selection,3]);
		ypos+=v_spacing;
		scr_draw_text_outlined(xpos,ypos,scr_return_text(445));
		ypos+=v_spacing;
		scr_draw_text_outlined(xpos,ypos,destinations[menu_y_selection,4]);
		ypos+=v_spacing;
		scr_draw_text_outlined(xpos,ypos,scr_return_text(446));
		ypos+=v_spacing;
		scr_draw_text_outlined(xpos,ypos,destinations[menu_y_selection,5]);
	}
surface_reset_target();

draw_surface(diarysurface,menu_x,menu_y);
draw_surface(imagesurface,image_surfx,image_surfy);