class Screen6 extends Screen {
  // United Nations

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "6";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[3];
    buttons[0] = new Button(width/2-460, height/2-80, 300, 80, color(255, 0, 0), 25);
    buttons[0].setLabel("General Assembly Resolutions", 14, 255);
    buttons[1] = new Button(width/2-150, height/2-100, 300, 80, color(255, 0, 0), 26);
    buttons[1].setLabel("Security Council", 14, 255);
    buttons[2] = new Button(width/2+160, height/2-100, 300, 80, color(255, 0, 0), 27);
    buttons[2].setLabel("International Treaties", 14, 255);
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();



  }

}
