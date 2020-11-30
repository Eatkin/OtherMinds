//Created 13/07/19
//Last updates 24/07/19

//Darkness stuff
//If we can be dark and the values aren't already lerped in 
if (canBeDark and scr_isDark() and (darknessOverlayValue!=darknessOverlayPotential or darknessShaderValue!=darknessShaderPotential))
	{
		if (darknessOverlay==noone)
			darknessOverlay=instance_create_layer(x,y,layer,obj_darkness);
			
		darknessOverlayValue=lerp(darknessOverlayValue,darknessOverlayPotential,0.01);
		darknessShaderValue=lerp(darknessShaderValue,darknessShaderPotential,0.01);
		darknessOverlay.darknessmultiplyer=darknessOverlayValue;
	}


if (backgroundnumber==0)
	{
		exit;
	}
//The higher the value camx is multiplied by, the slower the background will move
//Multiplier between 0 and 1
var camera=view_camera[0];
var camx=camera_get_view_x(camera);
var camy=camera_get_view_y(camera);

timer+=1;
	
var i;
for (i=0;i<backgroundnumber;i+=1)
	{
		if (backgroundtype[i]==BACKGROUND.STATIC)
			{
				backgroundx[i]=0;
				backgroundy[i]=0;
			}
		else
			{
				backgroundx[i]=camx*power(.9,i+1);
				backgroundy[i]=camy*power(.97,i+1);
			}
		if (backgroundtype[i]==BACKGROUND.SCROLLING)
			backgroundx[i]-=timer*power(.2,backgroundnumber-i); //changed from i+1
	}