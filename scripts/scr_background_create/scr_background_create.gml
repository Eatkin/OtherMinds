//Created 13/07/19
//Last updates 27/11/19

var atmosphericParticles=true;
if (scr_is_disallowed_room(room))
	{
		atmosphericParticles=false;
	}
var particleC=c_white;

//Set it dark if we want
canBeDark=true;
darknessOverlayValue=1;
darknessOverlayPotential=0.6;
darknessShaderValue=1;
darknessShaderPotential=0.4;
darknessOverlay=noone;

timer=0;
backgroundnumber=0;
for (var i=0; i<10; i+=1)
	{
		backgroundtype[i]=BACKGROUND.PARALLAX;
	}

switch(room)
	{
		case rm_language_select:
			{
				canBeDark=false;
				background[0]=spr_mountainsbackground;
				background[1]=spr_ochrehillplatformsbackground;
				background[2]=spr_cloudslayer1;
				background[3]=spr_cloudslayer2;
				backgroundtype[2]=BACKGROUND.SCROLLING;
				backgroundtype[3]=BACKGROUND.SCROLLING;
				backgroundnumber=4;
				atmosphericParticles=false;
				break;
			}
		case rm_firsttime:
			{
				canBeDark=false;
				background[0]=spr_hill1_dark;
				background[1]=spr_hill2_dark;
				background[2]=spr_overworldforeground;
				background[3]=spr_cloudslayer1;
				background[4]=spr_cloudslayer2;
				backgroundtype[3]=BACKGROUND.SCROLLING;
				backgroundtype[4]=BACKGROUND.SCROLLING;
				backgroundnumber=5;
				atmosphericParticles=false;
				break;
			}
		case rm_main_menu:
			{
				canBeDark=false;
				background[0]=spr_finalBg1;
				background[1]=spr_finalBg2;
				background[2]=spr_finalBg3;
				background[3]=spr_finalBg4;
				backgroundnumber=4;
				atmosphericParticles=false;
				break;
			}
		#region Tutorials
		case room_Tutorials_1:
		case room_Tutorials_4:
			{
				canBeDark=false;
				background[0]=spr_ditheredsky
				background[1]=spr_darkbackground;
				background[2]=spr_darkterrainforeground;
				backgroundnumber=3;
				particleC=c_gray;
				break;
			}
		#endregion
		
		#region EdSpaces zone 1 (INCLUDES ALPHA LEVELS)
		case room_EdSpace1_1:
		case rm_EdSpace1_1:
		case rm_secret_tutorial:
		case room_EdSpace1_5:
			{
				canBeDark=false;
				//Backgrounds from furthest away to nearest
				background[0]=spr_ditheredsky
				background[1]=spr_darkbackground;
				background[2]=spr_darkterrainforeground;
				background[3]=spr_slimepillar;
				backgroundnumber=4;
				particleC=c_white;
				break;
			}
		case room_EdSpace1_2:
		case rm_EdSpace1_2:
		case room_EdSpace1_3:
		case rm_EdSpace1_3:
		case room_EdSpace1_4:
		case rm_EdSpace1_4:
		case rm_EdSpace1_4_5:
			{
				canBeDark=false;
				background[0]=spr_ditheredsky
				background[1]=spr_darkbackground;
				background[2]=spr_darkterrainforeground;
				particleC=c_gray;
				backgroundnumber=3;
				break;
			}
		case room_EdSpace1_6:
		case room_EdSpace1_7:
		case rm_EdSpace1_6:
		case rm_EdSpace1_secret:
			{
				canBeDark=false;
				background[0]=spr_ditheredsky
				//background[1]=spr_darkbackground;
				background[1]=spr_darkterrainforeground;
				backgroundnumber=2;
				particleC=c_purple;
				break;
			}
		#endregion Edspaces
		
		#region Edhouse
		case rm_Edgarden:
			{
				background[0]=spr_hillsbackground;
				background[1]=spr_hillsbackground_2;
				background[2]=spr_cloudslayer1;
				background[3]=spr_cloudslayer2;
				backgroundtype[2]=BACKGROUND.SCROLLING;
				backgroundtype[3]=BACKGROUND.SCROLLING;
				backgroundnumber=4;
				particleC=c_yellow;
				break;
			}
		case rm_Edcellar:
			{
				particleC=c_gray;
				break;
			}
		//Make sure darkness is applied
		case rm_Edbathroom:
		case rm_Edbedroom:
		case rm_Edhallway:
		case rm_Edguestbedroom:
		case rm_Edkitchen:
		case rm_Edlivingroom:
		case rm_Edsparebedroom:
			break;
		
		#endregion
		
		#region overworld
		case rm_mysterious_room:
			{
				particleC=c_white;
				break;
			}
		case rm_overworld_puzzlecave:
		case rm_puzzlecavechamber:
			{
				particleC=c_black;
				break;
			}
		case rm_overworld_edhouse:
		case rm_overworld_ochrehill:
			{
				background[0]=spr_hillsbackground;
				background[1]=spr_hillsbackground_2;
				background[2]=spr_overworldforeground;
				background[3]=spr_cloudslayer1;
				background[4]=spr_cloudslayer2;
				backgroundtype[3]=BACKGROUND.SCROLLING;
				backgroundtype[4]=BACKGROUND.SCROLLING;
				backgroundnumber=5;
				particleC=c_purple;
				break;
			}
		case rm_overworld_outhouse:
		case rm_overworld_officeblock:
			{
				background[0]=spr_hill1_dark;
				background[1]=spr_hill2_dark;
				background[2]=spr_overworldforeground;
				background[3]=spr_cloudslayer1;
				background[4]=spr_cloudslayer2;
				backgroundtype[3]=BACKGROUND.SCROLLING;
				backgroundtype[4]=BACKGROUND.SCROLLING;
				backgroundnumber=5;
				particleC=c_purple;
				break;	
			}
		
		case rm_endTimes:
			background[0]=spr_finalBg1;
			background[1]=spr_finalBg2;
			background[2]=spr_finalBg3;
			background[3]=spr_finalBg4;
			backgroundnumber=4;
			particleC=c_white;
			break;
		#endregion
		
		#region Ochre Hill
		case rm_ochrehill_1:
		case rm_ochrehill_2:
		case rm_ochrehill_3:
		case rm_ochrehill_4:
		case rm_ochrehill_4OLD:
		case rm_ochrehill_5:
		case rm_ochrehill_6:
		case rm_ochrehill_7:
			{
				background[0]=spr_mountainsbackground;
				background[1]=spr_ochrehillplatformsbackground;
				background[2]=spr_cloudslayer1;
				background[3]=spr_cloudslayer2;
				backgroundtype[2]=BACKGROUND.SCROLLING;
				backgroundtype[3]=BACKGROUND.SCROLLING;
				backgroundnumber=4;
				particleC=c_green;
				break;
			}
		case rm_ochrehill_8:
		case rm_ochrehill_9OLD:
		case rm_ochrehill_9:
		case rm_ochrehill_10:
		case rm_ochrehill_11:
		case rm_ochrehill_bonus:
			{
				background[0]=spr_ochrehill_mountaintops;
				background[1]=spr_ochrehillplatformsbackground;
				background[2]=spr_cloudslayer1;
				background[3]=spr_cloudslayer2;
				backgroundtype[2]=BACKGROUND.SCROLLING;
				backgroundtype[3]=BACKGROUND.SCROLLING;
				backgroundnumber=4;
				particleC=c_lime;
				break;
			}
		case rm_ochrehill_secret:
			{
				background[0]=spr_mountainsbackground;
				background[1]=spr_ochrehillplatformsbackground;
				backgroundnumber=2;
				particleC=c_purple;
				break;
			}
		#endregion
		
		#region Challenges
		case rm_EdSpace_z1_challenge:
			{
				canBeDark=false;
				background[0]=spr_ditheredsky
				background[1]=spr_darkbackground;
				background[2]=spr_darkterrainforeground;
				backgroundnumber=3;
				particleC=c_white;
				break;
			}
		case rm_OchreHill_challenge:
			{
				canBeDark=false;
				background[0]=spr_ochrehill_mountaintops;
				background[1]=spr_ochrehillplatformsbackground;
				background[2]=spr_cloudslayer1;
				background[3]=spr_cloudslayer2;
				backgroundtype[2]=BACKGROUND.SCROLLING;
				backgroundtype[3]=BACKGROUND.SCROLLING;
				backgroundnumber=4;
				particleC=c_blue;
				break;
			}
		case rm_EdSpace_z2_challenge:
			canBeDark=false;
			background[0]=spr_EdSpaceZ2_Background1;
			background[1]=spr_EdSpaceZ2_Background2;
			background[2]=spr_EdSpaceZ2_Background3;
			backgroundnumber=3;
			particleC=make_colour_rgb(16,0,82);
			break;
		#endregion
		
		#region offices
		case rm_office_vent_room_one:
		case rm_office_vent_room_two:
		case rm_office_vent_room_three:
		case rm_office_gauntlet:
		case rm_officeGauntletEscape:
			{
				canBeDark=false;
				background[0]=spr_boring_ventbackground
				background[1]=spr_powercables_background;
				background[2]=spr_powercables_background_2;
				backgroundnumber=3;
				particleC=c_purple;
				break;
			}
		//This literally exists to make sure darkness is applied in those places
		case rm_office_dr_ds_office:
		case rm_office_new_ds_office:
		case rm_office_reception:
		case rm_office_floor_one:
		case rm_office_floor_two:
			break;
		#endregion
		
		#region EdSpace2
		case rm_EdSpace2_1:
		case rm_EdSpace2_2:
		case rm_EdSpace2_3:
		case rm_EdSpace2_4:
		case rm_EdSpace2_5:
		case rm_EdSpace2_secret:
		case rm_EdSpace2_boss:
		case rm_EdSpace2_6:
			canBeDark=false;
			background[0]=spr_EdSpaceZ2_Background1;
			background[1]=spr_EdSpaceZ2_Background2;
			background[2]=spr_EdSpaceZ2_Background3;
			backgroundnumber=3;
			particleC=make_colour_rgb(16,0,82);
			break;
		#endregion
		
		#region Rhythm challenges
		case rm_EdSpace1_Rhythm:
			canBeDark=false;
			background[0]=spr_ditheredsky
			//background[1]=spr_darkbackground;
			background[1]=spr_darkterrainforeground;
			backgroundnumber=2;
			particleC=c_purple;
			break;
			
		case rm_Ochre_Rhythm:
			canBeDark=false;
			background[0]=spr_ochrehill_mountaintops;
			background[1]=spr_ochrehillplatformsbackground;
			background[2]=spr_cloudslayer1;
			background[3]=spr_cloudslayer2;
			backgroundtype[2]=BACKGROUND.SCROLLING;
			backgroundtype[3]=BACKGROUND.SCROLLING;
			backgroundnumber=4;
			particleC=c_lime;
			break;
			
		case rm_EdSpace2_Rhythm:
			canBeDark=false;
			background[0]=spr_EdSpaceZ2_Background1;
			background[1]=spr_EdSpaceZ2_Background2;
			background[2]=spr_EdSpaceZ2_Background3;
			backgroundnumber=3;
			particleC=make_colour_rgb(16,0,82);
			break;
			
		case rm_whiteRhythm:
			canBeDark=false;
			background[0]=spr_boring_ventbackground
			background[1]=spr_powercables_background;
			background[2]=spr_powercables_background_2;
			backgroundnumber=3;
			particleC=c_purple;
			break;
		#endregion
		
		//No background default
		default:
			{
				canBeDark=false;
				backgroundnumber=0;
				atmosphericParticles=false;
				break;
			}
	}
	
if (atmosphericParticles==true)
	{
		var particleSpawner=instance_create_layer(0,0,layer,obj_atmosphericParticles);
		particleSpawner.particleColour=particleC;
	}
	
//Apply a layer of darkness
if (canBeDark and scr_isDark()) 
{
	darknessOverlayValue=darknessOverlayPotential;
	darknessShaderValue=darknessShaderPotential;
	//If we already have a darkness overlay, we use that one
	if (instance_exists(obj_darkness))
		darknessOverlay=obj_darkness;
	else
		darknessOverlay=instance_create_layer(x,y,layer,obj_darkness);
		
	darknessOverlay.darknessmultiplyer*=darknessOverlayValue;		//Multiplacative because if an overlay already exists, we make it even darker still
}

/* Come to think of it why do I even need this when the background coords are based on camera coords?
//Some background I only reset the x value, is there some reason I did that?
var i;
for (i=0; i<backgroundnumber; i+=1)
	{
		backgroundx[i]=0;
		//backgroundy[i]=0;
	}*/