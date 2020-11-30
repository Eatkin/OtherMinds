/// @description Insert description here
// You can write your code in this editor

var _layer=layer_get_id("players");
depth=layer_get_depth(_layer)-1;


//Okay these have origin top left
//They are also rotated to arbitrary angles, so we must consider that
var xx=x-sprite_width*0.25+random(sprite_width*0.5);
var yy=y-sprite_height*0.25+random(sprite_height*0.5);
part_particles_create(global.partSys,xx,yy,global.smokeParticle,irandom(15));