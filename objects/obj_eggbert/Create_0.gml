/// @description Creation script
// You can write your code in this editor
event_inherited();

scr_intrinsic_variables(scr_return_text(337),0.1,1,1,10,0,0,false,0);
scr_bio(scr_return_text(338),scr_return_text(339),spr_eggbertstatic);
scr_modules_init();

state=PlayerState.idle;

#region sprites
sprite_run=spr_eggbertidlerun;
sprite_idle=spr_eggbertidlerun;
sprite_air=spr_eggbertair;
#endregion

#region masks
//I don't think I can do this by subimage so urgh
masknormal=spr_eggbertmask;
#endregion

#region sounds
sound_impact=snd_foot_tap;
#endregion

scr_snap_to_floor();
image_index=0;

#region modules
runenabled=true;
gravityenabled=true;
staticidleanimationenabled=true;
xscaleflipenabled=false;
imagespeedequalsdirenabled=true;
canbehurtenabled=true;
impactsoundenabled=true;
#endregion

directionfacing=1;

//Todo list
scr_add_todo(0,scr_return_text(472),scr_return_text(473),localtodo);
scr_todo_discover(0,localtodo);