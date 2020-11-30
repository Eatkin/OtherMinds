/// @description Creation script
// You can write your code in this editor
event_inherited();

scr_intrinsic_variables(scr_return_text(364),0.1,1,1,10,0,1,false,1);
scr_bio(scr_return_text(365),scr_return_text(366),spr_apple_idlerun);
scr_modules_init();

state=PlayerState.idle;

#region sprites
sprite_run=spr_apple_idlerun;
sprite_idle=spr_apple_idlerun;
sprite_air=spr_apple_idlerun;
sprite_defeated=spr_apple_defeated;
sprite_carried=spr_apple_static;
#endregion

#region masks
//I don't think I can do this by subimage so urgh
masknormal=spr_applemask;
#endregion

#region sounds
sound_impact=snd_foot_tap;
sound_hurt=snd_hurt;
#endregion

scr_snap_to_floor();

#region modules
runenabled=true;
gravityenabled=true;
xscaleflipenabled=false;
imagespeedequalsdirenabled=true;
staticidleanimationenabled=true;
canbehurtenabled=true;
canhurtenabled=true;
impactsoundenabled=true;
#endregion

directionfacing=1;

//Few variables for moving the enemy
enemymoving=true;
myworm=noone;

harmful[0]=obj_spikes;

scr_add_inv_heart();