class Screen0 extends Screen {

  // Main Screen of the game //

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "0";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[10];
    buttons[0] = new Button(width/2-320, height/2-110, 200, 60, color(255, 0, 0), 2);
    buttons[0].setLabel("Cabinet", 14, 255);
    buttons[1] = new Button(width/2-100, height/2-110, 200, 60, color(255, 0, 0), 3);
    buttons[1].setLabel("Congress", 14, 255);
    buttons[2] = new Button(width/2+120, height/2-110, 200, 60, color(255, 0, 0), 4);
    buttons[2].setLabel("Executive Orders", 14, 255);
    buttons[3] = new Button(width/2-320, height/2-30, 200, 60, color(255, 0, 0), 5);
    buttons[3].setLabel(presParty+" National Committee", 12, 255);
    buttons[4] = new Button(width/2-100, height/2-30, 200, 60, color(255, 0, 0), 6);
    buttons[4].setLabel("United Nations Ambassador", 14, 255);
    buttons[5] = new Button(width/2+120, height/2-30, 200, 60, color(255, 0, 0), 7);
    buttons[5].setLabel("Calendar", 14, 255);
    buttons[6] = new Button(width/2-320, height/2+50, 200, 60, color(255, 0, 0), 1);
    buttons[6].setLabel("Statistics", 14, 255);
    buttons[7] = new Button(width/2-100, height/2+50, 200, 60, color(255, 0, 0), 8);
    buttons[7].setLabel("War Room", 14, 255);
    buttons[8] = new Button(width/2+120, height/2+50, 200, 60, color(255, 0, 0), 9);
    buttons[8].setLabel("Intellegence", 14, 255);
    for (int i = 0; i < buttons.length-1; i++)
      buttons[i].scrollCol = color(200, 0, 0);
    buttons[9] = new Button(width/2-100, height/2+130, 200, 60, color(0, 0, 255), 0);
    buttons[9].setLabel("Next Turn", 14, 255);
    buttons[9].scrollCol = color(0, 0, 200);
    buttons[9].extra = 1;

    extraActions();
  }
  // Does the extra actions
  // Precondition: extra is an int from the last Screen
  // Postcondition: actions are taken according to the int extra
  void extraActions() {
    if (extra == 1) {// new turn
      nextTurn();
    }
    else if (extra == 2) {// federal budget
      for (int i = 0; i < sliders.length; i++)
        fedBudget.proposedFunding[i] = sliders[i].value;
      fedBudget.updatePropExpense();
    }
    else if (extra == 3) {// new bill
      bills.add(tempBill);
      tempBill.addOpinions();
      tempBill = null;
    }
    else if (extra == 4) {// party budget

    }

    else if (extra == 10) {// speechwriting house
      suppH = d1;
      agH = d2;
    }
    else if (extra == 11) {// speechwriting senate
      suppS = d1;
      agS = d2;
    }

    else if (extra == 29) {// new executive order
      executiveOrders.add(tempOrder);
      tempOrder = new ExecutiveOrder();
      tempOrder.president = "you";
    }
    // ============================
    // ============================

    extra = 0;
    chosen = 0;
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();
    if (extra == 3) {
       textSize(30);
       textAlign(CENTER, TOP);
       text("Your Bill was successfully submitted to the House of Representatives", width/2, height/6);
    }

  }

}
