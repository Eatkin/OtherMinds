/// @description Insert description here
// You can write your code in this editor

event_inherited();

var _bossHp=2;
if (scr_return_difficulty()>=DIFFICULTY.HARD)
	{
		_bossHp+=1;
	}
if (scr_return_difficulty()<=DIFFICULTY.EASY)
	{
		_bossHp-=1;
	}
scr_intrinsic_variables(scr_return_text(170),0.05,3.5,3,9,10.5,1,0,_bossHp);
scr_modules_init();

state=PlayerState.idle;

scr_bio(scr_return_text(171),scr_return_text(172) ,spr_drdeath_idle);

//Sprites
sprite_idle=spr_drdeath_idle;
sprite_duck=spr_drdeath_duck;
sprite_run=spr_drdeath_run;
sprite_air=spr_drdeath_air;
sprite_push=spr_drdeath_push;
sprite_lookup=spr_drdeath_lookup;
sprite_ledgehold=spr_drdeath_ledgehold;
sprite_cliff=spr_drdeath_cliff;
sprite_cliffbackwards=spr_drdeath_cliffbackwards;
sprite_blink=spr_drdeath_blink;
sprite_waiting=spr_drdeath_laugh;
sprite_defeated=spr_drdeath_defeated;

//Masks
masknormal=spr_drdeathmask;
maskduck=spr_drdeathmaskhalf;

//Sounds
sound_jump=snd_jump;
sound_hurt=snd_hurt;
sound_jumponenemy=snd_jumponenemy;

#region modules
jumpenabled=true;
lookupenabled=true;
duckenabled=true;
gravityenabled=true;
canbehurtenabled=true;
smoothaccelerationenabled=true;
cliffedgeenabled=true;
waitinganimationenabled=true;
waitingtimeoutenabled=true;
blinkingenabled=true;
dustenabled=true;
runenabled=true;
jumpattackenabled=true;
ledgegrabenabled=true;
pushingenabled=true;
respawnenabled=false;
jumponedenabled=true;
offscreenmarkerenabled=true;
moveoffscreenenabled=true;
#endregion

//Now an array of harmful objects
harmful[0]=obj_spikes;

directionfacing=-1;

//Triggers for behaviour

bossstarted=false;
landedonplatform=false;
firingalaser=false;
laserfiretimer=0;
timeonbutton=0;
targetplatform=noone;
targettinged=false;
targettingplatform=true;
died=false;
	
scr_add_todo(0,scr_return_text(173),scr_return_text(174), localtodo);
scr_todo_discover(0,localtodo);
if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.COLLECTEDMASTERPLAN)=0
	{
		scr_inventory_add_ref(obj_masterplan,scr_return_text(175),1,spr_masterplan,scr_return_text(176),localinventory);
	}
	
if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.BOSSDEFEATED)
	{
		instance_destroy();
	}