public class Button {
  color col;
  float x;
  float y;
  float w;
  float h;
  int command;
  
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
  }
  void setLabel(String l, int lS, color lC) {
    label = l;
    lSize = lS;
    lCol = lC;
  }
  
  void display() {
    if (scrolled)
      fill(scrollCol);
    else
      fill(col);
    rect(x, y, w, h, 5);
    fill(lCol);
    textSize(lSize);
    textAlign(CENTER, CENTER);
    text(label, x+w/2, y+h/2);
  }
  
  boolean isInside(float Mx, float My) {
    return Mx > x && Mx < x+w && My > y && My < y+h;
  }
}
