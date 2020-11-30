/// @description states
// You can write your code in this editor

event_inherited();

maxspeed=3;

//Pop some new text here please!!!
scr_intrinsic_variables(scr_return_text(297), 0.02, 1, 6, 6, 0, 0, 0, 0);
scr_bio(scr_return_text(298), scr_return_text(299),spr_bullet);
scr_modules_init();

state=PlayerState.freeflying;

#region sprites
sprite_freeflying=spr_bullet;
sprite_defeated=spr_bullet;
sprite_carried=spr_bullet;
#endregion

#region masks
masknormal=sprite_index;
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
interactwithsemisolidsenabled=false;
#endregion

owner=instance_place(x,y,obj_boss_cannon);
state=PlayerState.freeflying;