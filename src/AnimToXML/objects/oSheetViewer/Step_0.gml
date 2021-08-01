#region Get cursor coordinates
	// Get the mouse's coords on the grid
	mouseGridX = (mouse_x - sheetX) div (zoomLevel * cellWidth);
	mouseGridY = (mouse_y - sheetY) div (zoomLevel * cellHeight);
	mouseGridX = clamp(mouseGridX, 0, gridWidth - 1);

	// Get the index based on the mouse coords
	decIndex = mouseGridX + (mouseGridY * gridWidth);
	hexIndex = "0x" + string(dec_to_hex(decIndex, 1));
#endregion

#region Camera panning and zooming
	// Set the view zoom level
	var _oldZoom = zoomLevel;
	zoomLevel += mouse_wheel_up() - mouse_wheel_down();
	zoomLevel = clamp(zoomLevel, 1, 10);
	
	if _oldZoom != zoomLevel {
		var _mult = zoomLevel / _oldZoom;
		sheetX *= _mult;
		sheetY *= _mult;
	}

	// Allow the user to pan the sheet
	if mouse_check_button(mb_middle) {
		sheetX += mouse_x - mouse_prev_x;
		sheetY += mouse_y - mouse_prev_y;
	}
	
	/*// Snap view to the grid
	if mouse_check_button_released(mb_middle) || _oldZoom != zoomLevel {
		sheetX = round(sheetX / (cellWidth * zoomLevel)) * (cellWidth * zoomLevel);
		sheetY = round(sheetY / (cellHeight * zoomLevel)) * (cellHeight * zoomLevel);
	}*/

	// Clamp the sheet's coordinates
	var _sprW = sprite_get_width(global.loadedSprite) * zoomLevel;
	var _sprH = sprite_get_height(global.loadedSprite) * zoomLevel;
	
	sheetX = clamp(sheetX, -_sprW + cellWidth * zoomLevel, 0);
	sheetY = clamp(sheetY, -_sprH + cellHeight * zoomLevel, 0);
#endregion

#region Allow selection of frames
	// Start creating a rectangle selection
	if mouse_check_button_pressed(mb_left) {
		selectStartX = mouseGridX;
		selectStartY = mouseGridY;
	}
	
	if mouse_check_button(mb_left) {
		selectEndX = mouseGridX + 1;
		selectEndY = mouseGridY + 1;
	}
	
	// Finish the rectangle and apply the selection to the grid
	if mouse_check_button_released(mb_left) {
		// Save the selection
		setSelectionGrid();
		
		// Preview the animation based on the selection
		// Delete the old preview object
		deleteAnimPreview();
		
		// Count the amount of frames
		var _frameCount = 0;
		for (var _x = 0; _x < gridWidth; _x ++)  {
			for (var _y = 0; _y < gridHeight; _y ++) {
				if selectionGrid[# _x, _y] {
					_frameCount ++;
				}
			}
		}
		
		// Create a preview of the animation
		if _frameCount > 0 {
			var _inst = instance_create_depth(0, 0, -100, oAnimPreview);
			var _animFrame = 0;
			var _index = 0;
			
			for (var _y = 0; _y < gridHeight; _y ++)  {
				for (var _x = 0; _x < gridWidth; _x ++) {
					if selectionGrid[# _x, _y] {
						_inst.animArray[0][_animFrame] = _index;	// Set the frame index
						_inst.animArray[1][_animFrame] = 0.1;		// Set the frame duration
						_inst.animArray[2][_animFrame] = _x;		// Save the X coord of the frame in the sheet
						_inst.animArray[3][_animFrame] = _y;		// Save the Y coord of the frame in the sheet
						_animFrame ++;
					}
				
					_index ++;
				}
			}
			
			with (_inst) {
				sheetCursorX = animArray[2][0];
				sheetCursorY = animArray[3][0];
			}
		}
	}
	
	if keyboard_check_pressed(ord("C")) {
		deleteAnimPreview();
		clearSelectionGrid();
	}
#endregion

#region Allow changing of the sprite size
	if keyboard_check_pressed(ord("S")) {
		toggleSpriteSize();
	}
#endregion

#region Save the selection information in a struct
	if keyboard_check_pressed(vk_enter) {
		exportXML();
	}
#endregion