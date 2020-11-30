/// @description Draw everything to surface and determine x and y pos
// You can write your code in this editor

//Make sure the surface exists
if !surface_exists(mapsurf)
	{
		var xmax=guiwidth/cellsize;
		var ymax=guiheight/cellsize;
		for (i=0; i<ds_grid_height(themap);i+=1)
			{
				xmax=max(xmax,ds_grid_get(themap,MAPDATA.X,i)+ds_grid_get(themap,MAPDATA.XSCALE,i));
				ymax=max(ymax,ds_grid_get(themap,MAPDATA.Y,i)+ds_grid_get(themap,MAPDATA.YSCALE,i));
			}
		mapsurf=surface_create(xmax*cellsize+border*2,ymax*cellsize+border*2);
	}
	
#region boring lerping
//Lerp in the drawing coordinates
if moveenabled=0
	{
		//Lerp upwards
		if movedir=1
			{
				var movement=lerp(ydraw,0,0.2)-ydraw;
				movement=sign(movement)*max(2,abs(movement));
				ydraw+=movement;
				if abs(ydraw)<2
					{
						ydraw=0;
						moveenabled=1;
					}
			}
		else //Lerp downwards
			{
				var movement=lerp(ydraw,guiheight*1.25,0.2)-ydraw;
				movement=sign(movement)*max(2,abs(movement));
				ydraw+=movement;
				//If we've moved sufficiently far down we exit the menu or start a loading transition depending on state
				if abs(ydraw-guiheight*1.25)<guiheight*.25
					{
						global.hardpause=false;
						audio_resume_all();
						with (obj_music)
							{
								if nowplaying!=noone
									{
										audio_sound_gain(nowplaying,global.music_volume*global.music_on,500);
									}
							}
						instance_destroy();
						exit;
					}
			}
		
	}
#endregion


