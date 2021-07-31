/// @desc
// Draw sheet background
draw_set_alpha(0.2);
draw_set_color(c_black);
draw_rectangle(sheetX, 0, sheetX + 16 * zoomLevel * cellWidth - 1, room_height, false);

// Draw the sheet
draw_set_alpha(1);
draw_set_color(c_white);
draw_sprite_ext(global.loadedSprite, 0, sheetX, sheetY, zoomLevel, zoomLevel, 0, c_white, 1);

// Draw the rectangle cursor
draw_set_alpha(0.2);
draw_rectangle(	mouseGridX * zoomLevel * cellWidth  + sheetX,
				mouseGridY * zoomLevel * cellHeight + sheetY,
				mouseGridX * zoomLevel * cellWidth + zoomLevel * cellWidth - 1   + sheetX,
				mouseGridY * zoomLevel * cellHeight + zoomLevel * cellHeight - 1 + sheetY,
				false);
				
// Show selected frames
draw_set_alpha(1);
draw_set_color(c_yellow)
for (var _x = 0; _x < gridWidth; _x ++) {
	for (var _y = 0; _y < gridHeight; _y ++) {
		if selectionGrid[# _x, _y] {
			draw_rectangle(
				_x * zoomLevel * cellWidth + sheetX,
				_y * zoomLevel * cellHeight + sheetY,
				_x * zoomLevel * cellWidth + zoomLevel * cellWidth - 1 + sheetX,
				_y * zoomLevel * cellHeight + zoomLevel * cellHeight - 1 + sheetY,
				true);
		}
	}
}
				
// Debug information

draw_set_color(c_white);
draw_set_halign(fa_right);

// Debug info and instruction
draw_text(room_width - 16, 16,  "mX: " + string(mouseGridX) + " | mY: " + string(mouseGridY) +
								"\nDec index: " + string(decIndex) + " | Hex index: " + string(hexIndex) +
								"\n\nLeft click & hold to select frames" + 
								"\nMiddle click to pan camera" + 
								"\nScroll to zoom in/out" +
								"\nSpacebar to load sheet" +
								"\nEnter to save XML to clipboard");