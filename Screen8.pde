class Screen8 extends Screen {
  // War

  String toString() {
    return "8";
  }

  void setScreen() {
    buttons = new Button[4];
    buttons[0] = new Button(width/6, height/2-100, width*5/24, 100, color(255, 0, 0), 0);
    buttons[0].setLabel("Army", 14, 255);
    buttons[1] = new Button(width/6, height/2-100, width*5/24, 100, color(255, 0, 0), 0);
    buttons[1].setLabel("Navy", 14, 255);
    buttons[2] = new Button(width/6, height/2-100, width*5/24, 100, color(255, 0, 0), 0);
    buttons[2].setLabel("Marines", 14, 255);
    buttons[3] = new Button(width*5/6, height/2-100, width*5/24, 100, color(255, 0, 0), 0);
    buttons[3].setLabel("Advisors", 14, 255);
  }

  void display() {
    super.display();


  }

}