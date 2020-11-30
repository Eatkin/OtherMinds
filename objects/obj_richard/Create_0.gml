/// @description Creation code
// You can write your code in this editor

event_inherited();

scr_intrinsic_variables(scr_return_text(334),0,0,0,0,0,1,true,HP.INF);
scr_modules_init();
scr_bio(scr_return_text(335), scr_return_text(336),sprite_index);

state=PlayerState.idle;

sprite_idle=sprite_index;

talkenabled=true;
xscaleflipenabled=false;
moveenabled=false;
gravityenabled=false;

scr_add_todo(0,scr_return_text(342),scr_return_text(343),localtodo);
scr_todo_discover(0,localtodo);

text[0]=scr_return_text(434);
text[1]=scr_return_text(435);
text[2]=scr_return_text(436);

var _min=0;
var _max=2;

scr_dialoguemap_init(_min,_max);