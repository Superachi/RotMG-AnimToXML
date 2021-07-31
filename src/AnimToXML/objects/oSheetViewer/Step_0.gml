#region Get the mouse position
	// Set the view zoom level
	zoomLevel += mouse_wheel_up() - mouse_wheel_down();
	zoomLevel = clamp(zoomLevel, 2, 10);

	// Get the mouse's coords on the grid
	mouseGridX = (mouse_x - sheetX) div (zoomLevel * cellWidth);
	mouseGridY = (mouse_y - sheetY) div (zoomLevel * cellHeight);
	mouseGridX = clamp(mouseGridX, 0, gridWidth - 1);

	// Get the index based on the mouse coords
	decIndex = mouseGridX + (mouseGridY * gridWidth);
	hexIndex = "0x" + string(dec_to_hex(decIndex, 1));

	// Allow the user to pan the sheet
	if mouse_check_button(mb_middle) {
		sheetX += mouse_x - mouse_prev_x;
		sheetY += mouse_y - mouse_prev_y;
	}

	// Clamp the sheet's coordinates
	var _sprW = sprite_get_width(global.loadedSprite) * zoomLevel;
	var _sprH = sprite_get_height(global.loadedSprite) * zoomLevel;
	
	sheetX = clamp(sheetX, -_sprW + cellWidth * zoomLevel, 0);
	sheetY = clamp(sheetY, -_sprH + cellHeight * zoomLevel, 0);
#endregion

#region Allow selection of frames
	if mouse_check_button_pressed(mb_left) {
		selectionGrid[# mouseGridX, mouseGridY] = !selectionGrid[# mouseGridX, mouseGridY];
	}
#endregion

#region Save the selection information in a struct
	if keyboard_check_pressed(vk_enter) {
		exportXML();
	}
#endregion