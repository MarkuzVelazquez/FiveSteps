
draw_background_stretched(background, view_xview[0], view_yview[0], view_wview[0], view_hview[0]);
draw_sprite_ext(
    spr_barra_notas, 0, view_wview[0]/2, barra_yy, 
    image_xscale, image_yscale, image_angle, image_blend, image_alpha);

var barra_yyy = barra_yy;

for(var i = 4; i >= 0; i--) {
    top_yy[i] = 0; 
}
count = 0;

var CR = (CurrentRow * Speed) * Separacion;
var TV = (sHeight * Speed) * Separacion;

var borde = 33;
init_steps = floor(max((CR-barra_yyy-borde)/TV, 0));
size_steps = min(ceil(max((CR+view_hview-barra_yyy+borde)/TV, 0)), ds_list_size(Steps));
for(var k = init_steps; k < size_steps; k++) {
    ds_l_beats = ds_list_find_value(Steps, k);
    size_l_beats = ds_list_size(ds_l_beats);
    pos_yy = barra_yyy + (k*TV) - CR;
    //draw_line(view_xview, pos_yy, view_wview, pos_yy);
    beats_height = (TV/size_l_beats);
    init_l_beats = ceil(max((-pos_yy-borde)/beats_height, 0));
    size_l_beats = min(ceil(max((-(barra_yyy+(k*TV)-(CR+view_hview))+borde)/beats_height, 0)), ds_list_size(ds_l_beats));
    for(var j = init_l_beats; j < size_l_beats; j++) {
        step = ds_list_find_value(ds_l_beats, j);
        yy = pos_yy + (beats_height*j);
        for(var i = 0; i < 5; i++) {
            switch(string_char_at(step, i+1)) {
                /*
                 * El caso 0: no existe paso
                 * El caso 1: es un paso normal
                 * El caso 2: es la parte superior de un paso largo
                 * El caso 3: es la parte baja o termino de un paso largo
                 */
                case '1':
                    count++;
                    draw_sprite_ext(spriteNota[i], image_index, xx + (i*64), yy, 
                                        image_xscale, image_yscale, image_angle, image_blend, image_alpha);
                break;
                
                case '2':
                    top_yy[i] = yy;
                case '0':
                    if (k == size_steps-1 && j == size_l_beats-1) {
                        // Si la ultima nota fue 2
                        if (top_yy[i] <= limite[i]) {
                            if (bottom_yy[i] >= view_hview+borde) {
                                draw_sprite_ext(spriteBody[i], image_index, xx + (i*64), limite[i], 
                                            image_xscale, (bottom_yy[i]-limite[i])/64, image_angle, image_blend, image_alpha);
                            }
                        } 
                        // Si la ultima nota es 2
                        else if (top_yy[i] < view_hview+borde) {
                            draw_sprite_ext(spriteBody[i], image_index, xx + (i*64), top_yy[i], 
                                                image_xscale, (view_hview-top_yy[i])/64, image_angle, image_blend, image_alpha);
                            draw_sprite_ext(spriteNota[i], image_index, xx + (i*64), top_yy[i], 
                                                image_xscale, image_yscale, image_angle, image_blend, image_alpha);
                            if (top_yy[i] <= 0) bottom_yy[i] = view_hview+borde;
                        }
                    }
                break;
                
                case '3':
                    if (top_yy[i] <= limite[i]) {
                        // Si la primera nota es 3
                        if (yy >= limite[i]) {
                            draw_sprite_ext(spriteBody[i], image_index, xx + (i*64), limite[i], 
                                                image_xscale, (yy-limite[i])/64, image_angle, image_blend, image_alpha);
                            draw_sprite_ext(spriteBottom[i], image_index, xx + (i*64), yy, 
                                                image_xscale, image_yscale, image_angle, image_blend, image_alpha);
                        }
                    }
                    else {
                        // Si no
                        draw_sprite_ext(spriteBody[i], image_index, xx + (i*64), top_yy[i], 
                                            image_xscale, (yy-top_yy[i])/64, image_angle, image_blend, image_alpha);
                        draw_sprite_ext(spriteBottom[i], image_index, xx + (i*64), yy, 
                                            image_xscale, image_yscale, image_angle, image_blend, image_alpha);
                                            
                        draw_sprite_ext(spriteNota[i], image_index, xx + (i*64), top_yy[i], 
                                            image_xscale, image_yscale, image_angle, image_blend, image_alpha);
                    }
                    if (yy < 80) {
                        draw_sprite_ext(spriteBody[i], image_index, xx + (i*64), 0, 
                                            image_xscale, (yy-0)/64, image_angle, image_blend, image_alpha);
                        draw_sprite_ext(spriteBottom[i], image_index, xx + (i*64), yy, 
                                            image_xscale, image_yscale, image_angle, image_blend, image_alpha);
                    }
                    
                    top_yy[i] = view_hview+borde;
                    bottom_yy[i] = yy;
                break;
            }
        }
    }
}


draw_line(view_xview, yyyy, view_wview, yyyy);
