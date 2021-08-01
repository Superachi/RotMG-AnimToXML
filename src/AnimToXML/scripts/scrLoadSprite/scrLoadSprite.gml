// Allow the user to import a sprite sheet
function importSprite() {
	var _sprite = sprPlaceholder;
	var _file = get_open_filename_ext("", "", "", "Open a sprite sheet");
	var _fname = filename_name(_file);
	_fname = string_delete(_fname, string_length(_fname) - 3, 5);
	
	if _file != "" {
		var _sprite = sprite_add(_file, 1, false, false, 0, 0);
	}
	
	global.loadedSprite = _sprite;
	global.fileName = _fname;
	
	with(oSheetViewer) {
		gridWidth = 16;
		gridHeight = sprite_get_height(_sprite) div cellHeight + 1;
		ds_grid_resize(selectionGrid, gridWidth, gridHeight);
		clearSelectionGrid();
	}
}