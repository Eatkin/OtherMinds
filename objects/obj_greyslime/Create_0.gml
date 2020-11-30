/// @description Creation script
// You can write your code in this editor
event_inherited();

scr_gloop_create_new();

splatColour=c_gray;

stopping=false; //This is the only behaviour variable I need

//Same as the regular gloop but lets update a few variables
name=scr_return_text(312);
scr_bio(scr_return_text(313),scr_return_text(314),spr_greyslime); //That sprite only exists for the bio lol

powerlevel=1;
jumpheight=-6;
maxxspeed=2;
walljumpenabled=true;
maskwall=masknormal;
sprite_onwall=spr_gloop_onwall;