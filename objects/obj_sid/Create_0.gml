/// @description Creation script
// You can write your code in this editor
event_inherited();

scr_intrinsic_variables(scr_return_text(610),0.1,1,1,10,5,0,true,1);
scr_bio(scr_return_text(611),scr_return_text(612),spr_snake_run);
scr_modules_init();

state=PlayerState.idle;

#region sprites
sprite_run=spr_snake_run;
sprite_defeated=spr_snake_defeated;
sprite_idle=spr_snake_idle;
sprite_air=spr_snake_jump;
sprite_blink=spr_snake_blink;
sprite_lookup=spr_snake_lookup;
sprite_duck=spr_snake_duck;
sprite_dash=spr_snake_dash;
	
//Randomise starting frame
image_index=irandom_range(0,image_number);
#endregion

#region masks
masknormal=spr_snake_mask;
#endregion

#region sounds
sound_hurt=snd_hurt;
sound_jump=snd_jump;
sound_jumponenemy=snd_jumponenemy;
sound_dash=snd_dash;
#endregion

scr_snap_to_floor();

#region modules
runenabled=true;
gravityenabled=true;
jumpenabled=true;
blinkingenabled=true;
lookupenabled=true;
duckenabled=true;
dashenabled=true;
respawnenabled=false;
#endregion

//Now an array of harmful objects
harmful[0]=obj_spikes;


//Dialogue
text[0]=scr_return_text(613);
text[1]=scr_return_text(614);
text[2]=scr_return_text(615);
text[3]=scr_return_text(616);
var _min=0;
var _max=3;
scr_dialoguemap_init(_min,_max);