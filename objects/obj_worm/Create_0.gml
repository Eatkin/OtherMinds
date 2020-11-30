/// @description Creation script
// You can write your code in this editor
event_inherited();

scr_intrinsic_variables(scr_return_text(367),0.1,1,1,10,0,1,false,1);
scr_bio(scr_return_text(368),scr_return_text(369),spr_worm_idlerun);
scr_modules_init();

splatColour=c_purple;

state=PlayerState.idle;

#region sprites
sprite_run=spr_worm_idlerun;
sprite_idle=spr_worm_idlerun;
sprite_air=spr_worm_air;
sprite_defeated=spr_worm_defeated;
sprite_slideoffcliff=spr_worm_offcliff;
sprite_splat=spr_worm_splat;
sprite_carried=spr_worm_carried;
sprite_predig=spr_worm_predig;
sprite_digging=spr_worm_dig;
sprite_postdig=spr_worm_postdig;
#endregion

#region masks
//I don't think I can do this by subimage so urgh
masknormal=spr_worm_mask;
#endregion


#region sounds
sound_splat=snd_foot_tap;
sound_hurt=snd_hurt;
sound_dig=snd_drag;
#endregion

scr_snap_to_floor();

#region modules
runenabled=true;
gravityenabled=true;
//xscaleflipenabled=false;
imagespeedequalsdirenabled=true;
staticidleanimationenabled=true;
canbehurtenabled=true;
canhurtenabled=true;
respawnenabled=false;
splatenabled=true;
slideoffcliffenabled=true;
digenabled=true;
#endregion

directionfacing=1;

//digging stuff
digspeed=2;
digdirection=0.5*pi;
digstate=-1;

//Few variables for moving the enemy
attackdirection=1;
enemymoving=false;

harmful[0]=obj_spikes;