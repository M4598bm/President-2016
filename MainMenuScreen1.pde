class MainMenuScreen1 extends Screen {
  // Main Menu New Game

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "new game";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[1];

    buttons[0] = new Button(width/2-100, height*5/6, 200, 60, color(255, 0, 0), 201);
    buttons[0].setLabel("Start", 14, 255);
    buttons[0].extra = 1;

    extraActions();

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
  }

  // Does the extra actions
  // Precondition: extra is an int from the last Screen
  // Postcondition: actions are taken according to the int extra
  void extraActions() {
    if (extra == 1) {
      mainMenu = false;
      menuActions.newGame();
    }
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();
    displayButtonsSliders();
    println(buttons.length);
  }

}
