/// @description Creation script
// You can write your code in this editor
event_inherited();

scr_gloop_create_new();

splatColour=c_red;

stopping=false; //This is the only behaviour variable I need

//Same as the regular gloop but lets update a few variables
name=scr_return_text(307);
scr_bio(scr_return_text(308),scr_return_text(309),spr_chilli_idle); //That sprite only exists for the bio lol
maxxspeed=2; //Twice as fast!
dashspeed=maxxspeed*3; //Redeclare this!
powerlevel=1;
hp=1;
hpmax=1;
jumpheight=-6;
dashenabled=true;
sprite_dash=spr_gloop_dashing;
sound_dash=snd_dash;

//AI stuff
turnaroundtimer=0;
turnaroundtimermax=60;