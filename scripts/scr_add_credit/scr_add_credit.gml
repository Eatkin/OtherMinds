//Created 24/12/19
//Last updated 24/12/19

var grid=creditsgrid;
var gridheight=ds_grid_height(grid);
var gridwidth=ds_grid_width(grid);
ds_grid_resize(grid,gridwidth,gridheight+1);


var word=argument0;
var line=argument1;
var paragraph=argument2;
var beat=argument3;

ds_grid_set(grid,CREDITS.WORD,gridheight,word);
ds_grid_set(grid,CREDITS.LINE,gridheight,line);
ds_grid_set(grid,CREDITS.PARAGRAPH,gridheight,paragraph);
ds_grid_set(grid,CREDITS.BEAT,gridheight,beat);
//Arbitrary because these will get overwritten
ds_grid_set(grid,CREDITS.X_POS,gridheight,0);
ds_grid_set(grid,CREDITS.Y_POS,gridheight,0);
ds_grid_set(grid,CREDITS.CURRENT_Y_POS,gridheight,0);