///cargar_archivo(sma, cargar pasos??)
// Se carga el archivo .sma
// cargar pasos?? = si quieres que tambien se cargen las pasos de la cancion
// porque esto?? pues porque si solo queremos cargar la info de la cancion
// no necesitamos saber los pasos de ella
globalvar steps_file, background_file, music_file, archivo;
var file, linea, linea_ext, pos_init, pos_end, key, value, l_value, ds_map_value, ds_l_value, steps_buffer;
steps_file = argument0;
archivo = ds_map_create();

if (!argument1) {
    ds_m_info = ds_map_create();
    ds_map_add_list(ds_m_info, "StepsType", ds_list_create());
    ds_map_add_list(ds_m_info, "Description", ds_list_create());
    ds_map_add_list(ds_m_info, "Difficulty", ds_list_create());
    ds_map_add_list(ds_m_info, "DifficultyLevel", ds_list_create());
}

if (steps_file != '') {
    path = filename_dir(steps_file);
    file = file_text_open_read(steps_file);
    while(!file_text_eof(file)) {
        /*
         * Obtenemos la informacion sin comentarios y sin saltos de linea
         */
        linea = file_text_readln(file);
        linea = clear_comentario(linea);
        pos_init = string_pos("#", linea);
        pos_end = string_pos(";", linea);
        if (pos_init != 0) {
            if (pos_end != 0) { // Si esta todo en la misma linea
                linea = string_copy(linea, pos_init+1, pos_end-(pos_init+1));
            }
            else { // Si esta en distintas lineas
                linea = string_copy(linea, pos_init+1, (string_length(linea)-1)-(pos_init+1));
                while(!file_text_eof(file)) {
                    linea_ext = file_text_readln(file);
                    linea_ext = clear_comentario(linea_ext);
                    pos_end = string_pos(";", linea_ext);
                    if (pos_end != 0) {
                        linea += string_copy(linea_ext, 1, pos_end-1);
                        break;
                    }
                    else {
                        linea_ext = string_copy(linea_ext, 1, string_length(linea_ext)-1-1);
                        linea += linea_ext;
                        continue;
                    }
                }
            }
        }
        else { // linea vasia
            continue;
        }
        
        /*
         * Guardar la informacion
         */
        pos_init = string_pos(":", linea);
        key = string_copy(linea, 1, pos_init-1);
        key = string_replace_all(key, ' ', '');
        switch(key) {
            case "TITLE": case "ARTIST": case "MUSIC": case "BACKGROUND":
                value = string_copy(linea, pos_init+1, string_length(linea)-pos_init);
                ds_map_add_r(archivo, key, value);
            break;
            case "OFFSET":
                value = real(string_copy(linea, pos_init+1, string_length(linea)-pos_init));
                ds_map_add_r(archivo, key, value);
            break;
            case "BPMS": case "STOPS": case "DELAYS": case "TICKCOUNT": case "SPEED":
            case "MULTIPLIER": case "FAKES":
                value = string_copy(linea, pos_init+1, string_length(linea)-pos_init);
                value = string_replace_all(value, ' ', '');
                show_debug_message(value);
                ds_l_value = ds_list_create();
                while(linea != '') {
                    pos_end = string_pos(",", value);
                    if (pos_end != 0) {
                        l_value = string_copy(value, 1, pos_end-1);
                        if (l_value != '') {
                            pos_init = string_pos("=", value);
                            ds_map_value = ds_map_create();
                            ds_map_add(ds_map_value, "Time", real(string_copy(l_value, 1, pos_init-1)));
                            show_debug_message("TIME "+string(string_copy(l_value, 1, pos_init-1)));
                            ds_map_add(ds_map_value, "Value", real(string_copy(l_value, pos_init+1, string_length(l_value)-pos_init)));
                            //show_debug_message("VAlue "+string(string_copy(l_value, pos_init+1, string_length(l_value)-pos_init)));
                            if (key == "SPEED") {
                                l_value = string_copy(l_value, pos_init+1, string_length(l_value)-pos_init);
                                pos_init = string_pos("=", l_value);
                                l_value = string_copy(l_value, pos_init+1, string_length(l_value)-pos_init);
                                show_debug_message(l_value);
                                ds_map_add(ds_map_value, "Time2", real(l_value));
                            }
                            ds_list_add(ds_l_value, ds_map_value);
                            ds_list_mark_as_map (ds_l_value, ds_list_find_index(ds_l_value, ds_map_value));
                            value = string_copy(value, pos_end+1, string_length(value)-pos_end);
                        }
                    }
                    else {
                        l_value = string_copy(value, 1, string_length(value));
                        if (l_value != '') {
                            pos_init = string_pos("=", value);
                            ds_map_value = ds_map_create();
                            ds_map_add(ds_map_value, "Time", real(string_copy(l_value, 1, pos_init-1)));
                            ds_map_add(ds_map_value, "Value", real(string_copy(l_value, pos_init+1, string_length(l_value)-pos_init)));
                            if (key == "SPEED") {
                                l_value = string_copy(l_value, pos_init+1, string_length(l_value)-pos_init);
                                pos_init = string_pos("=", l_value);
                                l_value = string_copy(l_value, pos_init+1, string_length(l_value)-pos_init);
                                show_debug_message(l_value);
                                ds_map_add(ds_map_value, "Time2", real(l_value));
                            }
                            ds_list_add(ds_l_value, ds_map_value);
                            ds_list_mark_as_map (ds_l_value, ds_list_find_index(ds_l_value, ds_map_value));
                        }
                        break;
                    }
                }
                ds_map_add_list_r(archivo, key, ds_l_value);
            break;
            case "NOTES":
                // Leemos informacion de las notas
                linea = string_copy(linea, pos_init+1, string_length(linea)-pos_init);
                pos_init = string_pos(":", linea);
                value = string_copy(linea, 1, pos_init-1);
                value = string_replace_all(value, ' ', '');
                ds_map_add_r(archivo, "StepsType", value);
                
                linea = string_copy(linea, pos_init+1, string_length(linea)-pos_init);
                pos_init = string_pos(":", linea);
                for(var i = 1; i < pos_init; i++) {
                    if (string_char_at(linea, i) != ' ') {
                        value = string_copy(linea, i, pos_init-i);
                        break;
                    }
                }
                ds_map_add_r(archivo, "Description", value);
                
                linea = string_copy(linea, pos_init+1, string_length(linea)-pos_init);
                pos_init = string_pos(":", linea);
                value = string_copy(linea, 1, pos_init-1);
                value = string_replace_all(value, ' ', '');
                ds_map_add_r(archivo, "Difficulty", value);
                
                linea = string_copy(linea, pos_init+1, string_length(linea)-pos_init);
                pos_init = string_pos(":", linea);
                value = string_copy(linea, 1, pos_init-1);
                value = string_replace_all(value, ' ', '');
                ds_map_add_r(archivo, "DifficultyLevel", real(value));
                
                linea = string_copy(linea, pos_init+1, string_length(linea)-pos_init);
                pos_init = string_pos(":", linea);
                value = string_copy(linea, 1, pos_init-1);
                value = string_replace_all(value, ' ', '');
                ds_l_value = ds_list_create();
                while(value != '') {
                    pos_end = string_pos(",", value);
                    if (pos_end != 0) {
                        l_value = real(string_copy(value, 1, pos_end-1));
                        ds_list_add(ds_l_value, l_value);
                        value = string_copy(value, pos_end+1, string_length(value)-pos_end);
                    }
                    else {
                        l_value = real(string_copy(value, 1, string_length(value)));
                        ds_list_add(ds_l_value, l_value);
                        break;
                    }
                }
                ds_map_add_list(archivo, "Radar", ds_l_value);
                
                if (argument1) {
                    if
                    (ds_map_find_value(archivo, "DifficultyLevel") == ds_list_find_value(ds_map_find_value(INFO[select], "DifficultyLevel"), level)
                    && ds_map_find_value(archivo, "Difficulty") == ds_list_find_value(ds_map_find_value(INFO[select], "Difficulty"), level)
                    && ds_map_find_value(archivo, "StepsType") == ds_list_find_value(ds_map_find_value(INFO[select], "StepsType"), level)
                    && ds_map_find_value(archivo, "Description") == ds_list_find_value(ds_map_find_value(INFO[select], "Description"), level))
                    {
                    // Ahora si a leer las pasos
                    value = string_copy(linea, pos_init+1, string_length(linea)-pos_init);
                    value = string_replace_all(value, ' ', '');
                    ds_l_value = ds_list_create();
                    switch(ds_map_find_value(archivo, "StepsType")) {
                        case "pump-single":
                            while(value != '') {
                                pos_end = string_pos(",", value);
                                if (pos_end != 0) {
                                    l_value = string_copy(value, 1, pos_end-1);
                                    ds_l_steps = ds_list_create();
                                    while(l_value != '') {
                                        ds_list_add(ds_l_steps, string_copy(l_value, 1, 5));
                                        l_value = string_copy(l_value, 6, string_length(l_value)-5);
                                    }
                                    ds_list_add(ds_l_value, ds_l_steps);
                                    ds_list_mark_as_list(ds_l_value, ds_list_find_index(ds_l_value, ds_l_steps));
                                    value = string_copy(value, pos_end+1, string_length(value)-pos_end);
                                }
                                else {
                                    l_value = string_copy(value, 1, string_length(value));
                                    ds_l_steps = ds_list_create();
                                    while(l_value != '') {
                                        ds_list_add(ds_l_steps, string_copy(l_value, 1, 5));
                                        l_value = string_copy(l_value, 6, string_length(l_value)-5);
                                    }
                                    ds_list_add(ds_l_value, ds_l_steps);
                                    ds_list_mark_as_list(ds_l_value, ds_list_find_index(ds_l_value, ds_l_steps));
                                    break;
                                }
                            }
                        break;
                    }
                    ds_map_add_list_r(archivo, "Steps", ds_l_value);
                    
                    // Una vez cargado las pasos que queremos de la cancion podemos salir del script
                    file_text_close(file);
                    
                    background_file = path+'\'+ds_map_find_value(archivo, "BACKGROUND");
                    music_file = path+'\'+ds_map_find_value(archivo, "MUSIC");
                    exit;
                    }
                }
                else {
                    ds_list_add(ds_map_find_value(ds_m_info, "StepsType"), ds_map_find_value(archivo, "StepsType"));
                    ds_list_add(ds_map_find_value(ds_m_info, "Description"), ds_map_find_value(archivo, "Description"));
                    ds_list_add(ds_map_find_value(ds_m_info, "Difficulty"), ds_map_find_value(archivo, "Difficulty"));
                    ds_list_add(ds_map_find_value(ds_m_info, "DifficultyLevel"), ds_map_find_value(archivo, "DifficultyLevel"));
                }
            break;
        }
        
    }
    file_text_close(file);
}
