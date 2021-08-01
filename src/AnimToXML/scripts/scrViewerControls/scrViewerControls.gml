function deleteAnimPreview() {
	if instance_exists(oAnimPreview) {
		instance_destroy(oAnimPreview);
	}
}

function clearSelectionGrid() {
	ds_grid_clear(selectionGrid, false);
}

function setSelectionGrid() {
	// If the rectangle was drawn from right to left or bottom to top,
	// swap coordinates to make the next for loop work
	if selectStartX > selectEndX {
		var _temp = selectStartX;
		selectStartX = selectEndX;
		selectEndX = _temp;
	}
		
	if selectStartY > selectEndY {
		var _temp = selectStartY;
		selectStartY = selectEndY;
		selectEndY = _temp;
	}
		
	// Use the selection rectangle to mark the frames in the grid
	for (var _y = selectStartY; _y < selectEndY; _y ++)  {
		for (var _x = selectStartX; _x < selectEndX; _x ++) {
			// Toggle the frame's activity in the selection ds_grid
			selectionGrid[# _x, _y] = !selectionGrid[# _x, _y];
		}
	}
		
	// Reset selection rectangle values
	selectStartX = -1;
	selectEndX = -1;
	selectStartY = -1;
	selectEndY = -1;
}

function toggleSpriteSize() {
	switch cellSize {
		case 8:
			cellSize = 16;
		break;
		case 16:
			cellSize = 32;
		break;
		case 32:
			cellSize = 8;
		break;
	}
		
	cellWidth = cellSize;
	cellHeight = cellSize;
	clearSelectionGrid();
}