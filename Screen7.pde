class Screen7 extends Screen {
  // Calandar

  Calendar currCalendar;

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "7";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[1];
    buttons[0] = new Button(width/2-100, height/6+20, 200, 80, color(255, 0, 0), 20);
    buttons[0].setLabel("Calendars", 14, 255);

    extraActions();

    currCalendar.year = currCalendar.cYear;
    currCalendar.month = currCalendar.cMonth;
  }

  // Does the extra actions
  // Precondition: extra is an int from the last Screen
  // Postcondition: actions are taken according to the int extra
  void extraActions() {
    if (extra == 0) {
      currCalendar = calendar;
    }
    else if (extra == 1) {
      currCalendar = houseCalendar;
    }
    else if (extra == 2) {
      currCalendar = senateCalendar;
    }
    //else if (extra > 2 && extra < )
    /* Calendars:
        * all
        * House
        * Senate
        * House committees
        * Senate committees
    */
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    currCalendar.display();

  }

}
