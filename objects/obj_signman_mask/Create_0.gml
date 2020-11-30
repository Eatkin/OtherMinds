/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

scr_JimSignman_create();

//Dialogue
text[0]=scr_return_text(161);
text[1]=scr_return_text(162);
text[2]=scr_return_text(163);
text[3]=scr_return_text(164);

var _min=0;
var _max=3;

scr_dialoguemap_init(_min,_max);

//This should get overwritten but its initialised here incase
owner=noone;

scr_add_todo(0,scr_return_text(165),scr_return_text(166),localtodo);
scr_todo_discover(0,localtodo);