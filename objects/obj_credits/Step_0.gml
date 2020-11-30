/// @description

//This script needs to updates the y-pos's of all the text
//If we get past the beat that is stored in the grid, we start lerping to its target position
//Set a min lerp value of 2px and snap when necessary
//If we advance a paragraph, update target position to the position-room_height
//(Check it is clamped to make sure this doesn't update every step)
//When at -24 or something, don't bother updating anymore to save math operations

//inputs
var holdingstart=global.inputs[20];
var holding_b_one=global.inputs[16];
//Hold button to skip the credits
holdingtoskip=max(holdingstart,holding_b_one);

if (holdingtoskip==0)
	{
		skippingtimer=skippingtimermax;
	}
else
	{
		skippingtimer-=1;
	}

//This should trigger the end where it plays transition out if music isn't playing
if (skippingtimer<=0)
	{
		audio_stop_sound(music);
	}

var _pos=audio_sound_get_track_position(music);

var grid=creditsgrid;
var spacing=string_height("A")*1.5;

//This just deals with loops through, setting the target position correctly, then lerping into place
//Target position is already set correctly, however we don't lerp to it unless we've reached the correct part of the song
for (var i=0; i<ds_grid_height(grid);i+=1)
	{
		//Check if we have exceeded the beats
		var beats=ds_grid_get(grid,CREDITS.BEAT,i);
		var _time=beats*spb;
		if _pos>_time
			{
				//First check if the ypos has been updated
				var targety=ds_grid_get(grid,CREDITS.Y_POS,i);
				var _paragraph=ds_grid_get(grid,CREDITS.PARAGRAPH,i);
				//If we've moved up a paragraph we advance paragraph drawing
				if _paragraph>paragraphdrawing
					{
						paragraphdrawing+=1;
					}
				//If we're past that paragraph, we update it to be above screen
				if targety=clamp(targety,-room_height,room_height)
					{
						if _paragraph<paragraphdrawing
							{
								ds_grid_set(grid,CREDITS.Y_POS,i,targety-room_height);
							}
					}
				//Now we need to lerp the positions
				var lerpstrength=0.5;
				var lerpamount=0;
				//Update target y
				targety=ds_grid_get(grid,CREDITS.Y_POS,i);
				var currenty=ds_grid_get(grid,CREDITS.CURRENT_Y_POS,i);
				//Break if we're off screen because it doesn't really matter where the position is, it won't be drawn
				if currenty<-spacing
					{
						continue;
					}
				lerpamount=lerp(currenty,targety,lerpstrength)-currenty;
				lerpamount=sign(lerpamount)*max(abs(lerpamount),2);
				var newy=currenty+lerpamount;
				if abs(newy-targety)<2
					{
						newy=targety;
					}
				ds_grid_set(grid,CREDITS.CURRENT_Y_POS,i,newy);
			}
		else
			{
				break;
			}
	}
	
//End the credits with a fade out
if !audio_is_playing(music) and transitionobj=noone
	{
		transitionobj=scr_create_transition(0,TRANSITION.FADE_IN);
	}
if transitionobj!=noone
	{
		if transitionobj.transitioncomplete=true
			{
				room_goto(rm_main_menu);
			}
	}