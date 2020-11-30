/// @description

// Inherit the parent event
event_inherited();

if (active==true)
	{
		var keycard=obj_key_card_A;
		if (image_index==1)
			{
				keycard=obj_key_card_B;
			}
		if (image_index==2)
			{
				keycard=obj_key_card_C;
			}
		if (image_index==3)
			{
				keycard=obj_key_card_D;
			}
		//Here we will check the image_index to decide what key card we need;
		var haskeycard=scr_inventory_check(keycard);
		if (haskeycard==true)
			{
				if (linkedinstance==noone)
					{
						scr_queue_dialogue_box("You fucking idiot! You forgot to link an instance!");
					}
				else
					{
						scr_play_sound(snd_menu_confirm,false,0);
						if (instance_exists(linkedinstance))
							{
								with (linkedinstance)
									{
										active=true;
									}
							}
					}
			}
		else
			{
				scr_queue_dialogue_box(scr_return_text(550));
				obj_dialogue.x=x;
				obj_dialogue.y=y;
			}
		active=false;
	}