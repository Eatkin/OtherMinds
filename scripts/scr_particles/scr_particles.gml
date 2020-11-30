//created 29/04/20
//Last updated 29/04/20

//This let's us reset the system for exxample, when gravity inverts
if (part_system_exists(global.partSys))
	part_system_destroy(global.partSys);

global.partSys=part_system_create();
part_system_depth(global.partSys,0);
global.atmPartSys=part_system_create();

var gravMultiplier=(global.gravdirection==90)	?	1	:	-1;

//Create a flashing pixel particle for collectible objects (or interactibles)
//These just 'glint' in various shades of grey->white
var partPixel=part_type_create();
part_type_shape(partPixel,pt_shape_pixel);
part_type_size(partPixel,1,4,-0.1,0);
part_type_alpha2(partPixel,1,0);
part_type_colour_hsv(partPixel,0,0,0,0,180,255);
part_type_life(partPixel,60,180);
global.collectibleParticle=partPixel;

var partSage=part_type_create();
part_type_shape(partSage,pt_shape_pixel);
part_type_size(partSage,1,2,0,0);
part_type_alpha2(partSage,1,0);
part_type_colour_hsv(partSage,120,144,66,255,100,245);
part_type_life(partSage,1,20);
part_type_speed(partSage,1,2,0,0);
part_type_direction(partSage,265*gravMultiplier,275*gravMultiplier,0,1);
global.sageParticle=partSage;

var crumblePart=part_type_create();
part_type_shape(crumblePart,pt_shape_pixel);
part_type_size(crumblePart,1,1,0,0);
part_type_alpha2(crumblePart,1,1);
part_type_colour_hsv(crumblePart,0,0,0,0,115,180);
part_type_life(crumblePart,60,240);
part_type_gravity(crumblePart,global.gravstrength*0.5,270*gravMultiplier);
global.crumbleParticle=crumblePart;

var partOrb=part_type_create();
part_type_shape(partOrb,pt_shape_pixel);
part_type_size(partOrb,1,2,0,0);
part_type_alpha2(partOrb,1,0);
part_type_colour_rgb(partSage,255,255,255,255,255,255); //Pure white
part_type_life(partOrb,1,60);
part_type_speed(partOrb,1,2,0,0);
part_type_direction(partOrb,265*gravMultiplier,275*gravMultiplier,0,1);
global.orbParticle=partOrb;

var partSaw=part_type_create();
part_type_shape(partSaw,pt_shape_pixel);
part_type_size(partSaw,1,3,-0.2,0);
part_type_alpha2(partSaw,1,0);
part_type_colour_rgb(partSaw,162,255,48,121,0,48); //Rusty orange
part_type_life(partSaw,30,120);
part_type_speed(partSaw,1,3,0,0);
part_type_direction(partSaw,10,80,0,0);
part_type_gravity(partSaw,global.gravstrength*0.5,270*gravMultiplier);
global.sawParticle=partSaw;

//Now we'll use this for the laz0rs
var partLaser=part_type_create();
part_type_shape(partLaser,pt_shape_pixel);
part_type_size(partLaser,1,3,-0.2,0);
part_type_alpha2(partLaser,1,0);
part_type_colour_rgb(partLaser,141,176,179,223,204,255);
part_type_life(partLaser,50,200);
part_type_speed(partLaser,1,3,0,0);
part_type_direction(partLaser,60,120,0,0);
part_type_gravity(partLaser,global.gravstrength*0.5,270*gravMultiplier);
global.laserParticle=partLaser;

//Smoke effect for smoke explosions
var partSmoke=part_type_create();
part_type_shape(partSmoke,pt_shape_pixel);
part_type_size(partSmoke,1,4,-0.2,0);
part_type_alpha2(partSmoke,1,0);
part_type_colour_rgb(partSmoke,0,162,0,162,0,162); //This should vary from black to grey probably
part_type_life(partSmoke,10,200);
part_type_speed(partSmoke,0,4,0,0);
part_type_direction(partSmoke,60*gravMultiplier,120*gravMultiplier,0,0);
part_type_gravity(partSmoke,global.gravstrength*0.5,270*gravMultiplier);
global.smokeParticle=partSmoke;

