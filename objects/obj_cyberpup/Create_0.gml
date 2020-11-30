/// @description Creation script
// You can write your code in this editor
event_inherited();

petting=instance_create_layer(x,y,layer,obj_petcyberpup);

scr_intrinsic_variables(scr_return_text(427),0.1,1,2,5,6,1,true,3);
scr_bio(scr_return_text(428),scr_return_text(429),spr_cyberpupwaiting);
scr_modules_init();

state=PlayerState.idle;

#region sprites
sprite_run=spr_cyberpuprun;
sprite_idle=spr_cyberpupidle;
sprite_air=spr_cyberpupair;
sprite_waiting=spr_cyberpupwaiting;
sprite_defeated=spr_cyberpupdefeated;
//sprite_cliff=spr_eggbertcliff;
//sprite_cliffbackwards=spr_eggbertcliffbackwards;
#endregion

#region masks
//I don't think I can do this by subimage so urgh
masknormal=spr_cyberpupmask;
#endregion

#region sounds
sound_jump=snd_jump;
sound_hurt=snd_hurt;
sound_jumponenemy=snd_jumponenemy;
#endregion

scr_snap_to_floor();

#region modules
runenabled=true;
gravityenabled=true;
jumpenabled=true;
waitinganimationenabled=true;
//waitingtimeoutenabled=true;
//cliffedgeenabled=true;
canbehurtenabled=true;
canhurtenabled=true;
jumpattackenabled=true;
#endregion

directionfacing=1;

text[0]=scr_return_text(430);
text[1]=scr_return_text(431);
text[2]=scr_return_text(433);

var _min=0;
var _max=2;

scr_dialoguemap_init(_min,_max);

harmful[0]=obj_spikes;