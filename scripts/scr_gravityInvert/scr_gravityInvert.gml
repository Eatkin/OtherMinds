//Created 22/06/20
//Last updated 22/06/20

global.gravdirection*=-1;

//Reset xsafe and ysafe because they will no longer work
/* Not doing this
with (parent_possessable)
{
	//Set safe spot to check point unless checkpoint doesn't exist
	var checkid=global.checkpoint[0];
	if (instance_exists(checkid))
		{
			xsafe=checkid.x_check;
			ysafe=checkid.y_check;
		}
	else
		{
			xsafe=xstart;
			ysafe=ystart;
		}
}*/

scr_particles();

instance_create_layer(x,y,layer,obj_gravInvertOverlay);
var snd=audio_play_sound(snd_new_menu,0,false);
audio_sound_pitch(snd,0.2);