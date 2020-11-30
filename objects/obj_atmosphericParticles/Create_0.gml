/// @description

//This should be a function of room size
//200 per screen-area maybe
maxParticles=200;
var particleMultiplyer=(room_width*room_height)/(480*270);
maxParticles*=particleMultiplyer;
maxParticles=round(maxParticles);
particleColour=c_white;