/// @description Creation script
// You can write your code in this editor
event_inherited();



var _xspeed=4;
if (scr_return_difficulty()<=DIFFICULTY.EASY)
	{
		_xspeed-=1;
	}
scr_intrinsic_variables(scr_return_text(411),0.5,3,_xspeed,3,2,1,false,7);
scr_bio(scr_return_text(412),scr_return_text(413),spr_hep_bee);
scr_modules_init();

state=PlayerState.bee;

#region sprites
//No sprites
sprite_defeated=spr_hep_bee_defeated; //Temporary, we will later program proper behaviour
#endregion

#region masks
masknormal=mask_index;
#endregion

#region sounds
sound_hurt=snd_hurt;
#endregion

//scr_snap_to_floor(); //Not necessary for flying bee

#region modules
gravityenabled=true;
canhurtenabled=true;
canbehurtenabled=true;
respawnenabled=false;
fallwhendefeatedenabled=true;
shootingenabled=true;
moveoffscreenenabled=true;
#endregion

directionfacing=1;

harmful[0]=obj_spikes;

//Shooting
guncooldown=0;
guncooldownmax=60;
gunrecoil=2;
//Offsets for where to create bullets (multiplied by directionfacing of course)
gunxoffset=14;
gunyoffset=14;

//Behaviours
patrolling=true; //Patrolling left and right for first phase
patroldir=1;
//targetting=false; //Picking somewhere to target to shoot at Ed
shooting=false; //Has picked target and now preparing to shoot
swooping=false;
inhoney=false;

phasetwotimer=120;
phasethreetimer=120;

gainoverride=0.7;

if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.HEP_BEE_DEFEATED))
	instance_destroy();
	
//Add the bee canon to inventory
//Bee cannon
scr_inventory_add_ref(obj_gunfall,scr_return_text(827),1,spr_beeCannon,scr_return_text(828),localinventory);