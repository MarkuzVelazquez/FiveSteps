switch(argument[0]) {
case 0:
var OFFSET = ds_map_find_value(archivo, "OFFSET");
switch(sign(OFFSET)) {
    case 1:
        OFFSET = OFFSET//+(((CurrentRow+80-(OFFSET*room_speed))/((3.2)*BPM*delta))/room_speed);
        alarm_s[1] = OFFSET*room_speed;
    break;
    case -1: case 0:
        OFFSET = -OFFSET//+(((CurrentRow+80)/((3.2/room_speed)*BPM*delta))/room_speed);
        sound = audio_play_sound(music, 100, false);
        audio_sound_set_track_position(sound, OFFSET);
    break;
}
break;
case 1:
audio_play_sound(music, 100, false);
break;

case 2:
    var t = argument[1]-argument[2];
    CurrentRow = scr_cambio_bpm(CurrentRow+3.2*BPM*delta*t);
    
break;
case 4:
    Speed = Speed2;
    //show_debug_message(Speed);
break;

case 10:
CurrentRow -= VSP;
break;
case 12:
if (argument[2] >= 0) {
    var amount = clamp((1/argument[2])*argument[1], 0, 1);
    Speed = lerp(Speed1, Speed2, amount);
    //show_debug_message("Inicio "+string(Speed1));
    //show_debug_message("Final "+string(Speed2));
    //show_debug_message("Amount "+string(amount));
}
break;
}

