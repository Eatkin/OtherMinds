/// @description Creation script
// You can write your code in this editor
event_inherited();

scr_intrinsic_variables(scr_return_text(337),0.1,1,1,5,6,1,true,1);
scr_bio(scr_return_text(344),scr_return_text(339),spr_eggberthatched_idle);
scr_modules_init();

state=PlayerState.idle;

#region sprites
sprite_run=spr_eggberthatched_run;
sprite_idle=spr_eggberthatched_idle;
sprite_air=spr_eggbert_jump;
sprite_waiting=spr_eggbert_peck;
sprite_carried=spr_eggbert_carried;
sprite_cliff=spr_eggbertcliff;
sprite_cliffbackwards=spr_eggbertcliffbackwards;
sprite_defeated=sprite_air;
#endregion

#region masks
//I don't think I can do this by subimage so urgh
masknormal=spr_eggberthatchedmask;
#endregion

#region sounds
sound_jump=snd_jump;
sound_hurt=snd_hurt;
#endregion

scr_snap_to_floor();

#region modules
runenabled=true;
gravityenabled=true;
jumpenabled=true;
waitinganimationenabled=true;
waitingtimeoutenabled=true;
cliffedgeenabled=true;
canbehurtenabled=true;
#endregion

directionfacing=1;

text[0]=scr_return_text(345);
text[1]=scr_return_text(346);
text[2]=scr_return_text(467);
text[3]=scr_return_text(468);
text[4]=scr_return_text(469);
text[5]=scr_return_text(470);
text[6]=scr_return_text(471);
text[7]=scr_return_text(423);
text[8]=scr_return_text(500);
text[9]=scr_return_text(501);
text[10]=scr_return_text(630);
text[11]=scr_return_text(631);
text[12]=scr_return_text(632);
text[13]=scr_return_text(633);
text[14]=scr_return_text(838);
text[15]=scr_return_text(839);
text[16]=scr_return_text(840);
text[17]=scr_return_text(841);
text[18]=scr_return_text(842);

var _min=0;
var _max=1;

if (global.rng==1)
	{
		_min=2;
		_max=6;
	}

//Night time
if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.PASSTWO))
	{
		_min=10;
		_max=13;
	}

//Day two
if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.PASSTHREE))	{
	_min=14;
	_max=18;
}

//This is Eggbert's RNG event before Hep Bee, but he doesn't show up if the boss is already dead so no need to worry about it
if (room==rm_ochrehill_7)
	{
		_min=7;
		_max=9;
	}
	
scr_dialoguemap_init(_min,_max);

sound_on=false; //For pecking

//Todo list
scr_add_todo(0,scr_return_text(472),scr_return_text(473),localtodo);
scr_todo_complete(0,localtodo);