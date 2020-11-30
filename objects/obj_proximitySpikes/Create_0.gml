/// @description reset ystart

move_snap(16,16);		//Can't be bothered to line it up in the level lol

y+=16;
ystart=y;

//Set the layer
var _lay=layer_get_id("blocks");
layer=_lay;