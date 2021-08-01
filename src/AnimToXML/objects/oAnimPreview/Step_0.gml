/// @desc
var _len = array_length(animArray[0]);
if _len > 0 {
	if animDelay > 0 {
		animDelay --;
	} else {
		animDelay = animArray[1][currentIndex] * 60 * 0.8;
		
		currentIndex ++;
		if currentIndex >= _len {
			currentIndex = 0;
		}
	}
}

sheetCursorX = animArray[2][currentIndex];
sheetCursorY = animArray[3][currentIndex];