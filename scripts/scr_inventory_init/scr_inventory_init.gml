//Created 28/08/19
//Last updated 28/08/19

//This should be called ONCE at game start and then never again

global.inventory=ds_grid_create(6,0);
//Insert all orbs here first
scr_inventory_add_ref(obj_orb_red,scr_return_text(189),0,spr_orb_red,scr_return_text(190));
scr_inventory_add_ref(obj_orb_white,scr_return_text(191),0,spr_orb_white,scr_return_text(192));
scr_inventory_add_ref(obj_orb_green,scr_return_text(348),0,spr_orb_green,scr_return_text(349));
scr_inventory_add_ref(obj_orb_orange,scr_return_text(637),0,spr_orangeOrb,scr_return_text(638));
scr_inventory_add_ref(obj_artifact,scr_return_text(677),0,spr_rareArtifact,scr_return_text(678));
scr_inventory_add_ref(obj_uselessCollectible,scr_return_text(748),0,spr_uselessThing,scr_return_text(749));

//Then everything else is order
scr_inventory_add_ref(obj_key_green,scr_return_text(193),0,spr_key_green,scr_return_text(194));
scr_inventory_add_ref(obj_laser_diskvol1,scr_return_text(195),0,spr_laserdisk,scr_return_text(196));
scr_inventory_add_ref(obj_laser_diskvol2,scr_return_text(409),0,spr_laserdisk,scr_return_text(410));
scr_inventory_add_ref(obj_laser_diskvol3,scr_return_text(650),0,spr_laserdisk,scr_return_text(651));
scr_inventory_add_ref(obj_masterplan,scr_return_text(197),0,spr_masterplan,scr_return_text(198));
scr_inventory_add_ref(obj_cellar_key,scr_return_text(199),0,spr_cellar_key,scr_return_text(200));
scr_inventory_add_ref(obj_treasure_map,scr_return_text(305),0,spr_treasuremap,scr_return_text(306));
scr_inventory_add_ref(obj_lime_key,scr_return_text(359),0,spr_lime_key,scr_return_text(360));
scr_inventory_add_ref(obj_treasure_map_2,scr_return_text(361),0,spr_mapEnhancer,scr_return_text(806));
scr_inventory_add_ref(obj_grappa,scr_return_text(382),0,spr_grappa,scr_return_text(383));
scr_inventory_add_ref(obj_granite_surface,scr_return_text(389),0,spr_granite_surface,scr_return_text(390));

//Key cards
scr_inventory_add_ref(obj_key_card_A,scr_return_text(542),0,spr_key_card_A,scr_return_text(543));
scr_inventory_add_ref(obj_key_card_B,scr_return_text(544),0,spr_key_card_B,scr_return_text(545));
scr_inventory_add_ref(obj_key_card_C,scr_return_text(548),0,spr_key_card_C,scr_return_text(549));
scr_inventory_add_ref(obj_keycard_D_shard1,scr_return_text(552),0,spr_key_card_D_piece1,scr_return_text(554));
scr_inventory_add_ref(obj_keycard_D_shard2,scr_return_text(552),0,spr_key_card_D_piece2,scr_return_text(554));
scr_inventory_add_ref(obj_keycard_D_shard3,scr_return_text(552),0,spr_key_card_D_piece3,scr_return_text(554));
scr_inventory_add_ref(obj_key_card_D,scr_return_text(553),0,spr_key_card_D,scr_return_text(555));

//Dr Death memo
scr_inventory_add_ref(obj_memo_collect,scr_return_text(564),0,spr_memo,scr_return_text(565));

//Yellow key and EdSpace 2 stuff
scr_inventory_add_ref(obj_yellowKey,scr_return_text(642),0,spr_yellowKey,scr_return_text(643));
scr_inventory_add_ref(obj_scrollIneffibleWisdom,scr_return_text(659),0,spr_scrollIneffibleWisdom,scr_return_text(660));