surface_set_target(mapsurf)
	{
		draw_clear_alpha(0,0);
		//Draw a background
		/*Old way
		draw_set_colour(make_color_rgb(26,26,26));
		draw_rectangle(0,0,surface_get_width(mapsurf),surface_get_height(mapsurf),false);*/
		//New way - nice paralaxed background
		draw_sprite_tiled(spr_maptexture,0,camx*.5,camy*.5);
		
		//Draw the lines connecting the rooms first so they go underneath the tiles
		//I'll probably replace these with sprites and for loops
		draw_set_colour(c_white);
		//SET SHADER HERE!
		var palette=scr_select_UI_palette();
		scr_set_palette_swap_shader(spr_UI_palette,palette,false);
		//var tiles=til_map;
		for (var i=0; i<ds_grid_height(connections);i+=1)
			{
				var x1=ds_grid_get(connections,CONNECTION.X_1,i)*cellsize+border;
				var y1=ds_grid_get(connections,CONNECTION.Y_1,i)*cellsize+border;
				var x2=ds_grid_get(connections,CONNECTION.X_2,i)*cellsize+border;
				var y2=ds_grid_get(connections,CONNECTION.Y_2,i)*cellsize+border;
				var angle=arctan2(y2-y1,x2-x1);
				
				//We'll split the drawing up into a repeat loop
				var divisor=sprite_get_width(spr_map_h_connection);
				if abs(sin(angle))<=(sqrt(2)/2)
					{
						var spr=spr_map_h_connection;
						var dist=abs(x2-x1);
						for (var j=0; j<=dist/divisor; j+=1)
							{
								var xcoord=x1+j*divisor;
								var ycoord=y1+j*divisor*sin(angle); //sin reverses the negative sin of what you'd expect
								draw_sprite(spr,0,xcoord,ycoord);
							}
					}
				else
					{
						var spr=spr_map_v_connection;
						var dist=abs(y2-y1);
						for (var j=0; j<=dist/divisor; j+=1)
							{
								var xcoord=x1+j*divisor*cos(angle);
								var ycoord=y1+sign(y2-y1)*j*divisor;
								draw_sprite(spr,0,xcoord,ycoord);
							}
					}
			}
		
		//loop through i and j, to xscale and yscale, if i=0 and yscale=0, draw a enclosed box, i=0, yscale>0, corner,i=xscale,yscale=0 - enclosed box, i=xscale,j=yscale - fully enclosed box
		//Damn this is complicated
		//Actually don't loop through i and j, just go through the map and it has the coordinates
		//Could've used binary operators but I didn't know at the time so whatever lol
		for (var i=0;i<ds_grid_height(themap);i+=1)
			{				
				 var _x=ds_grid_get(themap,MAPDATA.X,i)*64+border;
				 var _y=ds_grid_get(themap,MAPDATA.Y,i)*64+border;
				 var _xscale=ds_grid_get(themap,MAPDATA.XSCALE,i);
				 var _yscale=ds_grid_get(themap,MAPDATA.YSCALE,i);
				 var orbs=ds_grid_get(themap,MAPDATA.ORBS,i);
				 var secrets=ds_grid_get(themap,MAPDATA.SECRETS,i);
				 //Draw the sprites
				 //I'm doing a tab - its 26 px wide with a 3px border
				 /*Draw tab as _x+1
				 Icons take up 8px
				 Tab has 3px border
				 so Tab+9px for orbs
				 orbs+(4px)+6px for secrets (4px is sprite width)
				 Tab is 8px tall
				 Will set origin to bottom left*/
				 spr_x=_x+1;
				 if (orbs==false or secrets==false)
					{
						 var spr_x=_x+1;
						 draw_sprite(spr_maptab,0,spr_x,_y);
						 spr_x+=6;
					}
				if orbs=0
					{
						draw_sprite(spr_orbsicon,0,spr_x,_y-6);
						spr_x+=14;
					}
				if secrets=0
					{
						draw_sprite(spr_secretsicon,0,spr_x,_y-6);
					}
				#region OBSELETED
					/*
				//Now draw the thing
				if _xscale=1
					{
						//cases -yscale=1, yscale>1
						//This draws a single square
						if _yscale=1
							{
								draw_tile(tiles,10,0,_x,_y);
							}
						else
							{
								//This draws a top piece then fills in as many middle pieces as necessary
								draw_tile(tiles,11,0,_x,_y);
								for (var j=1; j<_yscale;j+=1)
									{
										var _tile;
										if j=_yscale-1
											{
												_tile=12;
											}
										else
											{
												_tile=15;
											}
										draw_tile(tiles,_tile,0,_x,_y+64*j);
									}
							}
					}
				else
					{
						if _yscale=1
							{
								//This draw the edge
								draw_tile(tiles,13,0,_x,_y);
								//Then we loop and draw as many centre pieces as necessary
								for (var j=1; j<_xscale;j+=1)
									{
										var _tile;
										if j=_xscale-1
											{
												_tile=14;
											}
										else
											{
												_tile=16;
											}
										draw_tile(tiles,_tile,0,_x+64*j,_y);
									}
							}
						else
							{
								//This is the most complicated one, we need to go row by row to draw our room layout
								//That means nested loops!
								for (var j=0; j<_xscale;j+=1)
									{
										for (var k=0; k<_yscale; k+=1)
											{
												#region tile selection
												//Lets split into our cases:
												//j=k=0 - top left corner
												//j=_xscale, k=0 - top right corner
												//j=0, k=_yscale - bottom left corner
												//j=_xscale, k=_yscale - bottom right corner
												//j=clamp(j,1,_xscale-1), k=0 - top piece
												//j=clamp(j,1,_xscale-1), k=_yscale - bottom piece
												//k=clamp(k,1,_yscale-1), j=0 - left piece
												//k=clamp(j,1,_yscale-1),j=_xscale - right piece
												//other - middle piece
												
												var _tile;
												if j=0 and k=0
													{
														_tile=1;
													}
												else if j=_xscale-1 and k=0
													{
														_tile=2;
													}
												else if j=0 and k=_yscale-1
													{
														_tile=3;
													}
												else if j=_xscale-1 and k=_yscale-1
													{
														_tile=4;
													}
												else if j=clamp(j,1,_xscale-2) and k=0
													{
														_tile=7;
													}
												else if j=clamp(j,1,_xscale-2) and k=_yscale-1
													{
														_tile=8;
													}
												else if k=clamp(k,1,_yscale-2) and j=0
													{
														_tile=5;
													}
												else if k=clamp(k,1,_yscale-2) and j=_xscale-1
													{
														_tile=6;
													}
												else
													{
														_tile=9;
													}
												#endregion
												draw_tile(tiles,_tile,0,_x+64*j,_y+64*k);			
											}
									}
							}
					}*/
				#endregion
				
				//So we need to loop from j=0 to j=_xscale and k=0 to k=_yscale
				/*Redo with binary operators
				 1
				8T2
				 4
				Then we set x=(32*tile)%4
				y=floor(tile/4)*32;
				*/
				
				for (var j=0; j<_xscale; j+=1)
					{
						for (var k=0; k<_yscale; k+=1)
							{
								var tile_piece=0;
								//Xscales
								//Tile to the right
								if (j<_xscale-1)
									{
										tile_piece=tile_piece^2;
									}
								//Tile to the left
								if (j>0)
									{
										tile_piece=tile_piece^8;
									}
								
								//Yscales
								//Tile below
								if (k<_yscale-1)
									{
										tile_piece=tile_piece^4;
									}
								//Tile above
								if (k>0)
									{
										tile_piece=tile_piece^1;
									}
								
								//Draw
								//4 tiles per row in the sprite and they're 64px squared
								var tile_x=(tile_piece%4)*64;
								var tile_y=floor(tile_piece/4)*64;
								draw_sprite_part(spr_map_binaryoperator,0,tile_x,tile_y,64,64,_x+64*j,_y+64*k);
							}
					}
				
				var roomnum=ds_grid_get(themap,MAPDATA.ROOMNUMBER,i);
				//Draw room number if we're in debug mode
				if (global.debugging==true)
					{
						//reset _x
						var _x=ds_grid_get(themap,MAPDATA.X,i)*64+border;
						draw_text(_x+16,_y+16,roomnum);
					}
				
				//Draw the player sprite
				if (roomnum==room)
					{
						var maincount=instance_number(parent_main_character);
						if (maincount>1)
							{
								//Do two passes
								for (var i=0; i<maincount; i+=1)
									{
										var player=instance_find(parent_main_character,i);
										var px=player.x/room_width;
										var py=player.y/room_height;
										var psprite=spr_edhead;
										if (player.object_index==obj_Charlotte)
											{
												psprite=spr_charlottehead;
											}
										draw_sprite(psprite,0,_x+64*_xscale*px,_y+64*_yscale*py);
									}
							}
						else
							{
								var player=parent_main_character;
								var px=player.x/room_width;
								var py=player.y/room_height;
								var psprite=spr_edhead;
								if (instance_exists(obj_Charlotte))
									{
										psprite=spr_charlottehead;
									}
								draw_sprite(psprite,0,_x+64*_xscale*px,_y+64*_yscale*py);
							}
							
						//Take ONLY the door coords from mapenhancer
						var grid=global.mapenhancergrid;
						var gridheight=ds_grid_height(grid);
						for (var j=0; j<gridheight; j+=1)
							{
								if ds_grid_get(grid,MAPENHANCER.ROOM,j)=room
									{
										var itemtype=ds_grid_get(grid,MAPENHANCER.ITEMTYPE,j);
										if (itemtype!=ME_TYPE.DOOR)
											{
												continue;
											}
										var sprite=spr_dooricon;
									}
								else
									{
										continue;
									}
								var iconx=ds_grid_get(grid,MAPENHANCER.ITEMX,j);
								iconx=_x+iconx*_xscale*64;
								//Sprite width adjustment because its aligned middle centre
								iconx-=sprite_get_width(sprite)*0.5;
								var icony=ds_grid_get(grid,MAPENHANCER.ITEMY,j);
								icony=_y+icony*_yscale*64;
								draw_sprite(sprite,0,iconx,icony);
							}
						
						//Now map enhancer stuff
						//Reminder of the time this didn't work because you were using i as the row reference instead of j and spent half an hour trying to work out why it wasn't working
						if (mapenhancerenabled==true)
							{
								var grid=global.mapenhancergrid;
								var gridheight=ds_grid_height(grid);
								for (var j=0; j<gridheight; j+=1)
									{
										if ds_grid_get(grid,MAPENHANCER.ROOM,j)=room
											{
												var sprite;
												#region sprite selection
												var itemtype=ds_grid_get(grid,MAPENHANCER.ITEMTYPE,j);
												switch (itemtype)
													{
														case ME_TYPE.TELEPORTER:
															{
																sprite=spr_teleporticon;
																break;
															}
														case ME_TYPE.ITEM:
															{
																sprite=spr_itemicon;
																break;
															}
														case ME_TYPE.DOOR:
															{
																sprite=spr_dooricon;
																break;
															}
														case ME_TYPE.ORB:
															{
																sprite=spr_orbsicon;
																break;
															}
														default:
															{
																sprite=spr_secretsicon;
																break;
															}
													}
													#endregion
											}
										else
											{
												continue;
											}
										//Just continue if it's a door cause it's already been drawn
										if (sprite==spr_dooricon)
											{
												continue;
											}
										var iconx=ds_grid_get(grid,MAPENHANCER.ITEMX,j);
										iconx=_x+iconx*_xscale*64;
										//Sprite width adjustment because its aligned middle centre
										iconx-=sprite_get_width(sprite)*0.5;
										var icony=ds_grid_get(grid,MAPENHANCER.ITEMY,j);
										icony=_y+icony*_yscale*64;
										draw_sprite(sprite,0,iconx,icony);
									}
							}
					}
			}
		//SHADER RESET HERE! (Also for loop end)
		shader_reset()
	}

