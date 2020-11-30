/// @description

text="Don't forget to add text";
description=scr_return_text(66);
descriptionHeightCalculated=false;
descriptionHeight=32;
highlighted=false;
selected=false;
attachedScript=scr_doNothing;

hrepeats=1;

status=TODOSTATUS.INCOMPLETE;		//Default status

linkedList=global.todo;				//Replace with the object's todo, this is just because I need to find things to pass to the other container

ref=-1;

myContainer=noone;					//This updates to say whether it's created a container to avoid dupes