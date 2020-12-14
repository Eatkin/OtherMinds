/// @description 2nd chamber first block trigger

instance_activate_object(inst_7BE1EF25);
instance_activate_object(inst_57C2536C);

inst_7BE1EF25.y-=600;
inst_57C2536C.y-=600;

//Activate the anti-cheat method - okay, what is the anti cheat method?
instance_activate_region(3952,-672,100,150,true);