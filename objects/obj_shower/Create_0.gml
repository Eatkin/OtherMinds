/// @description init variables lol obviously

event_inherited();

active=false;
label=scr_return_text(246);
showeron=false;
showertimer=0;
shadertimer=0;

//Shader stuff
f=shader_get_uniform(shd_ripple,"freq");
a=shader_get_uniform(shd_ripple,"amp");
t=shader_get_uniform(shd_ripple,"timer");

//Fog stuff
fogalpha=0;
maxfogalpha=0.8;
steam[0]=instance_create_layer(264,160,"Lighting",obj_steam);
steam[1]=instance_create_layer(240,152,"Lighting",obj_steam);
steam[1].sprite_index=spr_steam2;
steam[2]=instance_create_layer(268,144,"Lighting",obj_steam);
steam[2].sprite_index=spr_steam3;

showerimg=0;

shower_sound=snd_shower;