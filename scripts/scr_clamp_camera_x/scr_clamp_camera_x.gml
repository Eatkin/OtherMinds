//Created 15/08/19
//Last update 15/08/19

//Just keeps camera within bounds
var camwidth=camera_get_view_width(camera);
var camx=argument0;

//Clamp, add shake, re-clamp
camx=clamp(camx,0,room_width-camwidth);
camx+=scr_sign_nonzero(random(2)-1)*random(shakex);

//Also alter angle using max of shakex/shakey
var angleVariation=max(shakex,shakey);
var viewAngle=random(angleVariation)-angleVariation*0.5;
camera_set_view_angle(camera,viewAngle);
return clamp(camx,0,room_width-camwidth);