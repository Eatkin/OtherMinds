/// @description states
// You can write your code in this editor

event_inherited();

maxspeed=3;

//Pop some new text here please!!!
scr_intrinsic_variables(scr_return_text(414), 0.02, 1, 3, 3, 0, 0, 0, 0);
scr_bio(scr_return_text(415), scr_return_text(416),spr_beeball);
scr_modules_init();

state=PlayerState.freeflying;

#region sprites
sprite_freeflying=sprite_index;
sprite_defeated=sprite_index;
sprite_carried=sprite_index;
#endregion

#region masks
masknormal=mask_index;
#endregion

#region sounds
sound_explode=snd_bullet_fire;
#endregion

#region modules
freeflyingenabled=true;
explodeenabled=true;
fallwhendefeatedenabled=true;
canbehurtenabled=true;
canhurtenabled=true;
decelerationenabled=false;
//moveenabled=false;
manualscalingenabled=true;
explodeonwallsenabled=true;
moveoffscreenenabled=true;
#endregion

owner=instance_place(x,y,obj_boss_cannon);
state=PlayerState.freeflying;

scr_play_sound(snd_bee_buzz,true,0);
pitchoverride=2;