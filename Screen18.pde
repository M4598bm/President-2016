class Screen18 extends Screen {
  // New Bill Step 2

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "18";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[2];
    buttons[0] = new Button(width/6, height-80, 300, 60, color(255, 0, 0), 19);
    buttons[0].setLabel("Find a Rider for Bill", 14, 255);
    buttons[1] = new Button(width/6, height-140, 150, 60, color(255, 0, 0), 18);
    buttons[1].setLabel("", 14, 255);
    buttons[1].extra = extra;
    buttons[1].clickable = false;
    scrollX = 0;

    sliders = new Slider[2];

    sliders[0] = new Slider(width*5/6-(210+textWidth("100 %")), height-191, 100, 200);
    sliders[1] = new Slider(width*5/6-(210+textWidth("100 %")), height-157, 100, 200);

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
    for (int i = 0; i < sliders.length; i++)
      sliders[i].units = "%";

    depIdeas = ideas.departmentNames(extra);

    extraActions();
  }

  // Does the extra actions
  // Precondition: extra is an int from the last Screen
  // Postcondition: actions are taken according to the int extra
  void extraActions() {
    if (lastchosen == 0) {
      tempBill.committee = extra;
    }
    else if (lastchosen < 3) {
      tempBill.removeIdea(tempBill.ideas[lastchosen-1]);
      screens.remove(screens.size()-2);
    }
    else {
      tempBill.addIdea(ideas.nameToInd(depIdeas.get(lastchosen-3)));
      screens.remove(screens.size()-2);
    }
    for (int i = 0; i < sliders.length; i++) {
      sliders[i].value = tempBill.percentages[i];
      if (tempBill != null && tempBill.ideas[i] == -1)
        sliders[i].visible = false;
    }
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    tempBill.percentages[0] = sliders[0].value;
    tempBill.percentages[1] = sliders[1].value;
    textSize(26);
    textAlign(CENTER, CENTER);
    fill(0);
    text("Create a bill with two department policies:", width/2, (height-30)*1/12+30);
    // Create the ideas box
    fill(255);
    rect(width/6, height/6, width*2/3, height-215-height/6);
    fill(0);
    textAlign(LEFT, TOP);
    textSize(20);
    for (int i = 0; i < depIdeas.size(); i++) {
      if (height/6+24*i+scrollX >= height/6) {// 0 is none, 1-2 is already there, so 3 is 1
        if (i == chosen-3) {
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
    rect(width/6, height-208, width*2/3, 68);
    line(width/6, height-174, width*5/6, height-174);
    textAlign(LEFT, CENTER);

    fill(hLColor);
    if (chosen == 1)
      rect(width/6, height-208, width*4/6, 34);
    if (chosen == 2)
      rect(width/6, height-174, width*4/6, 34);

    fill(0);
    if (tempBill.ideas[0] != -1)
      text(ideas.names[tempBill.ideas[0]], width/6, height-191);
    if (tempBill.ideas[1] != -1)
      text(ideas.names[tempBill.ideas[1]], width/6, height-157);

    displayButtonsSliders();
  }
}
