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
    Table t = loadTable("majordepartments.csv", "header");
    buttons = new Button[15];
    int y = height/6+50;
    int x = 0;
    for (int i = 0; i < 15; i++) {
      buttons[i] = new Button(width/6+(width*2/3)*x++/3, y, width*2/9, 50, color(255, 0, 0), 20);
      buttons[i].setLabel(t.getRow(i).getString(0), 14, 255);
      buttons[i].extra = i;
      if (x == 3) {
        x = 0;
        y += 50;
      }
    }
    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
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
