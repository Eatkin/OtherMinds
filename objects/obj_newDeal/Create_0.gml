/// @description

// Inherit the parent event
event_inherited();

scr_intrinsic_variables(scr_return_text(590),0.1,1,2,10,6,1,true,2);
scr_bio(scr_return_text(591),scr_return_text(592),spr_newDealRun);
scr_modules_init();

state=PlayerState.idle;

#region sprites
sprite_waiting=spr_newDealWaiting;
sprite_run=spr_newDealRun;
sprite_idle=spr_newDealIdle;
sprite_air=spr_newDealJump;
sprite_blink=spr_newDealBlink;
sprite_push=spr_newDealIdle;		//Makes it so he doesn't walk into walls
sprite_lookup=spr_newDealLookup;
sprite_duck=spr_newDealLookdown;
#endregion

#region masks
//I don't think I can do this by subimage so urgh
masknormal=mask_index;
maskduck=mask_index;
#endregion

#region sounds
sound_hurt=snd_hurt;
sound_jump=snd_jump;
sound_jumponenemy=snd_jumponenemy;
#endregion

scr_snap_to_floor();

#region modules
runenabled=true;
gravityenabled=true;
canbehurtenabled=true;
canhurtenabled=true;
waitinganimationenabled=true;
waitingtimeoutenabled=true;
jumpenabled=true;
jumpattackenabled=true;
blinkingenabled=true;
pushingenabled=true;
lookupenabled=true;
duckenabled=true;
#endregion

pushspeed=0;

//Dialogue
//Aka CODING HELL

/*
593-596 is the initial chatter about getting incriminating evidence
682->685 is for the master plan stuff
597->600 is the rest

Triggers:
We view the first 3 sections of text (593->596) then trigger dig up dirt event
If we talk again we see 682->685
If we have the memo then this extends and adds 597->600
*/

//So here we add initial text, simple
for (var i=0; i<4; i+=1)
	text[i]=scr_return_text(593+i);

//Set bounds
var _min=0;
var _max=3;

//Then we add text for master plan
for (var i=0; i<4; i+=1)
	text[i+4]=scr_return_text(682+i);

//We then go and add the final text about the memo
for (var i=0; i<4; i+=1)
	text[i+8]=scr_return_text(597+i);


//If we have the master plan our max gets set to 7
if (scr_inventory_check(obj_masterplan) and !scr_event_check_complete(global.officeevents,OFFICEEVENTS.NEWDEALMASTERPLAN))
	_max=7;
	
//If we have the memo, it gives us extra dialogue so extend _max AGAIN
if (scr_inventory_check(obj_memo_collect))
	_max=11;


//If we've already handed over the note, we don't want to repeat ourselves
if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.NEWDEALDIALOGUECOMPLETE))
	_min=_max;

scr_dialoguemap_init(_min,_max);

//Add the to-dos
scr_add_todo(1,scr_return_text(608),scr_return_text(609),localtodo);
scr_todo_discover(1,localtodo);

//Behaviour stuff
walking=false;
walkingDir=0;
outsidePatrol=false;

helloIAmTalking=false;		//Lol stupid variable