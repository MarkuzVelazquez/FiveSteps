if (ds_map_exists(argument0, argument1)) {
    ds_map_replace_list(argument0, argument1, argument2);
}
else {
    ds_map_add_list(argument0, argument1, argument2);
}

