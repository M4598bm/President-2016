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

    buttons[0] = new Button(width/2-100, height*5/6+20, 200, 80, color(255, 0, 0), 7);
    if (extra < 100) {
      buttons[0].setLabel("Calendars", 14, 255);
      buttons[0].extra = 100+extra;
    }
    else {
      buttons[0].setLabel("Back", 14, 255);
      buttons[0].extra = extra-100;
    }

    buttons[1] = new Button(width/2-textWidth("All")/2, height/6+10, textWidth("All"), 30, color(0, 0, 0), 7);
    buttons[1].setLabel("All", 14, color(0, 0, 0));
    buttons[1].extra = 0;
    buttons[1].variance = 1;

    float houseButtonSize = height*2/(3*(houseCommittees.length+1));
    float senateButtonSize = height*2/(3*(senateCommittees.length+1));

    buttons[2] = new Button(width/6+10, height/6, textWidth("House Calendar"), houseButtonSize, color(0, 0, 0), 7);
    buttons[2].setLabel("House Calendar", (int)houseButtonSize/2, color(0, 0, 0));
    buttons[2].extra = 1;
    buttons[2].variance = 1;

    textSize((int)senateButtonSize/2);
    buttons[3] = new Button(width*5/6-textWidth("Senate Calendar")-10, height/6, textWidth("Senate Calendar"), senateButtonSize, color(0, 0, 0), 7);
    buttons[3].setLabel("Senate Calendar", (int)senateButtonSize/2, color(0, 0, 0));
    buttons[3].extra = 2;
    buttons[3].variance = 1;

    // set other buttons

    for (int i = 0; i < houseCommittees.length; i++) {
      String n = Utils.returnCommas(houseCommittees[i].name);
      buttons[i+4] = new Button(width/6+10, height/6+houseButtonSize*(i+1), textWidth(n), houseButtonSize, color(0, 0, 0), 7);
      buttons[i+4].setLabel(n, (int)houseButtonSize/2, color(0, 0, 0));
      buttons[i+4].extra = i+3;
      buttons[i+4].variance = 1;
    }

    for (int i = 0; i < senateCommittees.length; i++) {
      String n = Utils.returnCommas(senateCommittees[i].name);
      buttons[i+4+houseCommittees.length] = new Button(width*5/6-textWidth(n)-10, height/6+senateButtonSize*(i+1), textWidth(senateCommittees[i].name), senateButtonSize, color(0, 0, 0), 7);
      buttons[i+4+houseCommittees.length].setLabel(n, (int)senateButtonSize/2, color(0, 0, 0));
      buttons[i+4+houseCommittees.length].extra = i+3+houseCommittees.length;
      buttons[i+4+houseCommittees.length].variance = 1;

    }

    extraActions();

    if (extra < 100) {
      for (int i = 1; i < buttons.length; i++) {
        buttons[i].visible = false;
      }
      currCalendar.year = currCalendar.cYear;
      currCalendar.month = currCalendar.cMonth;
    }

    for (int i = 0; i < buttons.length-1; i++)
      buttons[i].scrollCol = color(200, 0, 0);
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
      currCalendar = houseCommittees[extra-3].cCalendar;
    }
    // houseCommittees.length = 2 senateCommittees.length = 3
    else if (extra < houseCommittees.length+senateCommittees.length+3) {
      currCalendar = senateCommittees[extra-3-houseCommittees.length].cCalendar;
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

    if (extra < 100) {
      currCalendar.display();
      fill(255, 0, 0);
      textAlign(CENTER, BOTTOM);
      textSize(15);
      if (extra == 0)
        text("All Events Calendar", width/2, height/6);
      else if (extra == 1)
        text("House Calendar", width/2, height/6);
      else if (extra == 2)
        text("Senate Calendar", width/2, height/6);
      else if (extra < 3+houseCommittees.length)
        text(Utils.returnCommas(houseCommittees[extra-3].name)+" Committee Calendar", width/2, height/6);
      else if (extra < 3+houseCommittees.length+senateCommittees.length)
        text(Utils.returnCommas(senateCommittees[extra-houseCommittees.length-3].name)+" Committee Calendar", width/2, height/6);
    }
    else {
      fill(255);
      rect(width/6, height/6, width*2/3, height*2/3);
    }

    displayButtonsSliders();
  }

}