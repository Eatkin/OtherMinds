/// @description

//We'll create an object that just plays an animation, then overwrite its sprite with the heart disappearing sprite
//Why the fuck did I need a comment to say that
var animation=instance_create_layer(x,y,layer,obj_orb_collected);
animation.sprite_index=spr_heart_disappear;