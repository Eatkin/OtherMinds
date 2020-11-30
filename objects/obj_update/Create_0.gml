/// @description

text="";
//This is completely unused, dunno why I even put it there lololol
texttodraw="Checking for updates";

var url="https://www.something.com/"
get=http_get(url);

state=UPDATESTATE.CHECKING;

version=global.currentversion;
changelogurl="";
downloadlink="";

//Texts
header[0]=scr_return_text(532);
header[1]=scr_return_text(533);

option[0]=scr_return_text(534);
option[1]=scr_return_text(535);
option[2]=scr_return_text(536);
options=array_length_1d(option);

v_spacing=18;

menucool=0;
menucoolmax=10;
menu_y=0;
cursor_y=room_height*0.5-options*v_spacing*0.5;
cursor_x=(room_width-string_width(option[menu_y]))*0.5-8;
selectedanitem=false;

if (os_is_network_connected()==false)
	state=UPDATESTATE.FAILED;

//It just looks like the game's hung if there's a slow internet connection
timeoutMax=120;
alarm[0]=timeoutMax;

destination=rm_splash;	//Set where we go after this room