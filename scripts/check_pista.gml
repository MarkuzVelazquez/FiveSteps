var prev_CR = argument0;
var t = argument1;
// Checa la pista que se salto para registrar notas
            init_steps = floor(max((prev_CR-barra_yy-33)/sHeight, 0));
            size_steps = min(ceil(max(((bpm_time_next+BPM*3.2*t)-barra_yy+33)/sHeight, 0)), ds_list_size(Steps));
            for(var k = size_steps-1; k >= init_steps; k--) {
                ds_l_beats = ds_list_find_value(Steps, k);
                size_l_beats = ds_list_size(ds_l_beats);
                pos_yy = barra_yy + (k*sHeight) - prev_CR;
                init_l_beats = ceil(max((-pos_yy-33)/beats_height, 0));
                beats_height = (sHeight/size_l_beats);
                size_l_beats = min(ceil(max((-(barra_yy+(k*sHeight)-(bpm_time_next+BPM*3.2*t))+33)/beats_height, 0)), ds_list_size(ds_l_beats));
                for(var j = size_l_beats-1; j >= init_l_beats; j--) {
                    step = ds_list_find_value(ds_l_beats, j);
                    yy = pos_yy + (beats_height*j);
                    for(var i = 0; i < 5; i++) {
                        if (encontrado[i]) continue;
                        switch(string_char_at(step, i+1)) {
                            case '0': break;
                            case '2': bottom_yy[i] = view_hview+33; encontrado[i] = true; break;
                            case '3': bottom_yy[i] = yy; encontrado[i] = true; break;
                            default: encontrado[i] = true; break;
                        }
                    }
                    if (encontrado[0] && encontrado[1] && encontrado[2] && encontrado[3] && encontrado[4]) break;
                }
                if (encontrado[0] && encontrado[1] && encontrado[2] && encontrado[3] && encontrado[4]) break;
            }
