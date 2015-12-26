class Slider {
  float x;
  float y;
  float len;
  float boxSize;
  int value;
  int maxVal;
  float boxX;
  float boxY;
  boolean visible;

  String units;

  // Constructor
  // Precondition: each of the variables represent the variables that need to be set
  // Postcondition: creates the Object
  Slider(float xVal, float yVal, int max, float leng) {
    x = xVal;
    y = yVal;
    len = leng;
    maxVal = max;
    visible = true;
  }

  // Displays this slider
  // Precondition: all variables are set
  // Postcondition: the slider is displayed with updates sometimes
  void display() {
    if (visible) {
      fill(0);
      textAlign(LEFT, CENTER);
      textSize(16);
      text(maxVal+" "+units, x+len+5, y);
      strokeWeight(2);
      line(x, y, x+len, y);
      strokeWeight(1);
      textAlign(CENTER, CENTER);
      textSize(12);
      boxSize = textWidth(""+value)+5;
      fill(255);
      rect(x+value*len/maxVal-boxSize/2, y-boxSize/2, boxSize, boxSize);
      fill(0);
      text(value, x+value*len/maxVal, y);
    }
  }


  // returns if the mouse is inside the slider box
  // Precondition: mX and mY are most likely the x and y of the mouse, theoretically any x or y
  // Postcondition: returns if mX and mY are inside of the slider box's coords
  boolean isInside(float mX, float mY) {
    return mX > x+value*len/maxVal-boxSize/2 && mX < x+value*len/maxVal+boxSize/2 && mY > y-boxSize/2 && mY < y+boxSize/2;
  }
}
