class MenuScreen extends Screen {
  String toString() {
    return "menu";
  }

  MenuScreen() {
    super();
    setScreen();
  }

  void setScreen() {
    buttons = new Button[5];
    buttons[0] = new Button(width/2-100, height/6+height*2/15, 200, 60, color(255, 0, 0), 0);
    buttons[0].setLabel("Save", 14, 255);
    buttons[1] = new Button(width/2-100, height/2, 200, 60, color(255, 0, 0), 0);
    buttons[1].setLabel("Load", 14, 255);
    buttons[2] = new Button(width/2-100, height/2, 200, 60, color(255, 0, 0), 0);
    buttons[2].setLabel("Main Menu", 14, 255);
    buttons[3] = new Button(width/2-100, height/2, 200, 60, color(255, 0, 0), 0);
    buttons[3].setLabel("Quit Game", 14, 255);
    buttons[4] = new Button(width/2-100, height/2, 200, 60, color(255, 0, 0), 0);
    buttons[4].setLabel("Return to Game", 14, 255);
  }

  void display() {
    super.display();
    fill(255);
    rect(width/4, height/6, width/2, height*2/3);
    displayButtonsSliders();
  }


}
