/// @description

if (global.hardpause==true)
	{
		image_speed=0;
		exit;
	}
	
event_inherited();

if (soundplaying==noone)
	{
		scr_play_sound(snd_saw,true,0);
	}
	
var speedtarget=0;
var _minx=0;
if (dir=-1)
	{
		_minx=xstart-xbound;
	}
var _maxx=room_width;
if (dir=1)
	{
		_maxx=xstart+xbound;
	}
if (x==clamp(x,_minx,_maxx))
	{
		speedtarget=maxspeed*dir;
	}
else
	{
		speedtarget=0;
	}
	
xspeed=lerp(xspeed,speedtarget,0.05);
if (abs(xspeed-speedtarget)<0.5)
	{
		xspeed=speedtarget;
		if (xspeed==0)
			{
				dir=-dir;
			}
	}

//Set image speed and move
image_speed=xspeed/max(1,maxspeed);
image_speed=min(1,image_speed);

repeat(abs(ceil(xspeed)))
	{
		x+=sign(xspeed);
	}

//Update the spike positions
myspikes.x=bbox_left;
myspikes.y=bbox_top;

//Pitch
pitchoverride=0.5+0.5*abs(xspeed/max(1,maxspeed));
audio_sound_pitch(soundplaying,pitchoverride);

//Vibration
scr_set_proximity_vib(96,0.5,0.7);


//Destroy out room, but make sure far enough away to ensure we don't notice noise suddenly stops
if (x!=clamp(x,-room_width*0.2,room_width*1.2))
	{
		instance_destroy();
		instance_destroy(myspikes);
	}
	

//Particles
//Prob is 0 at xspeed=0 and 1 at xspeed=maxspeed
if (scr_on_camera()==true)
	{
		//Origin is top centre
		var xx=x-(sprite_width*0.5-abs(xspeed))*sign(xspeed);
		var yy=y+sprite_height;
		//Set particle direction correctly. Check me out using a ternery operator.
		var dirmin=(sign(xspeed)==1) ? 100 : 10;
		var dirmax=(sign(xspeed)==1) ? 170 : 80;
		var partNumber=xspeed/max(maxspeed,1);
		partNumber*=2;
		partNumber=floor(abs(partNumber));
		part_type_direction(global.sawParticle,dirmin,dirmax,0,0);
		part_particles_create(global.partSys,xx,yy,global.sawParticle,partNumber);
	}