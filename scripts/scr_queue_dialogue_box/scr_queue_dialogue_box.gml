//Created 01/07/19
//Last updated 02/07/19

//ARGUMENT0 IS THE TEXT TO QUEUE
//ARGUMENT1 IS THE FONT

//Isn't it weird how queue stops looking like a word?
//So does string
//But side note: FUCK ME THIS ACTUALLY WORKS PERFECTLY AS INTENDED WOOOOo
//Actually it didn't but I fixed it now

//Take argument0 as the text to add to the queue
//Take argument1 as the font to be used for the queue (NO DON'T)

//var screenwidth=display_get_gui_width();

//I want to insert line breaks into the textboxes here
var textstring=argument0;

if (ds_queue_empty(global.dialoguequeue))
	instance_create_layer(obj_speechbubble.x,obj_speechbubble.y,"controllers",obj_dialogue);

//This shoves in the line breaks as necessary
var maxlength=sprite_get_width(spr_dialogue_box)-14;
textstring=scr_string_multiline(textstring,maxlength);

ds_queue_enqueue(global.dialoguequeue,textstring);