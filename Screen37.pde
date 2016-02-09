class Screen37 extends Screen {
  // CIA

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
    buttons[0] = new Button(width/2-320, height/2-110, 200, 60, color(255, 0, 0), 39);
    buttons[0].setLabel("Intelligence", 14, 255);
    buttons[0] = new Button(width/2-320, height/2-110, 200, 60, color(255, 0, 0), 40);
    buttons[0].setLabel("Covert Operations", 14, 255);
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();


    displayButtonsSliders();
  }

}
