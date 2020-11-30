//Created 05/04/20
//Last updated 05/04/20

/*This just gets given the text[] index and updates the map before queuing the dialogue box*/

//Let's find our value in the dialogue map

var dialoguechoice=dialogueprevious+1;
dialoguechoice=min(dialoguemax,dialoguechoice);
if (dialoguechoice==dialoguemax)
	dialoguecomplete=true;

//Update dialogueprevious
dialogueprevious=dialoguechoice;

var dialogues=ds_map_find_value(global.dialoguemap,id);
dialogues=dialogues|(power(2,dialoguechoice));
ds_map_set(global.dialoguemap,id,dialogues);

scr_queue_dialogue_box(text[dialoguechoice]);
talking=false;