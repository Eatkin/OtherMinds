/// @description Creation script
// You can write your code in this editor
event_inherited();

//Jumpheight -5
//Should be faster
//All names and descriptions need changing, "A slippery customer"
//Also short to do list - need to do the air sprites controller too
//Also need some way of tracking the snakes defeated
scr_intrinsic_variables(scr_return_text(556),0.1,1,1,10,5,0,0,0);
scr_bio(scr_return_text(557),scr_return_text(558),spr_snake_run);
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
canbehurtenabled=true;
canhurtenabled=true;
jumpenabled=true;
jumpattackenabled=true;
blinkingenabled=true;
lookupenabled=true;
duckenabled=true;
dashenabled=true;
respawnenabled=false;
#endregion

//Now an array of harmful objects
harmful[0]=obj_spikes;


scr_add_inv_heart();


//AI stuff
stopping=false;
turnaroundtimer=0;
turnaroundtimermax=60;