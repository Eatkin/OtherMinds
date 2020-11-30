/// @description
// You can write your code in this editor

//game_end();

//Texts
//Header text
header[0]=scr_return_text(524);
header[1]=scr_return_text(525);
header[2]=scr_return_text(526);

option[0]=scr_return_text(527);
//option[1]=scr_return_text(528);
option[1]=scr_return_text(529);
option[2]=scr_return_text(530);
//option[4]=scr_return_text(531);

options=array_length_1d(option);

v_spacing=16;

menucool=0;
menucoolmax=10;
menu_y=0;
cursor_y=room_height*0.5-options*v_spacing*0.5;
cursor_x=(room_width-string_width(option[menu_y]))*0.5-8;