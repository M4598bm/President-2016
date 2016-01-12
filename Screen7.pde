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
    buttons = new Button[1+3+houseCommittees.length+senateCommittees.length];
    buttons[0] = new Button(width/2-100, height/6+20, 200, 80, color(255, 0, 0), 20);
    buttons[0].setLabel("Calendars", 14, 255);

    extraActions();

    // set other buttons
    for (int i = 0; i < houseCommittees.length; i++) {
      buttons[i] = new Button(width/6, 40+(i-3)*30, textWidth(houseCommittee[i].name), 30, color(0, 0, 0), 7);
      buttons[i].setLabel(houseCommittee[i].name, 14, color(200, 0, 0));
      buttons[i].extra = i+3;
      buttons[i].variance = 1;
    }

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
    else if (extra < houseCommittees.length+3) {
      currCalendar = houseCommittees[extra-3].calendar;
    }
    // houseCommittees.length = 2 senateCommittees.length = 3
    else if (extra < houseCommittees.length+senateCommittees.length+3) {
      currCalendar = senateCommittees[extra-3-houseCommittees.length];
    }
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
