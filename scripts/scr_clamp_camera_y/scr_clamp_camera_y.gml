//Created 15/08/19
//Last update 15/08/19

//Just keeps camera within bounds and accounts for HUD box
var camy=argument0;
var camheight=camera_get_view_height(camera);
var HUD_height=sprite_get_height(spr_HUD_box)*global.helpbar;
var zoom=camheight/thecamheight; //This is actually the recipricol of zoom and I'm not changing it because I'm fuckin dumb

var HUDdrawn=true;
if following!=noone
	{
		if following!=global.currentinstance
			{
				HUDdrawn=false;
			}
	}

if ds_queue_empty(global.dialoguequeue)=false
	{
		HUDdrawn=false;
	}

HUD_height=HUD_height*HUDdrawn;

//Clamp, add shake, reclamp
camy=clamp(camy,0,room_height-camheight+HUD_height*zoom);
camy+=scr_sign_nonzero(random(2)-1)*random(shakey);
return clamp(camy,0,room_height-camheight+HUD_height*zoom);