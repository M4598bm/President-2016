class MenuScreen extends Screen {

  // toString method
  // Precondition: none
  // Postcondition: returns "menu"
  String toString() {
    return "menu";
  }

  // Constructor
  // Precondition: the super class sets all the values
  // Postcondition: creates the Object
  MenuScreen() {
    super();
    setScreen();
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[5];
    buttons[0] = new Button(width/2-100, height/4+(height/2)*0/5, 200, height/10, color(255, 0, 0), 100);
    buttons[0].setLabel("Save", 14, 255);
    buttons[1] = new Button(width/2-100, height/4+(height/2)*1/5, 200, height/10, color(255, 0, 0), 101);
    buttons[1].setLabel("Load", 14, 255);
    buttons[2] = new Button(width/2-100, height/4+(height/2)*2/5, 200, height/10, color(255, 0, 0), 102);
    buttons[2].setLabel("Main Menu", 14, 255);
    buttons[3] = new Button(width/2-100, height/4+(height/2)*3/5, 200, height/10, color(255, 0, 0), 103);
    buttons[3].setLabel("Quit Game", 14, 255);
    buttons[4] = new Button(width/2-100, height/4+(height/2)*4/5+50, 200, height/10, color(255, 0, 0), 104);
    buttons[4].setLabel("Return to Game", 14, 255);

    extraActions();

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);

}

  // Does the extra actions
  // Precondition: extra is an int from the last Screen
  // Postcondition: actions are taken according to the int extra
  void extraActions() {
    if (extra == 0) {// Save

    }
    else if (extra == 1) {// Load

    }
    else if (extra == 2) {// Main Menu

    }
    else if (extra == 3) {// Quit Game
      exit();// Exit the game! Fun! Save first when it exists
    }
    else if (extra == 4) {// Return to Game
      menuOpen = !menuOpen;
      displayAll();
    }

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
    text("Main Menu", width/2, height/8);
    displayButtonsSliders();
  }


}
