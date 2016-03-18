class Screen9 extends Screen {
  // Agencies

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "9";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[2];
    buttons[0] = new Button(width/2-220, height/2-60, 200, 60, color(255, 0, 0), 37);
    buttons[0].setLabel("Central Intelligence", 14, 255);
    buttons[1] = new Button(width/2+20, height/2-60, 200, 60, color(255, 0, 0), 38);
    buttons[1].setLabel("Federal Reserve", 14, 255);

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();


    displayButtonsSliders();
  }

}