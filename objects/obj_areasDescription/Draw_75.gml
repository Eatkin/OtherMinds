/// @description

var palette=scr_select_UI_palette();
scr_set_palette_swap_shader(spr_UI_palette,palette,false);

var vr=vrepeats+youAreHere;

//Drwa from 9slice
for (var i=0; i<hrepeats; i+=1)
    for (var j=0; j<vr; j+=1)    {
        //Bitmasking bollocks
        var tileOffset=0;
        if (i>0)
            tileOffset|=8;
        if (i<hrepeats-1)
            tileOffset|=2;
        if (j>0)
            tileOffset|=1;
        if (j<vr-1)
            tileOffset|=4;
            
        draw_sprite_part(sprite_index,image_index,tileOffset*16,0,16,16,x+i*16,y+j*16);
    }
    
shader_reset();

//Text and text boundaries
var padding=6;

draw_set_halign(fa_left);
draw_set_valign(fa_top);


var xx=x+padding;
var yy=y+16;

//Draw sprites
var orbicon=spr_orbsicon;
var secreticon=spr_secretsicon;
var youarehere=spr_edhead_bw;
//Draw Charlotte instead if necessary
var player=global.currentinstance;
if (player.object_index==obj_Charlotte)
	youarehere=spr_charlottehead_bw;
	
var highlightcolour=make_colour_rgb(235,211,31);
if (orbsFound)	{
	draw_sprite_ext(orbicon,0,xx,yy+8,1,1,0,highlightcolour,1);
	draw_set_colour(highlightcolour);
	draw_text(xx+16,yy,scr_return_text(820));		//All orbs found
}
else	{
	draw_sprite(orbicon,0,xx,yy+8);
	draw_set_colour(c_white);
	draw_text(xx+16,yy,scr_return_text(817));		//Orbs to collect
}
if (secretsFound)	{
	draw_sprite_ext(secreticon,0,xx,yy+24,1,1,0,highlightcolour,1);
	draw_set_colour(highlightcolour);
	draw_text(xx+16,yy+16,scr_return_text(821));	//All secrets found
}
else	{
	draw_sprite(secreticon,0,xx,yy+24);
	draw_set_colour(c_white);
	draw_text(xx+16,yy+16,scr_return_text(818));		//Secrets to find
}
if (youAreHere)	{
	draw_sprite_ext(youarehere,0,xx,yy+40,1,1,0,highlightcolour,1);
	draw_set_colour(highlightcolour);
	draw_text(xx+16,yy+32,scr_return_text(819));	//Current location
}