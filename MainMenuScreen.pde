class MainMenuScreen extends Screen {
  // Main Menu

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "main menu";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    menuOpen = false;

    buttons = new Button[4];

    float buttonLength = (width*2/3)/buttons.length;
    buttons[0] = new Button(width/6+10+buttonLength*0, height/2, buttonLength-20, 100, color(255, 0, 0), 201);
    buttons[0].setLabel("New Game", 14, 255);
    buttons[1] = new Button(width/6+10+buttonLength*1, height/2, buttonLength-20, 100, color(255, 0, 0), 202);
    buttons[1].setLabel("Load Game", 14, 255);
    buttons[2] = new Button(width/6+10+buttonLength*2, height/2, buttonLength-20, 100, color(255, 0, 0), 203);
    buttons[2].setLabel("Options", 14, 255);
    buttons[3] = new Button(width/6+10+buttonLength*3, height/2, buttonLength-20, 100, color(255, 0, 0), 200);
    buttons[3].setLabel("Exit", 14, 255);
    buttons[3].extra = 1;

    extraActions();

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
  }

  // Does the extra actions
  // Precondition: extra is an int from the last Screen
  // Postcondition: actions are taken according to the int extra
  void extraActions() {
    if (extra == 1) {
      exit();
    }
  }

    /*
       0: Main Menu Screen
       1: New game setup
       2: Load game
       3: Options
    */

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {

    super.display();

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("President", width/2, height/4);
    textSize(30);
    text("Because Building America is Hard", width/2, height/4+40);


    fill(color(255, 0, 0));
    rect(0, height/2, width, 100);

    displayButtonsSliders();
  }

}
