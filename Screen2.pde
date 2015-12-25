class Screen2 extends Screen {
  // Cabinet



  String toString() {
    return "2";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    textSize(14);
    buttons = new Button[18];
    buttons[0] = new Button(width/2-100, height-100, 200, 60, color(255, 0, 0), 0);
    buttons[0].setLabel("See Bills", 14, 255);
    buttons[1] = new Button(width-textWidth("Sec. of Housing and Urban Dev.   ")-200, height-100, 200, 60, color(255, 0, 0), 2);
    buttons[1].setLabel("Next", 14, 255);
    buttons[1].extra = extra+1;
    if (extra == cabinet.length-1)
      buttons[1].visible = false;
    buttons[2]= new Button(width/6, height-100, 200, 60, color(255, 0, 0), 2);
    buttons[2].setLabel("Back", 14, 255);
    buttons[2].extra = extra-1;
    if (extra == 0)
      buttons[2].visible = false;

    for (int i = 3; i < buttons.length; i++) {
      buttons[i] = new Button(width+10-textWidth("Sec. of Housing and Urban Dev.   "), 40+(i-3)*30, textWidth(cabinet[i-3].title), 30, color(0, 0, 0), 2);
      buttons[i].setLabel(cabinet[i-3].title, 14, color(200, 0, 0));
      buttons[i].extra = i-3;
      buttons[i].variance = 1;
    }



    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
    /* How this will work:

     See some info from all 15 in boxes, and click on some to enlarge.
     Button for the current status of your bills
     Each may tell about issues that exist with their department and ways to fix them
     Each may ask for more funding


     */
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    fill(255);
    textSize(14);
    float end = width*5/6-textWidth("Sec. of Housing and Urban Dev.   ");
    rect(width/6, 40, min(width*2/3, end), height-150);

    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text(cabinet[extra].title, width/2, 55);
    // shows: bills through this department, amount of funding, is the funding too much or little, statistics that can be fixed through this dept.
    // ========================================================== //
    // ========================================================== //
    textAlign(LEFT, TOP);
    textSize(20);
    // budget:
    text("This department's budget: $"+cabinet[extra].funding+" Billion", width/6, 70);
    line(width/6, 95, width/6+end, 95);
    //bills:
    textSize(24);
    text("Current Bills in Congress for this department:", width/6, 100);
    textSize(18);
    int y = 130;
    for (int i = 0; i < bills.size(); i++) {
      Bill bill = bills.get(i);
      if (bill.committee == extra) {
        String mes = " • Bill #"+bill.billNumber+": "+bill.name+" (";
        if (bill.status == 0)
          mes += "in committee";
        else if (bill.status == 1)
          mes += "in the House";
        else if (bill.status == 2)
          mes += "in the Senate";
        else if (bill.status == 3)
          mes += "on your desk";
        else if (bill.status == 4)
          mes += "awaiting veto override";
        mes += ")";
        text(mes, width/6, y);
        y += 20;
      }
    }

   /*  THIS IS CODE FOR A GRID WHICH WAS BAD BUT JUST IN CASE IT'S HERE

    line(width/6+width*2/9, 40, width/6+width*2/9, height-110);
    line(width/6+width*4/9, 40, width/6+width*4/9, height-110);
    for(int i = 1; i < 5; i++)
    line(width/6, 40+(height-150)*i/5, width*5/6, 40+(height-150)*i/5);
    */




  }

}
