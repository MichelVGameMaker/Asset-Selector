// User interface imguigml instructions
if !imguigml_ready() exit;
imguigml_set_next_window_pos(5, 5, EImGui_Cond.Once)
imguigml_begin("Console");
imguigml_separator()

var _return;
// Sprite selection demo
imguigml_text("The Selector below only works with sprite assets");
_return = sprite_selector.imguigml_step(2);
if _return[0] // _return[0] tells us if an asset was clicked
{
	show_debug_message("You clicked " + sprite_get_name(_return[1]) + "."); // _return[1] holds the asset id
	sprite_index = _return[1];
	show_debug_message("I changed the sprite assigned to the oScan_Demo instance.");
}
imguigml_separator()

// Tileset selection demo
imguigml_text("The Selector below only works with tileset assets");
_return = tileset_selector.imguigml_step(2);
if _return[0] // if an asset was clicked
{
	show_debug_message("You clicked " + tileset_get_name(_return[1]) + ".");
	tilemap_tileset(layer_tilemap_get_id("Tiles"), _return[1]);
	show_debug_message("I changed the tileset assigned to layer 'Tiles'.");
}
imguigml_separator()

// Any asset demo
imguigml_text("This Selector can be customized to any asset types");
_return = any_selector.imguigml_step(5);
if _return[0] // if an asset was clicked
{
	show_debug_message("You clicked something... but I was too lazy to demo this part.");
}

imguigml_end();
	