/// @description Creation code
// You can write your code in this editor

event_inherited();

healthregen=-1;
regenrate=600;
if global.difficulty=DIFFICULTY.EXTRAEASY
	{
		healthregen=regenrate; //10 seconds to regen a heart
	}
else
	{
		healthregen=-1;
	}

scr_intrinsic_variables(scr_return_text(475),0.05,3,1,4,7,1,true,global.Edhealth); //HP doesn't matter because Ed is controlled seperately
scr_modules_init();

if (global.attract==false)
	{
		hpmax=scr_return_adjusted_hpmax();
		hp=clamp(hp,-1,hpmax);
		global.Edhealth=hp;
	}
else
	{
		global.Edhealth=2;
		hp=global.Edhealth;
		hpmax=global.Edhealth;
	}

scr_bio(scr_return_text(476), scr_return_text(477),spr_charlotte_idle);

state=PlayerState.idle;

//Other stuff
/*pushspeed=1;
ledgextranslation=14;
ledgeytranslation=32;*/

#region sprites
sprite_idle=spr_charlotte_idle;
sprite_duck=spr_charlotte_lookdown;
sprite_run=spr_charlotte_walk;
sprite_air=spr_charlotte_air;
sprite_lookup=spr_charlotte_lookup;
//sprite_cliff=spr_Ed_cliff;
//sprite_cliffbackwards=spr_Ed_cliffbackwards;
sprite_blink=spr_charlotte_blink;
sprite_waiting=spr_charlotte_waiting;
sprite_defeated=spr_charlotte_idle; //Can only die by falling off cliff
sprite_push=sprite_idle; //We set pushspeed to 0 so she doesn't run against walls
sprite_carried=sprite_idle;
#endregion

#region masks
masknormal=spr_charlotte_mask;
maskduck=masknormal;
#endregion

#region sounds
sound_jump=snd_jump;
sound_jumponenemy=snd_jumponenemy;
sound_hurt=snd_hurt;
sound_regen=snd_heart_regen;
#endregion

//Variable for foot tapping
//sound_on=false;


scr_snap_to_floor();

#region modules
jumpenabled=true;
lookupenabled=true;
duckenabled=true;
gravityenabled=true;
canbehurtenabled=true;
enemiesattackenabled=true;
smoothaccelerationenabled=true;
//cliffedgeenabled=true;
blinkingenabled=true;
offscreenmarkerenabled=true;
talkenabled=true;
runenabled=true;
jumpattackenabled=true;
//shoesenabled=true;
moveoffscreenenabled=true;
waitinganimationenabled=true;
waitingtimeoutenabled=true;
pushingenabled=true;
#endregion

/*
//Now an array of harmful objects
harmful[0]=obj_spikes;
harmful[1]=obj_boss_laser;
harmful[2]=obj_boss_widelaser;
harmful[3]=obj_deadlyhoney_hurtmask;*/

//Array of interactable objects - only doors
interactable[0]=obj_door;

//Text - this is initial text after EdSpace 1
text[0]=scr_return_text(478);
text[1]=scr_return_text(479);
text[2]=scr_return_text(480);
//After rescuing cats
text[3]=scr_return_text(481);
text[4]=scr_return_text(482);
text[5]=scr_return_text(483);
//Text for after you complete day one jobs
text[6]=scr_return_text(620);
text[7]=scr_return_text(621);
text[8]=scr_return_text(622);
text[9]=scr_return_text(623);
text[10]=scr_return_text(624);
//Day two dialogue
text[11]=scr_return_text(848);
text[12]=scr_return_text(849);
text[13]=scr_return_text(850);
text[14]=scr_return_text(851);
text[15]=scr_return_text(852);
text[16]=scr_return_text(853);

var _min=0;
var _max=2;
if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.RESCUEDCATS))
	{
		_min=3;
		_max=5;
	}
//Night time
if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.PASSTWO))
	{
		_min=6;
		_max=10;
	}
//Day two - actually uses a different enum since pass three only happens when you leave the house -_-
if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.VIEWEDPASSTWOCUTSCENE))	{
	_min=11;
	_max=16;
}
	
scr_dialoguemap_init(_min,_max);

//Idle behaviour
walking=false;

pushspeed=0;