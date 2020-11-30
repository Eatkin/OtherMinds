/// @description draw 9-slice + text
//Draw end so ALWAYS on top

var palette=scr_select_UI_palette();
scr_set_palette_swap_shader(spr_UI_palette,palette,false);

//Drwa from 9slice
for (var i=0; i<hrepeats; i+=1)
	for (var j=0; j<vrepeats; j+=1)	{
		//Bitmasking bollocks
		var tileOffset=0;
		if (i>0)
			tileOffset|=8;
		if (i<hrepeats-1)
			tileOffset|=2;
		if (j>0)
			tileOffset|=1;
		if (j<vrepeats-1)
			tileOffset|=4;
			
		draw_sprite_part(sprite_index,image_index,tileOffset*16,0,16,16,x+i*16,y+j*16);
	}
	
shader_reset();



//Keys with column alignment:
/*Eg
Jump					z
Poop					x
*/
//Draw all options and find LH columntext alignment
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_colour(c_white);
var len=array_length_1d(option);
var maxLength=0;
for (var i=0; i<len; i+=1)	{
	draw_text(x+32,y+32+16*i,option[i]);
	maxLength=max(maxLength,string_width(option[i]));
}

var hoffset=ceil(2+maxLength/16)*16;



//Header after so we don't have to do too many alignment switches unnecessarily
draw_set_halign(fa_center);
draw_text(x+hrepeats*8,y+16,headerText);


//Draw key sprites
//Final option is restore defaults so we loop from 0->(len-1)
for (var i=0; i<len-1; i+=1)	{
	var key;
	#region find the key (warning: boring)
	switch(i)	{
		case 0:
			key=global.kb_b_one;
			break;
		case 1:
			key=global.kb_b_two;
			break;
		case 2:
			key=global.kb_b_four;
			break;
		case 3:
			key=global.kb_b_three;
			break;
		case 4:
			key=global.kb_left;
			break;
		case 5:
			key=global.kb_right;
			break;
		case 6:
			key=global.kb_up;
			break;
		case 7:	
			key=global.kb_down;
			break;
		case 8:
			key=global.kb_l_one;
			break;
		case 9:
			key=global.kb_r_one;
			break;
		}
		#endregion
	
	var xx=x+hoffset
	var yy=y+32+16*i;
		
	if (global.input==1)	{		//Keyboard sprites
		var sprite=scr_return_kb_sprite(key);			//This returns sprite index or -1
		if (sprite!=-1)
			draw_sprite(sprite,0,xx,yy);
		else	{
			//Manually draw
			var buttontext=scr_string_keycheck(key);
			var textwidth=string_width(buttontext);
			var repeats=ceil(textwidth/8);
			draw_sprite(spr_keyboardedge,-1,xx,yy);
			
			for (var j=0;j<repeats;j+=1)
				draw_sprite(spr_keyboardmiddle,-1,xx+8*(j+1),yy);
				
			draw_sprite(spr_keyboardedgeright,-1,xx+8*(j+1),yy);
			//The xdraw position is xdraw+ 1/2 the size of the sprites drawn
			draw_set_colour(c_black);
			draw_text(xx+12+(repeats-1)*4,yy,buttontext);
		}
	}
	else	{						//GP sprites
		var gpIndex=scr_keyboard_to_gamepad(key);
		var sprite=scr_return_gp_sprite(gpIndex);
		draw_sprite(sprite,0,xx,yy);
	}
	
	}

//Alignment reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);


var chevronOffset=4*(dsin(chevronTimer)-1);
draw_sprite(spr_menuChevron,0,chevronX+chevronOffset,chevronY-5);		//-5 accounts for sprite height