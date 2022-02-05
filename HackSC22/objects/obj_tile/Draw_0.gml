/// @description Insert description here
// You can write your code in this editor

draw_self();
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_color(c_black);
draw_set_font(fnt_poppinsMed);
draw_text(x + 64, y + 64, string_upper(letter));
draw_set_color(c_white);