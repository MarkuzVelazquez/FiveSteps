// IA

    var i = floor(max((CurrentRow + (rango*5))/sHeight, 0));
    ds_l_beats = ds_list_find_value(Steps, i);
    if (!is_undefined(ds_l_beats)) {
        size_l_beats = ds_list_size(ds_l_beats);
        pos_yy = (i*sHeight) - CurrentRow - rango*6;
        beats_height = (sHeight/size_l_beats);
        var j = floor(max((-pos_yy)/beats_height, 0));
        step = ds_list_find_value(ds_l_beats, j);
        if (!is_undefined(step) && step != "00000") {
            yy = pos_yy + (beats_height*j);
            if (floor(yy) >= -rango && ceil(yy) <= -rango+5) {
                yyyy = barra_yy+yy;
                //string_delete(step, i, 1);
                //string_insert('0', step, i);
                key_q = min(real(string_char_at(step, 2)), 1);
                key_e = min(real(string_char_at(step, 4)), 1);
                key_s = min(real(string_char_at(step, 3)), 1);
                key_z = min(real(string_char_at(step, 1)), 1);
                key_c = min(real(string_char_at(step, 5)), 1);
                step = "00000";
                ds_list_replace(ds_l_beats, j, step);
            }
        }
    }


    limite[1] = 80;
    limite[3] = 80;
    limite[2] = 80;
    limite[0] = 80;
    limite[4] = 80;
    
