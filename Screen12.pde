class Screen12 extends Screen {
  // New Bill Step 1

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "12";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    Table t = new Table();
    if (extra == 0) {
      t = loadTable("housecommittees.csv", "header");
    }
    else {
      t = loadTable("senatecommittees.csv", "header");
    }
    buttons = new Button[t.getRowCount()+1];
    int y = height/6+50;
    int x = 0;
    for (int i = 0; i < buttons.length-1; i++) {
      if ((i+1)%3 != 0 && i == t.getRowCount()-1)
        x++;
      buttons[i] = new Button(width/6+(width*2/3)*x++/3, y, width*2/9, height*2/(t.getRowCount()+6), color(255, 0, 0), 18);
      buttons[i].setLabel(Utils.returnCommas(t.getRow(i).getString(0)), 14, 255);
      buttons[i].extra = i;
      if (x == 3) {
        x = 0;
        y += height*2/(t.getRowCount()+6);
      }
    }
    chosen = 0;
    buttons[buttons.length-1] = new Button(width/2-100, height*5/6, 200, height/12, color(0, 0, 255), 15);
    buttons[buttons.length-1].setLabel("Submit a Budget Proposal", 14, 255);

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
    buttons[buttons.length-1].scrollCol = color(0, 0, 200);

    extraActions();
  }

  // Does the extra actions
  // Precondition: extra is an int from the last Screen
  // Postcondition: actions are taken according to the int extra
  void extraActions() {
    tempBill = new Bill();
    tempBill.originChamber = extra;
    tempBill.presBacked = true;
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    textSize(30);
    textAlign(CENTER, CENTER);
    text("Find a department for most of the bill", width/2, height/6+25);

  }

}
