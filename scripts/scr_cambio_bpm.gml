var CurrentRow = argument0;
if (bpm_time_next != -1 && !is_undefined(ds_map_BPMS) && CurrentRow >= bpm_time_next) {
    // Corregir currentrow para no perder la sincronizacion
    var t = (CurrentRow - bpm_time_next)/(3.2*BPM);
    BPM = ds_map_find_value(ds_map_BPMS, "Value");
    var prev_CR = CurrentRow;
    CurrentRow = bpm_time_next+3.2*BPM*t;
    
    ds_map_BPMS = ds_list_find_value(BPMS, ds_list_find_index(BPMS, ds_map_BPMS)+1);
    if (!is_undefined(ds_map_BPMS)) {
        bpm_time_next = ds_map_find_value(ds_map_BPMS, "Time");
        
        // Efecto de salto
        var BPM_NEXT = ds_map_find_value(ds_map_BPMS, "Value");
        while(BPM < 0 && !is_undefined(BPM_NEXT) && BPM_NEXT >= 0) {
            var t = abs((prev_CR-bpm_time_next)/(3.2*BPM));
            BPM = BPM_NEXT;
            show_debug_message(BPM);
            
            for(var i = 0; i < 5; i++) {
                encontrado[i] = false;
            }
            
            check_pista(prev_CR, t);
            
            
            CurrentRow = bpm_time_next+3.2*BPM*t; // Aqui el salto
            ds_map_BPMS = ds_list_find_value(BPMS, ds_list_find_index(BPMS, ds_map_BPMS)+1);
            if (!is_undefined(ds_map_BPMS)) {
                bpm_time_next = ds_map_find_value(ds_map_BPMS, "Time");
                
                // Bucle de efecto de salto
                var BPM_NEXT = ds_map_find_value(ds_map_BPMS, "Value");
                continue;    
            }
            
        }
    }
}
return CurrentRow;
