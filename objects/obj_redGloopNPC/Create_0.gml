/// @description Creation script
// You can write your code in this editor
event_inherited();

scr_gloop_create_new();

splatColour=c_red;

stopping=false; //This is the only behaviour variable I need

//Same as the regular gloop but lets update a few variables
name=scr_return_text(716);
scr_bio(scr_return_text(717),scr_return_text(718),spr_chilli_idle); //That sprite only exists for the bio lol
maxxspeed=2; //Twice as fast!
dashspeed=maxxspeed*3; //Redeclare this!
powerlevel=1;
hp=1;
hpmax=1;
jumpheight=-6;
dashenabled=true;
sprite_dash=spr_gloop_dashing;
sound_dash=snd_dash;

//Change stuff
canhurtenabled=false;
canbehurtenabled=false;

hasdialogue=true;

//Now set up his dialogue
text[0]=scr_return_text(712);
text[1]=scr_return_text(713);
text[2]=scr_return_text(714);
text[3]=scr_return_text(715);

var d_min=0;
var d_max=3;

scr_dialoguemap_init(d_min,d_max);