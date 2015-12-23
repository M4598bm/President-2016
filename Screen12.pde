class Screen12 extends Screen {
  // New Bill Step 1

  String toString() {
    return "12";
  }

  void setScreen() {
    Table t = loadTable("majordepartments.csv", "header");
    buttons = new Button[16];
    int y = height/6+50;
    int x = 0;
    for (int i = 0; i < 15; i++) {
      buttons[i] = new Button(width/6+(width*2/3)*x++/3, y, width*2/9, 50, color(255, 0, 0), 18);
      buttons[i].setLabel(t.getRow(i).getString(0), 14, 255);
      buttons[i].extra = i;
      if (x == 3) {
        x = 0;
        y += 50;
      }
    }
    chosen = 0;
    buttons[15] = new Button(width/2-150, height/6+50*7, 300, 80, color(0, 0, 255), 15);
    buttons[15].setLabel("Submit a Budget Proposal", 14, 255);


    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
    buttons[15].scrollCol = color(0, 0, 200);
  }

  void display() {
    super.display();

    textSize(30);
    textAlign(CENTER, CENTER);
    text("Find a department for most of the bill", width/2, height/6+25);

  }

}
