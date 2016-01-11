class Screen36 extends Screen {
  // Specific Calendars

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "36";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[1];
    buttons[1] = new Button(width/2-100, height/6, 200, 80, color(255, 0, 0), 20);
    buttons[1].setLabel("Calendars", 14, 255);

    calendar.year = calendar.cYear;
    calendar.month = calendar.cMonth;
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    //display calendar


  }

}
