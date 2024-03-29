class Screen16 extends Screen {
  // Find Representative for the bill

  Congressman[] sponsors;
  
  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "16";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[1];
    buttons[0] = new Button(width/2-100, height*5/6+20, 200, 60, color(255, 0, 0), 21);
    buttons[0].setLabel("Propose Bill", 14, 255);

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);

    chosen = 0;
  }

    // Displays the screen
    // Precondition: setScreen has been called for this screen, this is the current Screen
    // Postcondition: this screen is displayed
  void display() {
    super.display();

    fill(255);
    rect(width/6, height/6, width*2/3, height*4/6);//Congressmen
    fill(0);
    textAlign(LEFT, TOP);
    search = Utils.searchThrough(input, house, senate);

    if (tempBill.originChamber == 0) {
      if (input.equals("")) {
        sponsors = houseCommittees[tempBill.committee].members;
      }
      else {
        sponsors = new Congressman[search.size()];
        for (int i = 0; i < search.size(); i++)
          sponsors[i] = search.get(i);
      }
    }
    else {
      sponsors = senate;
      if (input.equals("")) {
        sponsors = senateCommittees[tempBill.committee].members;
      }
      else {
        sponsors = new Congressman[search.size()];
        for (int i = 0; i < search.size(); i++)
          sponsors[i] = search.get(i);
      }
    }

    text("Search by state, name, party, or position:", width/6, 65);
    displayTextInputs();

    int x = 0;
    for (int i = 0; i < sponsors.length; i++) {
      if (height/6+24*x+scrollX >= height/6 && height/6+24*(x+1)+scrollX <= height*5/6) {
        if (x == chosen) {
          fill(hLColor);
          rect(width/6, height/6+24*x+scrollX, width*4/6, 24);
          fill(0);
        }
        text(sponsors[i].name+"  ("+sponsors[i].state+", "+sponsors[i].party+")", width/6+5, height/6+24*x+scrollX);
      }
      if (height/6+24*(x+1)+scrollX >= height/6 && height/6+24*(x+1)+scrollX <= height*5/6)
        line(width/6, height/6+24*(x+1)+scrollX, width*5/6, height/6+24*(x+1)+scrollX);
      x++;
    }

    fill(50, 125, 250);
    int listLength = 24*house.length;
    int space = height*2/3+25;// This was a good attempt but needs to be made better
    rect(width*5/6, height/6-scrollX*space/listLength, 10, 50, 5);


  }

}
