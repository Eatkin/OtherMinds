/// @description This just saves a font and sets up a font queue
// You can write your code in this editor

//Then a couple of things for displaying the boxes
dialogueended=0;
characters=1;

global.softpause=1;
global.canpause=0;

cursorblink=1; //controls the cursor blinking subimage
alarm[0]=15;

depth=-1;

//We also need to set the camera to zoom
var dialogueobject=id;
with (obj_camera)
	{
		state=CAMERA_MODE.CAM_ZOOM;
		following=dialogueobject;
	}
	
morsequeue=ds_queue_create();
morsesound=noone;