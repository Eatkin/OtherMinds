/// @description
// You can write your code in this editor


//This just skips language select screen for now because Deutsch isn't updated fully!

room_goto(rm_splash);

//Texts
language[0]="English";
language[1]="Deutsch";
options=array_length_1d(language);

v_spacing=18;

menucool=0;
menucoolmax=10;
menu_y=0;
cursor_y=room_height*0.5-options*v_spacing*0.5;
cursor_x=(room_width-string_width(language[menu_y]))*0.5-8;
selectedanitem=false;