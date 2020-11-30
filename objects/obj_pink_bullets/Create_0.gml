/// @description states
// You can write your code in this editor

owner=instance_place(x,y,obj_boss_cannon);
event_inherited();

maxspeed=3;

scr_intrinsic_variables(scr_return_text(239), 0.02, 1, 3, 3, 0, 0, 0, 0);
scr_bio(scr_return_text(240), scr_return_text(241),spr_bullet_pink);
scr_modules_init();

state=PlayerState.freeflying;

#region sprites
sprite_freeflying=spr_bullet_pink;
sprite_defeated=spr_bullet_pink;
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
//fallwhendefeatedenabled=true;
reversewhendefeatedenabled=true;
canbehurtenabled=true;
canhurtenabled=true;
decelerationenabled=false;
interactwithblocksenabled=false;
//moveenabled=false;
manualscalingenabled=true;
#endregion

owner=instance_place(x,y,obj_boss_cannon);
state=PlayerState.freeflying;
xspeed=-3;