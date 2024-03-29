class Screen21 extends Screen {
  // Finish bill

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "21";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[2];
    buttons[0] = new Button(width/2-210, height*5/6+20, 200, 60, color(255, 0, 0), 0);
    buttons[0].setLabel("Cancel", 14, 255);
    buttons[1] = new Button(width/2+10, height*5/6+20, 200, 60, color(255, 0, 0), 0);
    buttons[1].setLabel("Propose Bill", 14, 255);
    buttons[1].extra = 3;

    // Edit this, it is wrong
    int x = 0;
    for (int i = 0; i < house.length; i++) {
      //if (house[i].committee == tempBill.committee) {
        if (x == lastchosen)
          tempBill.sponsor = house[i];
        x++;
      //}
    }

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    textAlign(LEFT, TOP);
    textSize(40);

    displayTextInputs();

    fill(255, 0, 0);
    text("Name:", width/6, height/6);
    fill(0);
    if (tempBill != null) {
      fill(0);
      textSize(30);
      text("Sponsor: "+tempBill.sponsor.name+"("+(tempBill.sponsor.party+"").toUpperCase()+")", width/6, height/6+40);
      textSize(25);
      text("Main clauses of this bill:", width/6, height/6+90);
      if (tempBill.ideas[0] != -1)
        text("1. "+ideas.names[tempBill.ideas[0]]+" ("+tempBill.percentages[0]+"%)", width/6, height/6+130);
      if (tempBill.ideas[1] != -1)
        text("2. "+ideas.names[tempBill.ideas[1]]+" ("+tempBill.percentages[1]+"%)", width/6, height/6+160);
      if (tempBill.ideas[2] != -1)
        text("3. "+ideas.names[tempBill.ideas[2]]+" ("+tempBill.percentages[2]+"%)", width/6, height/6+190);
    }



  }

}