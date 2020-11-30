//Created 04/08/19
//Last updated 28/10/19


//Checks if sound has finished playing
if soundplaying!=noone
	{
		if !audio_is_playing(soundplaying)
			{
				soundplaying=noone;
			}
	}

if soundplaying=noone
	{
		exit;
	}

//Update volume because the inbuilt falloff is broken
//Calculate distances keeping bounding boxes in mind
var xdist;
var player=global.currentinstance;
if player.x=clamp(player.x,bbox_left,bbox_right)
	{
		xdist=0;
	}
else
	{
		xdist=min(abs(bbox_left-player.x),abs(bbox_right-player.x));
	}

var ydist;
if player.y=clamp(player.y,bbox_top,bbox_bottom)
	{
		ydist=0;
	}
else
	{
		ydist=min(abs(bbox_top-player.y),abs(bbox_bottom-player.y));
	}

var distancetolistener=sqrt(sqr(xdist)+sqr(ydist));

var xemit, yemit;
if xdist=0
	{
		xemit=player.x;
	}
else
	{
		xemit=(player.x<=bbox_left)*bbox_left+(player.x>=bbox_right)*bbox_right;
	}

if ydist=0
	{
		yemit=player.y;
	}
else
	{
		yemit=(player.y<=bbox_top)*bbox_top+(player.y>=bbox_bottom)*bbox_bottom;
	}

if player=id
	{
		distancetolistener=0;
		xemit=x;
		yemit=y;
	}
	
if global.sound_3d=false
	{
		xemit=player.x;
		yemit=player.y;
	}

//Updates emitter position
audio_emitter_position(emitterid,xemit,yemit,0);

var gain;
if distancetolistener>=falloffmax
	{
		gain=0;
	}
else if distancetolistener<=falloffref
	{
		gain=1;
	}
else
	{
		gain=1-distancetolistener/falloffmax;
	}
	
if falloffmaxoverride!=0
	{
		if distancetolistener>=falloffmaxoverride
			{
				gain=0;
			}
		else if distancetolistener<=falloffmaxoverride/4
			{
				gain=1;
			}
		else
			{
				gain=1-distancetolistener/falloffmaxoverride;
			}
		
	}

//Gain is multiplied by volume and then multiplied by whether the sound effects are even on in the first place
gain=gain*global.sound_fx_volume*global.sound_fx_on*gainoverride;
		

audio_emitter_gain(emitterid,gain);