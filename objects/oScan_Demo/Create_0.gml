// This is imguigml code
if (!instance_exists(imgui)) 
{
	instance_create_depth(0, 0, depth-10, imgui);
	imguigml_add_font_from_ttf("04b24.ttf", 12.0);
}
imguigml_activate();

// This is the Asset Selector demo part
sprite_selector  = new G2L_Asset_Selector(asset_sprite, false);
tileset_selector = new G2L_Asset_Selector(asset_tiles, false);
any_selector     = new G2L_Asset_Selector(undefined, true);