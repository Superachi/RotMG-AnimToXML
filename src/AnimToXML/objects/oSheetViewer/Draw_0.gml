/// @desc
var pixelMult = zoomLevel * cellSize;

// Draw sheet background
draw_set_alpha(0.2);
draw_set_color(c_black);
draw_rectangle(sheetX, 0, sheetX + 16 * zoomLevel * cellWidth - 1, room_height, false);

// Draw the sheet
draw_set_alpha(1);
draw_sprite_ext(global.loadedSprite, 0, sheetX, sheetY, zoomLevel, zoomLevel, 0, c_white, 1);

// Draw the rectangle cursor
draw_set_alpha(0.2);
draw_set_color(c_white);
draw_rectangle(	mouseGridX * pixelMult + sheetX,
				mouseGridY * pixelMult + sheetY,
				mouseGridX * pixelMult + pixelMult - 1 + sheetX,
				mouseGridY * pixelMult + pixelMult - 1 + sheetY,
				false);

// Draw the selection rectangle			
if selectStartX != -1 {
	draw_set_color(c_blue);
	draw_set_alpha(0.5);
	draw_rectangle(	selectStartX * pixelMult + sheetX,
					selectStartY * pixelMult + sheetY,
					selectEndX * pixelMult + sheetX - 1,
					selectEndY * pixelMult + sheetY - 1,
					false);
}
				
// Show selected frames and their animation time
draw_set_halign(fa_left);

for (var _x = 0; _x < gridWidth; _x ++) {
	for (var _y = 0; _y < gridHeight; _y ++) {
		if selectionGrid[# _x, _y] {
			draw_set_color(c_white);
			draw_set_alpha(0.3);
			draw_rectangle(
				_x * pixelMult + sheetX,
				_y * pixelMult + sheetY,
				_x * pixelMult + pixelMult - 1 + sheetX,
				_y * pixelMult + pixelMult - 1 + sheetY,
				false);
			
			if pixelMult >= 48 {
				draw_set_font(fnt_default_bold);
				draw_set_color(c_black);
				draw_set_alpha(1);
				draw_text(_x * pixelMult + sheetX + 4, _y * pixelMult + sheetY + 4, 0.01);
			} else if pixelMult >= 32 {
				draw_set_font(fnt_default_small);
				draw_set_color(c_black);
				draw_set_alpha(1);
				draw_text(_x * pixelMult + sheetX + 4, _y * pixelMult + sheetY + 4, 0.01);
			}
		}
	}
}

// Draw the info sidebar
draw_set_alpha(0.6);
draw_set_color(c_black);
draw_rectangle(room_width - 300, 0, room_width, room_height, false);

// Debug information
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(fnt_default);
draw_set_halign(fa_right);

// Debug info and instruction
var _str =	"mX: " + string(mouseGridX) + " | mY: " + string(mouseGridY) +
			"\nDec index: " + string(decIndex) + " | Hex index: " + string(hexIndex) +
			"\nLoaded file: " + string(global.fileName) +
			"\nSprite size: " + string(cellSize) + " px" +
			"\n\nCONTROLS:" + 
			"\nLeft click & hold to select frames" + 
			"\nMiddle click & hold to pan camera" + 
			"\nScroll to zoom in/out" +
			"\nSpacebar to load sheet" +
			"\n'S' to change the sprite size" +
			"\n'C' to clear selection" +
			"\n'Enter' to save XML to clipboard"
			
draw_text_ext(room_width - 16, 16, _str, 20, 300);