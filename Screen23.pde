class Screen23 extends Screen {
  // Legislative deals

  String toString() {
    return "23";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[3];
    buttons[0] = new Button(width/2-100, height*5/6, 200, 60, color(255, 0, 0), 24);
    buttons[0].setLabel("Suggest Deal", 14, 255);
    buttons[1] = new Button(width/6, height/2+115, (width/3-40)/2, 50, color(0, 0, 255), 10);
    buttons[1].setLabel("", 14, 255);
    buttons[1].clickable = false;
    buttons[1].extra = 0;

    buttons[2] = new Button(width/2+40+(width/3-40)/2, height/2+115, (width/3-40)/2, 50, color(0, 0, 255), 10);
    buttons[2].setLabel("", 14, 255);
    buttons[2].clickable = false;
    buttons[2].extra = 1;

    println(screens);
    Congressman cman = screens.get(screens.size()-2).search.get(screens.get(screens.size()-2).chosen);

    String[] themActions =
    {" Vote for a bill (+)", " Vote against a bill (+)", " Endorse President"};
    String[] youActions =
    {"Support a bill (+) ", "Denounce a bill (+) ", "Sign a bill (+) ", "Veto a bill (+) ", "No attack ads for... (+) ", "Promise funding ", "Endorse Congressperson "};
    trade = new Interaction(youActions, themActions);
    trade.setCongressTrade();
    search.clear();
    search.add(cman);// The only thing in search should be the chosen congressman
    chosen = -1;
    scrollsX = new int[4];// 0: left, 1: center left, 2: center right, 3: right
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    trade.displayCongressTrade();


  }

}
