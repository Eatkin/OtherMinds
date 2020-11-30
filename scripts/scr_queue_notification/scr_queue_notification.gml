//Created 23/09/19
//Last updated 23/09/19

if (global.attract)
	exit;

var text=argument0;
var type=argument1;

var minWidth=98;

var newtext=scr_string_multiline(text,minWidth);

//If we have unusually long words, recalculate
var maxWidth=string_width(newtext);
if (maxWidth>minWidth)	{
	minWidth=maxWidth;
	newtext=scr_string_multiline(text,minWidth);
}

switch(type)	{
	case NOTIFICATION.TODONEW:
		newtext=scr_return_text(289)+newtext;
		break;
	case NOTIFICATION.TODOCOMPLETE:
		//Extra new line, it didn't work but I can't be bothered to fix it normally because that would take a long time
		//What? What the hell does this mean? - Future Ed
		newtext=scr_return_text(290)+newtext;
		break;
	case NOTIFICATION.TODOFAIL:
		newtext=scr_return_text(291)+newtext;
		break;
	case NOTIFICATION.ACHIEVEMENT:
		newtext=scr_return_text(292)+newtext;
		break;
}

ds_queue_enqueue(global.notificationqueue,newtext);