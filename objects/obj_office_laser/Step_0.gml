/// @description

if (global.hardpause==true)
	{
		image_speed=0;
		exit;
	}
	
//If not activated
instance_activate_object(myspikes);
instance_activate_object(myemitter);
	
var speedtarget=0;
var _minx=0;
if (dir=-1)
	{
		_minx=xstart-xbound;
	}
var _maxx=room_width;
if (dir==1)
	_maxx=xstart+xbound;
if (x==clamp(x,_minx,_maxx))
	speedtarget=maxspeed*dir;
else
	speedtarget=0;
	
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
image_speed=max(1,image_speed);

x+=xspeed;
	
//Bounds of the laser
for (var i=0; i<room_height/16; i+=1)
	{
		if (place_meeting(x,y+16*i,obj_solid) or place_meeting(x,y+16*i,obj_semisolid))
			{
				vrepeats=i;
				break;
			}
	}
	
if (!instance_exists(myemitter))
	{
		myemitter=instance_create_layer(x,y,layer,obj_sound_emitter);
		myemitter.soundid=snd_shower;
		myemitter.mode=EMITTER.LOOP;
		myemitter.pitchoverride=0.2
	}
	
if (vrepeats==0)
	{
		myspikes.x=-1000;
		myspikes.y=-1000;
		scr_object_resize(myspikes,6,1);
		myemitter.x=x;
		myemitter.y=y;
		//Vibration
		scr_set_proximity_vib(96,0.5,0.7);
	}
else
	{
		myspikes.x=x-3;
		myspikes.y=y+16;
		scr_object_resize(myspikes,6,(vrepeats-1)*16);
		with (myspikes)
			{
				//Vibration
				scr_set_proximity_vib(96,0.5,0.7);
			}
		myemitter.x=x;
		myemitter.y=parent_main_character.y;
		myemitter.y=clamp(myemitter.y,y,y+16*vrepeats);
	}
	
//Destroy out room, but make sure far enough away to ensure we don't notice noise suddenly stops
if (x!=clamp(x,-room_width*0.2,room_width*1.2))
	{
		instance_destroy();
		instance_destroy(myspikes);
		instance_destroy(myemitter);
	}
	
if (scr_on_camera()==true and irandom(2)==0)
	{
		//Origin is top centre
		var xx=x-(sprite_width*0.5-abs(xspeed))*sign(xspeed);
		var yy=y+vrepeats*16;
		//Randomly choose a number
		var partNumber=irandom(4);
		part_particles_create(global.partSys,xx,yy,global.laserParticle,partNumber);
	}
	
//My spikes collisions - this triggers bombs to explode
with (myspikes)
	{	
		//y+1 is VERY IMPORTANT
		var bomb=instance_place(x,y+1,obj_bomb_block);
		if (bomb!=noone)
			bomb.exploding=true;
	}
		