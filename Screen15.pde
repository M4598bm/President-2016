class Screen15 extends Screen {
  // Budget Policies

  String toString() {
    return "15";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[2];
    buttons[0] = new Button(width/6, height*5/6+20, width/6-20, 60, color(255, 0, 0), 0);
    buttons[0].setLabel("Cancel", 14, 255);
    buttons[1] = new Button(width/3+20, height*5/6+20, width/6-20, 60, color(255, 0, 0), 0);
    buttons[1].setLabel("Update", 14, 255);
    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
    buttons[1].extra = 2;
    sliders = new Slider[fedBudget.budget.getRowCount()];
    int y = height/6;
    int x = width/6;
    int half = (int)((height*2/3)/(fedBudget.budget.getRowCount()/2));
    for (int i = 0; i < sliders.length; i++) {// needs to give room for bottom
      if (y > height*5/6) {
        y = height/6;
        x = width/2;
      }
      int maxV = 2*Utils.convertInt(fedBudget.budget.getRow(i).getString(1));
      if (x == width/6)
        sliders[i] = new Slider(x+textWidth("Unemployment and Welfare")+5, y, maxV, width/2-textWidth("10000") - (width/6+textWidth("Unemployment and Welfare")+5));
      else
        sliders[i] = new Slider(x+textWidth("Environmental Protection Agency")+5, y, maxV, width*5/6 - (width/2+textWidth("Environmental Protection Agency")+5));
      sliders[i].value = fedBudget.proposedFunding[i];
      y += half;
    }
  }

    // Displays the screen
    // Precondition: setScreen has been called for this screen, this is the current Screen
    // Postcondition: this screen is displayed
  void display() {
    super.display();

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(25);

    if (calendar.cMonth == 1) {
      text("Federal Budget Proposal For Fiscal Year 20"+calendar.cYear, width/2, 40);
      /* the sliders will increase the spending for each, and then it overflows the total spending. Other things must
      be lowered before submitting, or the total spending can be raised
      */
      int y = height/6;
      int x = width/6;
      int i = 0;
      int half = (int)((height*2/3)/(fedBudget.budget.getRowCount()/2));
      while (i < fedBudget.budget.getRowCount()) {// needs to give room for bottom
        if (y > height*5/6) {
          y = height/6;
          x = width/2;
        }
        textAlign(LEFT, CENTER);
        textSize(half/2);
        String name = fedBudget.budget.getRow(i).getString(0);
        text(name, x, y);
        sliders[i].display();
        y += half;
        i++;
      }

      y -= half;
      textSize((height-y)/3-20);
      textAlign(LEFT, TOP);
      fedBudget.updatePropExpense();
      text("Total Proposed Expense: " + fedBudget.proposedExpense, width/2+20, y+10);
      text("Projected Income Through Tax: " + fedBudget.income, width/2+20, y+(height-y)/3);
      text("Projected Deficit: ", width/2+20, y+(height-y)*2/3-10);
    }

    else {
      text(" ", width/2, 40);
    }
    strokeWeight(0);


  }

}
