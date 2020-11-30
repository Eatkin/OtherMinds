/// @description Intrinsic variable set up etc
// You can write your code in this editor

event_inherited();

scr_modules_init();
scr_gloop_create_new();

splatColour=c_green;


canbehurtenabled=false;
canhurtenabled=false;
teleportenabled=true;

//Boring stuff
//Keep Augustine a level 1 character. I'll leave an exit after the death door
//Then the player is free to come back and play whichever route they didn't take
//^Actually it just goes in a loop back to room 1
scr_intrinsic_variables(scr_return_text(159),0.1,1,1,10,6,1,true,HP.INF);
scr_bio(scr_return_text(140),scr_return_text(141),spr_augustinesleep);

directionfacing=-1;

//Dialogue
//This is used for rolling for dialogue
dialogueprevious=-1;
//Standard dialogue
text[0]=scr_return_text(142);
text[1]=scr_return_text(143);
text[2]=scr_return_text(144);
text[3]=scr_return_text(145);
text[4]=scr_return_text(146);
//Dialogue for when dropped off cliff
text[5]=scr_return_text(147);
text[6]=scr_return_text(148);
//Alt dialogue for when you've taken the key
text[7]=scr_return_text(149);
//EdSpace 7 dialogue
text[8]=scr_return_text(424);
text[9]=scr_return_text(425);
text[10]=scr_return_text(426);
//Aalpha levels dialogue
text[11]=scr_return_text(752);
text[12]=scr_return_text(753);

//Set dialogue boundaries
var d_min=0;
var d_max=4;
//If we have the green key
if (scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.COLLECTEDGREENKEY)==true)
	{
		d_min=7;
		d_max=7;
	}
//If we are in EdSpace1_7
if (room==rm_EdSpace1_6)
	{
		d_min=8;
		d_max=10;
	}

if (room==room_EdSpace1_1)	{
	d_min=11;
	d_max=12;
}
scr_dialoguemap_init(d_min,d_max);
thrownoffcliff=false;
//dialogueread=0;
/*
if (room==room_EdSpace1_7)
	{
		text[0]=scr_return_text(424);
		text[1]=scr_return_text(425);
		text[2]=scr_return_text(426);
	}*/

scr_add_todo(0,scr_return_text(150),scr_return_text(151),localtodo);
scr_add_todo(1,scr_return_text(152),scr_return_text(153),localtodo);
scr_todo_discover(1,localtodo);

//Augustine is holding a key
if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.COLLECTEDGREENKEY)=0
	{
		scr_todo_discover(0,localtodo);
		scr_inventory_add_ref(obj_key_green,scr_return_text(154),1,spr_key_green,scr_return_text(155),localinventory);
	}
else
	{
		scr_todo_fail(0,localtodo);
	}