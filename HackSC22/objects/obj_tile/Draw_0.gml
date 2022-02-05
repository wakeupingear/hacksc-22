/// @description Insert description here
// You can write your code in this editor

draw_sprite_ext(spr_altTile, 0, x + (1-scale)*obj_game.tileSize/2, y + (1-scale)*obj_game.tileSize/2, scale, scale, 0, c_white, 1);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_font(fnt_tile);
draw_set_color(c_black);
draw_text_transformed(x + obj_game.tileSize/2, y + obj_game.tileSize/2 - 7, string_upper(letter), scale, scale, 0);
draw_set_color(c_white);