/// @description ease in/Out and behaviour

var ease=true;
var snd=noone;

if (active and timer==1)
	ease=false;
//Destroy when off screen
if (!active and timer==0)	{
	instance_destroy();
	exit;
}
	
var easeDir=(active)	?	1	:	-1;

//Easing
if (ease)	{
	timer+=easeDir*0.025;		//40 frame easing
	timer=max(timer,0);
	timer=min(timer,1);
	//ease the buttons in
	var easingProportion=scr_easeInOutSin(timer);
	
	x=xstart-480*easingProportion;
}

//Behaviour here
if (timer>0.9 and active and !instance_exists(obj_transition))	{
	//inputs
	var select=global.inputs[4];
	var back=global.inputs[5];
	var hinput=sign(global.inputs[0]);
	var vinput=-sign(global.inputs[1]);
	
	//Select
	if (select)	{
		//Enable/disable things
		if (optionSelected==1)	{		//Full screen
			window_set_fullscreen(1-window_get_fullscreen());
			//Reset scaling and set gui size which is probably totally pointless but it might not be and I can't be bothered to find out so fuck you
			if (!window_get_fullscreen())	{
				var width=480;
				var height=270;
				//surface_resize(application_surface, width, height);
				window_set_size(width*global.windowscale,height*global.windowscale);
				display_set_gui_size(width,height);
			}
		}
		else if (optionSelected==2)	{	//Vsync
			global.vsync^=1;			//Just bitflip it
			display_reset(0,global.vsync);	//Then actually toggle it
		}

			
		snd=audio_play_sound(snd_menu_confirm,0,false);
	}
	
	//We just go back with a back press
	if (back)	{
		snd=audio_play_sound(snd_menu_cancel,0,false);
		active=false;
		obj_pauseOptionsContainer.optionPanelActive=false;
		exit;
	}
	
	//Hinputs
	if (hinput==0)
		hinputPressed=false;
	else	{
		//hinputPressed does not indicate that hinput has been pressed
		//Rather, it indicates when it has been pressed and should no longer be responsive until it is released again
		if (!hinputPressed)	{
			var playMoveSound=false;
			var playNoSound=false;
			hinputPressed=true;

			//If difficulty is selected, we change it, else we say no
			if (optionSelected==0)	{		//Scale
				//Get the maxscale
				var width=480;
				var height=270;
				var screenw=display_get_width();
				var screenh=display_get_height();
				maxScale=min(floor(screenw/width),floor(screenh/height));
				
				global.windowscale+=hinput;
				//Toggle boundaries
				if (global.windowscale!=clamp(global.windowscale,1,maxScale))	{
					playNoSound=true;
					global.windowscale=clamp(global.windowscale,1,maxScale);
				}
				else
					playMoveSound=true;
					
				//Configure display
				window_set_size(width*global.windowscale,height*global.windowscale);
				display_set_gui_size(width,height);	//Again, pointlessly set gui size because why the fuck did I keep doing this what if wrong with me?
				alarm[1]=1;							//Centre window!
			}
			else if (optionSelected==3)	{		//Gamepad icons
				global.gamepadtype+=hinput;
				if (global.gamepadtype!=clamp(global.gamepadtype,PAD.XBOX,PAD.NINTENDO))	{
					global.gamepadtype=clamp(global.gamepadtype,PAD.XBOX,PAD.NINTENDO);
					playNoSound=true;
				}
				else
					playMoveSound=true;
			}
			else if (optionSelected==4)	{		//Font
				global.font+=hinput;
				if (global.font!=clamp(global.font,0,1))	{
					global.font=clamp(global.font,0,1);
					playNoSound=true;
				}
				else	{
					playMoveSound=true;
					if (global.font==0)
						global.font=fnt_standard;
					else
						global.font=fnt_alternative;
				}
			}
			else if (optionSelected==5)	{		//Transitions
				//Transition types are iris, fade or none so clkamp between 0 and 2
				global.transitions+=hinput;
				if (global.transitions!=clamp(global.transitions,0,2))	{
					playNoSound=true;
					global.transitions=clamp(global.transitions,0,2);
				}
				else
					playMoveSound=true;
			}
			else if (optionSelected==6)	{		//Brightness
				global.brightness*=power(0.95,-sign(hinput));
				global.brightness=0.01*round(global.brightness*100);
				var clamped=clamp(global.brightness,power(0.95,5),power(0.95,-5));
				if (global.brightness==clamped)
					playMoveSound=true;
				else	{
					playNoSound=true;
					global.brightness=clamped;
				}
			}
			
			if (playMoveSound)
				snd=audio_play_sound(snd_menu_move,0,false);
			if (playNoSound)
				snd=audio_play_sound(snd_menu_no,0,false);
		}
	}
	
	//Vinput - move up and down
	if (vinput==0)	{
		vinputCooldown=0;
		vinputClicks=0;
	}
	else	{
		var len=array_length_1d(option);
		//If we're at 0, move menu
		if (vinputCooldown==0)	{
			vinputClicks+=1;
			optionSelected+=vinput;
			//Deal with button selections outside of range
			if (optionSelected<0)
				optionSelected+=len;
			else if (optionSelected>=len)
				optionSelected-=len;
			
			//Play a sound
			snd=audio_play_sound(snd_menu_move,0,false);
		}
		
		vinputCooldown+=1;
		
		//If we hit vinputCooldownMax, reset cooldown to 0
		var maxCool=vinputCooldownMax;
		//If we're holding the button down, the first movement will take longer then subsequent movements are quicker
		if (vinputClicks>1)
			maxCool*=0.5;
			
		if (vinputCooldown==maxCool)
			vinputCooldown=0;
	}
}

//Lerp the chevron into position
//Lerp the x into pos
var chevronXPotential=x+17
chevronX=lerp(chevronX,chevronXPotential,0.2);

//Lerp the y into pos
var chevronYPotential=y+32+16*optionSelected;
chevronY=lerp(chevronY,chevronYPotential,0.2);

if (snd!=noone)
	audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
	
//Update chevron timer
chevronTimer+=8;
chevronTimer%=360;