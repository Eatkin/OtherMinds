/// @description

if (global.hardpause)
	{
		haspaused=true;
		exit;
	}
//Resync music
if (haspaused)
	{
		audio_sound_set_track_position(theMusic,(counter/60)+musicOffset);
		haspaused=false;
		audio_sound_gain(theMusic,global.music_volume*global.music_on,0);
	}

//timeline_position=counter;
counter+=1;
position=floor(counter/30);

if (counter>0 and counter==counter+counter%30 and audio_is_playing(theMusic))
	with (parent_main_character)
		instance_create_layer(x,y,layer,obj_quaver);

//Stuff
switch (counter)	{
	//Stair climb
	case 1:
		with (obj_gauntlet_popoutspikes)
			if (x<=208 and y>=816)
				activated=true;
		break;
	case 60:
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,192,208) and y==752)
				activated=true;
		break;
	case 120:
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,64,80) and y==688)
				activated=true;
		break;
	case 180:
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,192,208) and y==624)
				activated=true;
		break;
	case 240:
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,64,80) and y==560)
				activated=true;
		break;
	case 300:
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,192,208) and y==480)
				activated=true;
		break;
	case 360:
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,64,80) and y==400)
				activated=true;
		break;
	case 420:
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,192,208) and y==320)
				activated=true;
		break;
	case 480:
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,64,80) and y==240)
				activated=true;
		break;
	
	//Flick toggle blocks on and off
	case 540:
	case 600:
		inst_1E20E8B1.activated=true;
		break;
	case 630:
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,224,288) and y==192)
				activated=true;
				
		break;
				
				
	//Beat 24 - start shooting the cannons
	case 720:
		instance_activate_object(inst_60851578);		//This is a push block to drop on players who haven't moved from the start for lols
	case 840:
		inst_58907569.activated=true;
		break;
	case 721:
	case 841:
		inst_58907569.activated=false;
		break;
	case 750:
	case 870:
		inst_10AEB6B3.activated=true;
		break;
	case 751:
	case 871:
		inst_10AEB6B3.activated=false;
		break;
	case 780:
	case 900:
		inst_539527D5.activated=true;
		break;
	case 781:
	case 901:
		inst_539527D5.activated=false;
		break;
		
	//Beat 32 - start ejecting spikes to move the player
	case 960:
		inst_1E20E8B1.activated=true;		//Toggle blocks
		
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,304,320) and y==832)
				activated=true;
		break;
	case 990:
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,336,352) and y==832)
				activated=true;				
		break;								
	case 1020:								
		with (obj_gauntlet_popoutspikes)	
			if (x==clamp(x,368,384) and y==832)
				activated=true;				
		break;								
	case 1035:								
		with (obj_gauntlet_popoutspikes)	
			if (x==clamp(x,400,416) and y==832)
				activated=true;				
		break;								
	case 1050:								
		with (obj_gauntlet_popoutspikes)	
			if (x==clamp(x,432,448) and y==832)
				activated=true;
		break;
	case 1080:
		inst_1E20E8B1.activated=true;		//Toggle blocks
		
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,544,672) and y>=784)
				activated=true;
		break;
		
	//Toggle block climb
	case 1140:
	case 1200:
	case 1260:
	case 1320:
	case 1380:
	case 1440:
	case 1500:
		inst_1E20E8B1.activated=true;
		break;
	
	//Start the gravity flip section
	//Beat 52
	//& beat 64
	case 1620:
	case 1920:
		scr_gravityInvert();
		break;
		
	//Then we toggle the toggle blocks again
	case 2040:
	case 2160:
	case 2280:
	case 2400:
	case 2520:
		inst_1E20E8B1.activated=true;
		break;
		
	//Let Ed Through on Beat 96 (2880)
	//There's no reason you can't stay on the top for now
	case 2760:
		inst_1325E388.activated=true;		//This starts the platform spawner
		break;
	case 2880:
		inst_1E20E8B1.activated=true;
		break;
	//Ideally this will lock you in with a saw
	case 3000:
		//These are saws
		inst_1E20E8B1.activated=true;
		inst_44C93803.activated=true;
		break;
	case 3200:
		inst_551EE76.xspeed=0;
		break;
		
	//Invert gravity at beat 112 and then again at beat 120
	case 3360:
	case 3600:
		scr_gravityInvert();
		break;
	
	//Last bit, drop you down a hole after uninverting gravity
	//Then spikes start chasing you
	//At the lsat second a lift lifts you up
	//That should be the end I hope
	
	//Start ejecting spikes
	case 3720:
		inst_466F0C53.activated=true;
		inst_31A3E4CD.activated=true;
		break;
	case 3750:
		inst_ABF4E9B.activated=true;
		inst_6BC30B41.activated=true;
		
		inst_45D3C220.activated=true;		//The lift
		break;
	case 3780:
		inst_13B2D66.activated=true;
		inst_DA5DE52.activated=true;
		break;
	case 3810:
		inst_460C6321.activated=true;
		inst_E67BF5E.activated=true;
		break;
	case 3840:
		inst_337286C7.activated=true;
		inst_4F660BC1.activated=true;
		break;
}