/// @description Creation script
// You can write your code in this editor
event_inherited();

scr_gloop_create_new();

splatColour=c_green;

stopping=false; //This is the only behaviour variable I need

scr_inventory_add_ref(obj_grappa,scr_return_text(382),0,spr_grappa,scr_return_text(383),localinventory);
scr_inventory_add_ref(obj_granite_surface,scr_return_text(389),0,spr_granite_surface,scr_return_text(390),localinventory);
canbehurtenabled=false;
canhurtenabled=false;
hasdialogue=true;
collectitemsenabled=true;
name=scr_return_text(373);
bio[0]=scr_return_text(374);
bio[1]=scr_return_text(375);


text[0]=scr_return_text(376);
text[1]=scr_return_text(377);
text[2]=scr_return_text(378);
text[3]=scr_return_text(379);
text[4]=scr_return_text(386);
text[5]=scr_return_text(387);
text[6]=scr_return_text(388);
var _min=0;
var _max=2;

scr_add_todo(0,scr_return_text(384),scr_return_text(385),localtodo);
scr_todo_discover(0,localtodo);

scr_inventory_add(obj_granite_surface,localinventory);

//To do and events and stuff
if (scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.GRAPPA)=true)
	{
		if (scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.GRANITE)==false)
			{
				instance_create_layer(x,y,layer,obj_granite_surface);
			}
		scr_inventory_remove(obj_granite_surface,localinventory);
		scr_inventory_add(obj_grappa,localinventory);
		scr_todo_complete(0,localtodo);
		_min=4;
		_max=6;
	}
	
//Dialogue if you have the grappa
if (scr_inventory_check(obj_grappa))
	{
		//Modify text
		var _min=3;
		var _max=6;
	}
	
scr_dialoguemap_init(_min,_max);