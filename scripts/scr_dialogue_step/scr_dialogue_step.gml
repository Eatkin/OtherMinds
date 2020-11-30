//Create 02/07/19
//Last updated 02/07/19

/*So basically I want to gather input
press A to skip to the end of dialogue
press A to skip to next dialogue
die if there's no more dialogue*/

var Abutton=global.inputs[4];
var start=global.inputs[14];
Abutton=max(Abutton,start);
if (Abutton=0)
	{
		exit;
	}
	
	
var _string=ds_queue_head(global.dialoguequeue);
var stringlength=string_length(_string);
	
if (dialogueended)
	{
		ds_queue_dequeue(global.dialoguequeue);
		if (!ds_queue_empty(global.dialoguequeue))
			{
				dialogueended=0;
				characters=1;
			}
		else
			{
				global.softpause=0;
				global.canpause=true;
				instance_destroy();
				exit;
			}
	}
else
	{
		characters=stringlength;
		dialogueended=true;
	}