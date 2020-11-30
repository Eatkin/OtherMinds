/// @description

var cam=view_camera[0];
var camy=camera_get_view_y(cam);
//Use this to set everything to fade out as we scroll down
var alphaMultiply=1-camy/270;

draw_set_alpha(alphaMultiply);
draw_sprite(spr_logo,0,room_width*0.5,64);

draw_set_halign(fa_middle);
draw_set_alpha(anyKeyAlpha*alphaMultiply);
scr_draw_text_outlined(room_width*0.5,140,text);
draw_set_alpha(1);