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

  Slider(float xVal, float yVal, int max, float leng) {
    x = xVal;
    y = yVal;
    len = leng;
    maxVal = max;
    visible = true;
  }

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
  
  boolean isInside(float mX, float mY) {
    return mX > x+value*len/maxVal-boxSize/2 && mX < x+value*len/maxVal+boxSize/2 && mY > y-boxSize/2 && mY < y+boxSize/2;
  }
}