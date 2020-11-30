/// @description Intrinsic variable set up etc
// You can write your code in this editor

event_inherited();

scr_modules_init();
scr_gloop_create_new();

canbehurtenabled=false;
canhurtenabled=false;
teleportenabled=true;

//Boring stuff
//Keep Augustine a level 1 character. I'll leave an exit after the death door
//Then the player is free to come back and play whichever route they didn't take
//^Actually it just goes in a loop back to room 1
scr_intrinsic_variables(scr_return_text(159),0.1,1,1,10,6,1,1,HP.INF);
scr_bio(scr_return_text(140),scr_return_text(141),spr_augustinesleep);

splatColour=c_green;

directionfacing=-1;

//Dialogue
//This is used for rolling for dialogue
text[0]=scr_return_text(317);
text[1]=scr_return_text(318);
text[2]=scr_return_text(319);
text[3]=scr_return_text(320);
text[4]=scr_return_text(321);
text[5]=scr_return_text(485);
text[6]=scr_return_text(486);
text[7]=scr_return_text(487);
text[8]=scr_return_text(488);
text[9]=scr_return_text(489);
text[10]=scr_return_text(627);
text[11]=scr_return_text(628);
text[12]=scr_return_text(629);

text[13]=scr_return_text(843);
text[14]=scr_return_text(844);
text[15]=scr_return_text(845);
text[16]=scr_return_text(846);
text[17]=scr_return_text(847);
var _min=0;
var _max=4;

if (global.rng==2)
	{
		instance_create_layer(0,0,layer,obj_darkness);
		_min=5;
		_max=9;
	}

//Night time
if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.PASSTWO))
{
	_min=10;
	_max=12;
}

//Day two
if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.PASSTHREE))	{
	_min=13;
	_max=17;
}
	
scr_dialoguemap_init(_min,_max);

//Some shit for the alt dialogue
for (var i=7; i<=9; i+=1)
	{
		textread[i]=false;
	}

scr_add_todo(0,scr_return_text(322),scr_return_text(323),localtodo);
scr_add_todo(1,scr_return_text(324),scr_return_text(325),localtodo);
scr_todo_fail(0,localtodo);
scr_todo_discover(1,localtodo);