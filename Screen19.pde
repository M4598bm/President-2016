class Screen19 extends Screen {
  // New Bill Step 3

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "19";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    Table t = new Table();
    if (tempBill.originChamber == 0) {
      t = loadTable("housecommittees.csv", "header");
    }
    else {
      t = loadTable("senatecommittees.csv", "header");
    }
    buttons = new Button[t.getRowCount()];
    int y = height/6+50;
    int x = 0;
    for (int i = 0; i < buttons.length; i++) {
      if ((i+1)%3 != 0 && i == t.getRowCount()-1)
        x++;
      buttons[i] = new Button(width/6+(width*2/3)*x++/3, y, width*2/9, height*2/(t.getRowCount()+6), color(255, 0, 0), 20);
      buttons[i].setLabel(Utils.returnCommas(t.getRow(i).getString(0)), 14, 255);
      buttons[i].extra = i;
      if (x == 3) {
        x = 0;
        y += height*2/(t.getRowCount()+6);
      }
    }
    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);

    chosen = 0;
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    textSize(30);
    textAlign(CENTER, CENTER);
    text("Find a Department for the Rider", width/2, height/6+25);
    for (int i = 0; i < buttons.length; i++)
      buttons[i].display();

  }

}
