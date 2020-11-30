/// @description

//Boundaries
xbound[0]=0;
xbound[1]=480;

//We need to create a 'hurt mask' between x-bounds and extending from bbox_top to the blocks
//At the moment we just need to create it because it's below the level

scr_object_resize(id,xbound[1]-xbound[0],64);