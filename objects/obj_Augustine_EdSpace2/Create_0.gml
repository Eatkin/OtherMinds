/// @description Intrinsic variable set up etc
// You can write your code in this editor

event_inherited();

scr_modules_init();
scr_gloop_create_new();

splatColour=c_green;

canbehurtenabled=false;
canhurtenabled=false;
teleportenabled=true;

//Boring stuff
//Keep Augustine a level 1 character. I'll leave an exit after the death door
//Then the player is free to come back and play whichever route they didn't take
//^Actually it just goes in a loop back to room 1
scr_intrinsic_variables(scr_return_text(159),0.1,1,1,10,6,1,true,HP.INF);
scr_bio(scr_return_text(140),scr_return_text(141),spr_augustinesleep);

directionfacing=-1;

//Check if we should add key to inventory
if (!scr_event_check_complete(global.edSpaceTwoEvents,EdSpaceTwoEvents.COLLECTEDYELLOWKEY))
	{
		scr_inventory_add_ref(obj_yellowKey,scr_return_text(642),0,spr_yellowKey,scr_return_text(643),localinventory);
		scr_inventory_add(obj_yellowKey,localinventory);
		hasKey=true;
	}

//Dialogue
//This is used for rolling for dialogue
dialogueprevious=-1;
//Standard dialogue
text[0]=scr_return_text(639);
text[1]=scr_return_text(640);
text[2]=scr_return_text(641);
text[3]=scr_return_text(644);
//Fallen off cliff
text[4]=scr_return_text(645);

//Text if key is already taken
text[5]=scr_return_text(646);
text[6]=scr_return_text(647);		//Fallen off cliff

//Set dialogue boundaries
var d_min=0;
var d_max=3;

var hasKey=scr_inventory_check(obj_yellowKey,localinventory);
if (!hasKey)
	{
		d_min=5;
		d_max=5;
	}

scr_dialoguemap_init(d_min,d_max);


	
//Add todo
scr_add_todo(0,scr_return_text(648),scr_return_text(649),localtodo);
scr_todo_discover(0);

if (!hasKey)
	scr_todo_complete(0);