/// @description

event_inherited();

if (global.hardpause==true)
	{
		image_speed=0;
		exit;
	}
image_speed=1;
	
if (soundplaying==noone)
	{
		scr_play_sound(snd_shower,true,0);
	}
	
var player=parent_main_character;
var x1=x;
var y1=y;
var x2=player.x;
var y2=player.y;

var dir=arctan2(y2-y1,x2-x1);

var dist=distance_to_object(player);
var maxdist=270;
if (dist<maxdist)
	{
		spd=lerp(spd,maxspeed*min(1,(0.1+dist/maxdist)),0.1);
	}
else
	{
		spd=lerp(spd,maxspeed,0.1);
	}
	
//Now move

var xspd=spd*cos(dir);
var yspd=spd*sin(dir);

x+=xspd;
y+=yspd;

//Prarticleskfdjadsfdsa fuck off
var particleNumber=irandom(1)*irandom(1);
if particleNumber>0
	{
		var particleColour=choose(c_purple,c_black);
		var xx=random(sprite_width)-sprite_xoffset;
		var yy=random(sprite_height)-sprite_yoffset;
		part_particles_create_colour(global.partSys,x+xx,y+yy,global.orbParticle,particleColour,particleNumber);
	}