surface_reset_target();
//^What the fuck, 6 closing brackets at once
//Actually its 5

//Anyway draw the surface
//draw_surface(mapsurf,0,ydraw);
if global.brightness!=1
	{
		shader_set(shd_brightness);
		var b=shader_get_uniform(shd_brightness,"brightness");
		shader_set_uniform_f(b,global.brightness);
		var greyscale=shader_get_uniform(shd_brightness,"greyscale");
		shader_set_uniform_f(greyscale,0);
	}

draw_surface_part(mapsurf,camx,camy,guiwidth,guiheight,0,ydraw);
shader_reset();

//Align text
draw_set_halign(fa_left);
draw_set_valign(fa_top);

//Draw the room set ref name here plz
var text=roomsetname;
var textwidth=string_width(roomsetname);
var _xdraw=(guiwidth-textwidth)*0.5;
var _ydraw=16+ydraw;

draw_text(_xdraw,_ydraw,text);

//Now draw the key
_xdraw=guiwidth-96;
_ydraw=8+ydraw;
_xdraw+=4;
_ydraw+=4;
var orbicon=spr_orbsicon;
var secreticon=spr_secretsicon;
var text=scr_return_text(69);
draw_text(_xdraw+sprite_get_width(orbicon)*2,_ydraw,text);
draw_sprite(orbicon,0,_xdraw,_ydraw+sprite_get_width(orbicon)*0.5+string_height(text)*0.5);
_ydraw+=36
text=scr_return_text(70);
draw_text(_xdraw+sprite_get_width(secreticon)*2,_ydraw+sprite_get_width(secreticon)*0.5,text);
draw_sprite(secreticon,0,_xdraw,_ydraw+sprite_get_width(secreticon)*0.5+string_height(text)*0.5);
_ydraw+=36;
text=scr_return_text(302);
draw_text(_xdraw+sprite_get_width(spr_dooricon)*2,_ydraw+sprite_get_width(spr_dooricon)*0.5,text);
draw_sprite(spr_dooricon,0,_xdraw,_ydraw+sprite_get_width(spr_dooricon)*0.5+string_height(text)*0.5);

//Map enhancer icons
if (mapenhancerenabled==true)
	{
		_ydraw+=18;
		text=scr_return_text(303);
		draw_text(_xdraw+sprite_get_width(spr_itemicon)*2,_ydraw+sprite_get_width(spr_itemicon)*0.5,text);
		draw_sprite(spr_itemicon,0,_xdraw,_ydraw+sprite_get_width(spr_itemicon)*0.5+string_height(text)*0.5);
		_ydraw+=18;
		text=scr_return_text(304);
		draw_text(_xdraw+sprite_get_width(spr_teleporticon)*2,_ydraw+sprite_get_width(spr_teleporticon)*0.5,text);
		draw_sprite(spr_teleporticon,0,_xdraw,_ydraw+sprite_get_width(spr_teleporticon)*0.5+string_height(text)*0.5);
	}

if global.brightness!=1
	{
		shader_reset();
	}