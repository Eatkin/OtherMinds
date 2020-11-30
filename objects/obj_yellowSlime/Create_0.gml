/// @description Creation script
// You can write your code in this editor
event_inherited();

scr_gloop_create_new();

splatColour=c_yellow;

seenPlayer=false;
playerRange=200;

//Same as the regular gloop but lets update a few variables
name=scr_return_text(671);
scr_bio(scr_return_text(672),scr_return_text(673),spr_yellowSlime);
powerlevel=1;
hp=1;
hpmax=1;
gravityFlipEnabled=true;
jumpenabled=false;
respawnenabled=false;
moveoffscreenenabled=true;

sprite_gravityFlip=spr_gravityFlip;