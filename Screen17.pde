class Screen17 extends Screen {
  // Electoral Map

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "17";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[0];
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    eM.display();
  }

}
