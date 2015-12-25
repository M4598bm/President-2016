class MenuScreen extends Screen {
  String toString() {
    return "menu";
  }

  MenuScreen() {
    super();
    setScreen();
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[5];
    buttons[0] = new Button(width/2-100, 70+(height-70)*0/5, 200, (height-65)/10, color(255, 0, 0), 100);
    buttons[0].setLabel("Save", 14, 255);
    buttons[1] = new Button(width/2-100, 70+(height-70)*1/5, 200, (height-65)/10, color(255, 0, 0), 101);
    buttons[1].setLabel("Load", 14, 255);
    buttons[2] = new Button(width/2-100, 70+(height-70)*2/5, 200, (height-65)/10, color(255, 0, 0), 102);
    buttons[2].setLabel("Main Menu", 14, 255);
    buttons[3] = new Button(width/2-100, 70+(height-70)*3/5, 200, (height-65)/10, color(255, 0, 0), 103);
    buttons[3].setLabel("Quit Game", 14, 255);
    buttons[4] = new Button(width/2-100, 70+(height-70)*4/5, 200, (height-65)/10, color(255, 0, 0), 104);
    buttons[4].setLabel("Return to Game", 14, 255);

    if (extra == 0) {

    }
    else if (extra == 1) {

    }
    else if (extra == 2) {

    }
    else if (extra == 3) {
      exit();// Exit the game! Fun! Save first when that exists
    }
    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
  }


  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    fill(255);
    rect(width/4, 30, width/2, height-30);
    fill(0);
    textSize(30);
    textAlign(CENTER, TOP);
    text("Main Menu", width/2, 35);
    displayButtonsSliders();
  }


}
