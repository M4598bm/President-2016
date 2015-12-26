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

  // Constructor
  // Precondition: each of the variables represent the variables that need to be set
  // Postcondition: creates the Object
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

  // sets the label on the button
  // Precondition: each button has a label with these three parameters
  // Postcondition: the button label is set
  void setLabel(String l, int lS, color lC) {
    label = l;
    lSize = lS;
    lCol = lC;
  }

  // displays the button
  // Precondition: the variables are all set to be used here
  // Postcondition: a button is shown on the screen
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
  // returns if the mouse is inside the button
  // Precondition: mX and mY are most likely the x and y of the mouse, theoretically any x or y
  // Postcondition: returns if mX and mY are inside of the button's coords
  boolean isInside(float mX, float mY) {
    return mX > x && mX < x+w && mY > y && mY < y+h;
  }
}
