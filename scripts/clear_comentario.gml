/// clear_comentario(str);
var pos_comentario = string_pos("//", argument0);
if (pos_comentario != 0) {
    return string_copy(argument0, 1, pos_comentario+1);
}
else {
    return argument0;
}
