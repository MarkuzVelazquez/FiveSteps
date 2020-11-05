BPMS = ds_map_find_value(archivo, "BPMS");
ds_map_BPMS = ds_list_find_value(BPMS, 0);
BPM = ds_map_find_value(ds_map_BPMS, "Value");
ds_map_BPMS = ds_list_find_value(BPMS, 1);
if (!is_undefined(ds_map_BPMS)) {
    bpm_time_next = ds_map_find_value(ds_map_BPMS, "Time");
}
else {
    bpm_time_next = -1;
}


STOPS = ds_map_find_value(archivo, "STOPS");
ds_map_STOPS = ds_list_find_value(STOPS, 0);
if (!is_undefined(ds_map_STOPS)) {
    stop_time_next = ds_map_find_value(ds_map_STOPS, "Time");
}
else {
    stop_time_next = -1;
}

DELAYS = ds_map_find_value(archivo, "DELAYS");
ds_map_DELAYS = ds_list_find_value(DELAYS, 0);
if (!is_undefined(ds_map_DELAYS)) {
    delay_time_next = ds_map_find_value(ds_map_DELAYS, "Time");
}
else {
    delay_time_next = -1;
}

SPEED = ds_map_find_value(archivo, "SPEED");
ds_map_SPEED = ds_list_find_value(SPEED, 0);
Speed = ds_map_find_value(ds_map_SPEED, "Value");
Speed2 = Speed;
ds_map_SPEED = ds_list_find_value(SPEED, 1);
if (!is_undefined(ds_map_SPEED)) {
    speed_time_next = ds_map_find_value(ds_map_SPEED, "Time");
}
else {
    speed_time_next = -1;
}

Steps = ds_map_find_value(archivo, "Steps");

background = background_add(background_file, false, false);

music = audio_create_stream(music_file);