//Dust for Ed
var partDust=part_type_create();
part_type_shape(partDust,pt_shape_pixel);
part_type_size(partDust,1,2,0,0);
part_type_alpha2(partDust,1,0);
part_type_colour_rgb(partDust,143,248,119,248,0,248); //Should be white to brown probably
part_type_life(partDust,10,50);
part_type_speed(partDust,0,2,0,0);
part_type_direction(partDust,80*gravMultiplier,100*gravMultiplier,0,0);
part_type_gravity(partDust,global.gravstrength*0.5,270*gravMultiplier);
global.dustParticle=partDust;

//Torch fires
var partTorch=part_type_create();
part_type_shape(partTorch,pt_shape_pixel);
part_type_size(partTorch,1,2,-0.01,0);
part_type_alpha2(partTorch,1,0);
part_type_colour_rgb(partTorch,162,178,16,48,0,48);
part_type_life(partTorch,10,200);
part_type_gravity(partTorch,global.gravstrength*0.5,270*gravMultiplier);
global.torchParticle=partTorch;

//Bobbing platforms
var partPlat=part_type_create();
part_type_shape(partPlat,pt_shape_pixel);
part_type_size(partPlat,1,3,0,0);
part_type_alpha2(partPlat,1,0);
part_type_colour_hsv(partPlat,0,0,0,0,0,161);
part_type_life(partPlat,10,180);
part_type_gravity(partPlat,global.gravstrength*0.5,270*gravMultiplier);
global.platformParticle=partPlat;

//Honey platforms
var partHoney=part_type_create();
part_type_shape(partHoney,pt_shape_pixel);
part_type_size(partHoney,1,3,0,0);
part_type_alpha2(partHoney,1,0);
part_type_colour_rgb(partHoney,209,235,145,184,29,33);
part_type_life(partHoney,10,180);
part_type_gravity(partHoney,global.gravstrength*0.5,270*gravMultiplier);
global.honeyParticle=partHoney;

//Repeat with ochre particle
var partDirt=part_type_create();
part_type_shape(partDirt,pt_shape_pixel);
part_type_size(partDirt,1,3,0,0);
part_type_alpha2(partDirt,1,0);
part_type_colour_rgb(partDirt,54,105,32,63,0,0);
part_type_life(partDirt,10,180);
part_type_gravity(partDirt,global.gravstrength*0.5,270*gravMultiplier);
global.dirtParticle=partDirt;

//Gloop splat
var partGloop=part_type_create();
part_type_shape(partGloop,pt_shape_pixel);
part_type_size(partGloop,1,3,-.01,0);
part_type_alpha2(partGloop,1,0);
part_type_colour_rgb(partGloop,255,255,255,255,255,255); //Pure white
part_type_life(partGloop,60,180);
part_type_speed(partGloop,1,4,0,0);
part_type_gravity(partGloop,global.gravstrength*0.5,270*gravMultiplier);
global.gloopParticle=partGloop;

//Worm digging
var partDig=part_type_create();
part_type_shape(partDig,pt_shape_pixel);
part_type_size(partDig,1,3,-.01,0);
part_type_alpha2(partDig,1,0);
part_type_colour_rgb(partDig,54,105,32,63,0,0);
part_type_life(partDig,60,180);
part_type_speed(partDig,1,4,0,0);
part_type_direction(partDig,70*gravMultiplier,110*gravMultiplier,0,0);
part_type_gravity(partDig,global.gravstrength,270*gravMultiplier);
global.digParticle=partDig;

var atmPart=part_type_create();
part_type_shape(atmPart,pt_shape_pixel);
part_type_size(atmPart,1,5,-0.01,0);
part_type_alpha3(atmPart,0,1,0);
part_type_colour_rgb(atmPart,255,255,255,255,255,255);
part_type_life(atmPart,60,600);
part_type_speed(atmPart,-1,1,0,0);
part_type_direction(atmPart,-20,20,0,1);
global.atmParticle=atmPart;