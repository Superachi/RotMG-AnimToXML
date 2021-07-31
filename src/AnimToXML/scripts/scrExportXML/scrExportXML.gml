function exportXML(){
	var _sheetName = global.fileName;
	var _frameTime = 0.1;
	
	// Start the string with an animation tag
	var _str = "<Animation period=\"0\" prob=\"1\">\n";
	
	// Add the animation frames with the timing
	for (var _y = 0; _y < gridHeight; _y ++) {
		for (var _x = 0; _x < gridWidth; _x ++) {
			if selectionGrid[# _x, _y] {
				var _dec = _x + (_y * 16);
				
				if _dec < 16 {
					var _index = "0x0";
				} else {
					var _index = "0x";
				}
				
				_index += string_lower(dec_to_hex(_dec, 1));
				_str +=	"<Frame time=\"" + string(_frameTime)
				+ "\"><Texture><File>" + string(_sheetName)
				+ "</File><Index>" + string(_index)
				+ "</Index></Texture></Frame>\n";
			}
		}
	}
	
	// End the string with a closing animation tag
	_str += "</Animation>";
	
	clipboard_set_text(_str);
	show_message("Saved xml to clipboard!")
}