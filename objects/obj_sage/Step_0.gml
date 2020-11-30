/// @description Step script
// You can write your code in this editor
event_inherited();

if global.hardpause=true
	{
		image_speed=0;
		exit;
	}
else
	{
		image_speed=1;
	}

//Particles

if (irandom(20)==0)
	{
		var xx=random(sprite_width)-sprite_width*0.5;
		part_particles_create(global.partSys,x+xx,y,global.sageParticle,1);
	}
//A load of bloat
//Lower the gain
gainoverride=max(0,gainoverride-0.02);
	
//Save the xscale, we will overwrite this later but we need scale to be 1 for collissions
var _xscale=image_xscale;
var _yscale=image_yscale;
image_xscale=1;
image_yscale=1;

//Paths - yes lets try not to do two paths every frame please
var nearest=instance_nearest(x,y,parent_possessable);
var x_target=nearest.x+nearest.sprite_width/2-nearest.sprite_xoffset;
var y_target=nearest.y+nearest.sprite_height/2-nearest.sprite_yoffset

pathavailable=mp_grid_path(sage_grid,sage_path,x,y,x_target,y_target,true);
if path_get_length(sage_path)>possessionrange
	{
		pathavailable=0;
	}

if nearest.state=PlayerState.defeated or nearest.state=PlayerState.dead
	{
		pathavailable=0;
	}
	
with (parent_possessable)
	{
		outlineshader=false;
	}
if pathavailable!=0
	{
		if nearest!=noone
			{
				nearest.outlineshader=true;
			}
	}
	
if myemitter!=noone
	{
		if !instance_exists(myemitter)
			{
				myemitter=noone;
			}
		else
			{
				myemitter.x=x;
				myemitter.y=y;
			}
	}
	
//This needs to go at the end so the path is defined before the step event
scr_states_step();

//Updates xscale after all collision checks
image_xscale=_xscale;
image_yscale=_yscale;
if (image_xscale!=1 or image_yscale!=1) and state!=PlayerState.possessing and returntoedcounter=0
	{
		image_xscale+=0.05*sign(1-image_xscale);
		image_yscale+=0.05*sign(1-image_yscale);
		if image_xscale=clamp(image_xscale,0.95,1.05)
			{
				image_xscale=1;
				image_yscale=1;
			}
	}
	//Manually set the image scale for possessing state
if state=PlayerState.possessing and state!=previousstate
	{
		var dist=distance_to_object(target);
		if myemitter=noone
			{
				myemitter=instance_create_layer(x,y,"controllers",obj_sound_emitter);
				myemitter.soundid=snd_sage_enter;
				myemitter.mode=EMITTER.FADEOUT;
			}
		var image_scale;
		image_scale=min(1,0.1+dist/64)
		image_xscale=lerp(image_xscale,image_scale,0.2);
		image_yscale=lerp(image_yscale,image_scale,0.2);
	}
	
//Hold V (or whatever) to return to Ed instantly
scr_set_canmove();
var holdingb_two=0;
if canmove=true
	{
		holdingb_two=global.inputs[17];
	}
if holdingb_two=true and state!=PlayerState.possessing
	{
		//Stop as well
		xspeed=0;
		yspeed=0;
		if returntoedcounter=0
			{
				var emitter=instance_create_layer(x,y,"players",obj_sound_emitter)
				emitter.soundid=snd_speedup;
			}
		returntoedcounter+=1;
		var scale=1+.4*(returntoedcounter/30);
		//Also vibration!
		var vib=scale;
		scr_set_vibration(vib,vib,1);
		image_xscale=scale;
		image_yscale=scale;
		if returntoedcounter>=30
			{
				//Destroy in a puff of smoke!
				instance_create_layer(x,y,"players",obj_smoke);
				global.currentinstance=instance_nearest(x,y,parent_main_character);
				instance_destroy();
				var emitter=instance_create_layer(x,y,"players",obj_sound_emitter)
				emitter.soundid=snd_pop;
				scr_set_vibration(1,1,15);
				with (parent_possessable)
					{
						outlineshader=false;
					}
				exit;
			}
	}
else
	{
		returntoedcounter=0;
		if audio_is_playing(snd_speedup)
			{
				audio_stop_sound(snd_speedup);
			}
	}