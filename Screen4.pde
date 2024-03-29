class Screen4 extends Screen {
  //Executive Orders

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "4";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[2];
    buttons[0] = new Button(width/2-220, height/2-30, 200, 60, color(255, 0, 0), 28);
    buttons[0].setLabel("See Executive Orders", 14, 255);
    buttons[1] = new Button(width/2+20, height/2-30, 200, 60, color(255, 0, 0), 29);
    buttons[1].setLabel("New Executive Order", 14, 255);

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();



  }

}
