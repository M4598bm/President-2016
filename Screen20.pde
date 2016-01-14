class Screen20 extends Screen {
  // New Bill Step 20

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "20";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[2];
    buttons[0] = new Button(width/6, height-80, 300, 60, color(255, 0, 0), 16);
    buttons[0].setLabel("Find a Rep. for Bill", 14, 255);
    buttons[1] = new Button(width/6, height-140, 150, 60, color(255, 0, 0), 20);
    buttons[1].setLabel("", 14, 255);
    buttons[1].extra = extra;
    buttons[1].clickable = false;
    scrollX = 0;

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
    sliders = new Slider[1];

    sliders[0] = new Slider(width*5/6-(210+textWidth("100 %")), height-157, 100, 200);
    sliders[0].value = tempBill.percentages[2];
    sliders[0].units = "%";

    extraActions();

    if (tempBill != null && tempBill.ideas[2] == -1)
      sliders[0].visible = false;
  }

  // Does the extra actions
  // Precondition: extra is an int from the last Screen
  // Postcondition: actions are taken according to the int extra
  void extraActions() {
    depIdeas = ideas.departmentNames(extra);
    if (lastchosen == 0) {

    }
    else if (lastchosen == 1) {
      tempBill.removeIdea(tempBill.ideas[2]);
      screens.remove(screens.size()-2);
    }
    else {
      tempBill.addIdea(ideas.nameToInd(depIdeas.get(lastchosen-2)));
      screens.remove(screens.size()-2);
    }
/*
    for (int i = 0; i < sliders.length; i++) {
      sliders[i].value = tempBill.percentages[2];
      if (tempBill != null && tempBill.ideas[2] == -1)
        sliders[0].visible = false;
    }*/
  }


    // Displays the screen
    // Precondition: setScreen has been called for this screen, this is the current Screen
    // Postcondition: this screen is displayed
  void display() {
    super.display();

    tempBill.percentages[2] = sliders[0].value;
    textSize(26);
    textAlign(CENTER, CENTER);
    fill(0);
    text("Pick a rider from this department for your bill:", width/2, (height-30)*1/12+30);
    // Create the ideas box
    fill(255);
    rect(width/6, height/6, width*2/3, height-181-height/6);
    fill(0);
    textAlign(LEFT, TOP);
    textSize(20);
    for (int i = 0; i < depIdeas.size(); i++) {
      if (height/6+24*i+scrollX >= height/6) {// 0 is none, 1 is already there, so 2 is 1
        if (i == chosen-2) {
          fill(hLColor);
          rect(width/6, height/6+24*i+scrollX, width*4/6, 24);
          fill(0);
        }
        text(depIdeas.get(i), width/6+5, height/6+24*i+scrollX);
      }
      if (height/6+24*(i+1)+scrollX >= height/6)
        line(width/6, height/6+24*(i+1)+scrollX, width*5/6, height/6+24*(i+1)+scrollX);
    }
    fill(255);
    rect(width/6, height-174, width*2/3, 34);
    textAlign(LEFT, CENTER);
    if (chosen == 1) {
      fill(hLColor);
      rect(width/6, height-174, width*2/3, 34);
    }
    fill(0);
    if (tempBill.ideas[2] != -1)
      text(ideas.names[tempBill.ideas[2]], width/6, height-157);

    displayButtonsSliders();
  }

}
