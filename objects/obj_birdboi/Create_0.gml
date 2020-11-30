/// @description Creation script
// You can write your code in this editor
event_inherited();

scr_intrinsic_variables(scr_return_text(354),0.1,1,3,3,2,1,false,1);
scr_bio(scr_return_text(355),scr_return_text(356),spr_birdboiflyin);
scr_modules_init();

state=PlayerState.idle;

#region sprites
sprite_run=spr_birdboirun
sprite_idle=spr_birdboiidle
sprite_air=spr_birdboiflyin;
sprite_carrying=spr_birdboicarrying;
sprite_defeated=spr_birdboidefeated;
sprite_cliff=spr_birdboicliff;
sprite_cliffbackwards=spr_birdboicliffbackwards;
sprite_lookup=spr_birdboi_lookup;
sprite_duck=spr_birdboi_duck;
#endregion

#region masks
//I don't think I can do this by subimage so urgh
masknormal=spr_birdboimask;
maskair=spr_birdboiairmask;
maskduck=spr_birdboiduckmask;
#endregion

#region sounds
sound_jump=snd_jump;
sound_hurt=snd_hurt;
sound_flap=snd_birdflap;
#endregion

//scr_snap_to_floor(); //Not necessary for flying bird boi

#region modules
runenabled=true;
gravityenabled=true;
jumpenabled=true;
birdmodeenabled=true;
canbehurtenabled=true;
airmaskenabled=true;
cliffedgeenabled=true;
lookupenabled=true;
duckenabled=true;
#endregion

directionfacing=-1;

flyingtoeggbert=false;

soundemitter=noone;

//Anchor points for carrying items etc
anchorx=11-sprite_get_xoffset(mask_index);
anchorx=sprite_width*0.5-sprite_get_xoffset(mask_index);
anchory=35-sprite_get_yoffset(mask_index);
carrying=noone;
carrytarget=noone;
carryweight=0;
carryingdepth=0;

carryable[0]=parent_main_character;
carryable[1]=parent_possessable;
carryable[2]=parent_push;

harmful[0]=obj_spikes;
harmful[1]=obj_cannon_ball;