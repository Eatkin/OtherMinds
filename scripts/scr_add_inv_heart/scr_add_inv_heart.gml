//Created 29/11/19
//Last updated 29/11/19

//This gives the enemy a probability of holding a heart based on the number of enemies on screen or something

//Now lets give the enemy a chance of holding a heart
var num=instance_number(parent_enemy)+instance_number(obj_heart);
var _hp=global.Edhealth;
var _hpmax=scr_return_adjusted_hpmax();
if _hpmax=0
	{
		exit;
	}

var diff=_hpmax-_hp;

var prob=0.25+max(0.5,(diff*0.1))/num;

var roll=random(1);
if roll<=prob
	{
		scr_inventory_add_ref(obj_heart,scr_return_text(295),1,spr_heart,scr_return_text(296),localinventory);
	}