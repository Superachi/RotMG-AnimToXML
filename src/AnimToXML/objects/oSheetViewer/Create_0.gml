/// @desc
// Set the view size
zoomLevel = 4;
cellSize = 8;
cellWidth = cellSize;
cellHeight = cellSize;

// Track the cursor coordinates on the grid, as well as the frame index
mouseGridX = 0;
mouseGridY = 0;
mouseGridXPrev = 0;
mouseGridYPrev = 0;

decIndex = 0;
hexIndex = 0;

// Allow for panning of the view
sheetX = 0;
sheetY = 0;
mouse_prev_x = 0;
mouse_prev_y = 0;

#region Variables to allow selection of animation frames
	// Set the size of the ds_grid
	gridWidth = 16;
	gridHeight = 16;
	selectionGrid = ds_grid_create(gridWidth, gridHeight);
	clearSelectionGrid();

	// The boundaries of the selection rectangle
	selectStartX = -1;
	selectStartY = -1;
	selectEndX = -1;
	selectEndY = -1;
#endregion