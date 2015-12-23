class Button {
  color col;
  float x;
  float y;
  float w;
  float h;
  int command;
  int extra;
  boolean visible;
  boolean clickable;

  int variance;

  color scrollCol;
  boolean scrolled;

  String label;
  int lSize;
  color lCol;

  Button(float xV, float yV, float wV, float hV, color c, int s) {
    x = xV;
    y = yV;
    w = wV;
    h = hV;
    col = c;
    command = s;
    visible = true;
    clickable = true;
    lSize = 14;
  }
  // This constructor is for when newScreen(this) needs to be called but there is no button yet
  Button(int s) {
    command = s;
  }
  
  void setLabel(String l, int lS, color lC) {
    label = l;
    lSize = lS;
    lCol = lC;
  }

  void display() {
    if (visible) {
      if (scrolled)
        fill(scrollCol);
      else
        fill(col);
      if (variance != 1) {
        rect(x, y, w, h, 5);
        textAlign(CENTER, CENTER);
      }
      else
        textAlign(LEFT, CENTER);
      fill(lCol);
      textSize(lSize);
      if (variance != 1)
        text(label, x+w/2, y+h/2);
      else
        text(label, x, y);
    }
  }

  boolean isInside(float Mx, float My) {
    return Mx > x && Mx < x+w && My > y && My < y+h;
  }
}
