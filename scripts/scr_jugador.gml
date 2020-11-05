if (key_q || key_e || key_s || key_z || key_c) {
    if (key_q) limite[1] = 80;
    if (key_e) limite[3] = 80;
    if (key_s) limite[2] = 80;
    if (key_z) limite[0] = 80;
    if (key_c) limite[4] = 80;
    
    /// JUGADOR
    var k = floor(max((CurrentRow + rango)/sHeight, 0));
    ds_l_beats = ds_list_find_value(Steps, k);
    if (!is_undefined(ds_l_beats)) {
        size_l_beats = ds_list_size(ds_l_beats);
        pos_yy = (k*sHeight) - CurrentRow - rango;
        beats_height = (sHeight/size_l_beats);
        var j = floor(max((-pos_yy)/beats_height, 0));
        step = ds_list_find_value(ds_l_beats, j);
        if (!is_undefined(step) && step != "00000") {
            yy = pos_yy + (beats_height*j) + rango;
            
            if (yy >= -rango && yy <= rango) {
                yyyy = barra_yy+yy;
                
                if (pressed_q && string_char_at(step, 2) == '1') {
                    step = string_delete(step, 2, 1);
                    step = string_insert('0', step, 2);
                }
                if (pressed_e && string_char_at(step, 4) == '1') {
                    step = string_delete(step, 4, 1);
                    step = string_insert('0', step, 4);
                }
                if (pressed_s && string_char_at(step, 3) == '1') {
                    step = string_delete(step, 3, 1);
                    step = string_insert('0', step, 3);
                }
                if (pressed_z && string_char_at(step, 1) == '1') {
                    step = string_delete(step, 1, 1);
                    step = string_insert('0', step, 1);
                }
                if (pressed_c && string_char_at(step, 5) == '1') {
                    step = string_delete(step, 5, 1);
                    step = string_insert('0', step, 5);
                }
                
            }
            
            
            if (yy >= -VSP && yy <= VSP) {
                if (key_q) {
                    if (string_char_at(step, 2) == '3') {
                        step = string_delete(step, 2, 1);
                        step = string_insert('0', step, 2);
                    }
                }
                if (key_e) {
                    if (string_char_at(step, 4) == '3') {
                        step = string_delete(step, 4, 1);
                        step = string_insert('0', step, 4);
                    }
                }
                if (key_s) {
                    if (string_char_at(step, 3) == '3') {
                        step = string_delete(step, 3, 1);
                        step = string_insert('0', step, 3);
                    }
                }
                if (key_z) {
                    if (string_char_at(step, 1) == '3') {
                        step = string_delete(step, 1, 1);
                        step = string_insert('0', step, 1);
                    }
                }
                if (key_c) {
                    if (string_char_at(step, 5) == '3') {
                        step = string_delete(step, 5, 1);
                        step = string_insert('0', step, 5);
                    }
                }
                
            }
            
            ds_list_replace(ds_l_beats, j, step);
        }
    }
}

