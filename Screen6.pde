class Screen6 extends Screen {
  // United Nations

  String toString() {
    return "6";
  }

  void setScreen() {
    buttons = new Button[3];
    buttons[0] = new Button(width/2-460, height/2-80, 300, 80, color(255, 0, 0), 25);
    buttons[0].setLabel("General Assembly Resolutions", 14, 255);
    buttons[1] = new Button(width/2-150, height/2-100, 300, 80, color(255, 0, 0), 26);
    buttons[1].setLabel("Security Council", 14, 255);
    buttons[2] = new Button(width/2+160, height/2-100, 300, 80, color(255, 0, 0), 27);
    buttons[2].setLabel("International Treaties", 14, 255);
  }

  void display() {
    super.display();



  }

}
