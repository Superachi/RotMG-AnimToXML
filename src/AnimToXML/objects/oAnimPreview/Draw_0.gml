/// @desc
/*
draw_text(700, 16, "index " + string(currentIndex) +
					"\nx " + string(sheetCursorX) + 
					"\ny " + string(sheetCursorY));*/

var gridW = oSheetViewer.cellWidth;
var gridH = oSheetViewer.cellHeight;
draw_sprite_part_ext(global.loadedSprite, 0, sheetCursorX * gridW, sheetCursorY * gridH,
					gridW, gridH, room_width - 200, 400, 5, 5, c_white, 1);