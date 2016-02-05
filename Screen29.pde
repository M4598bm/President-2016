class Screen29 extends Screen {
  // New Executive Order

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "29";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[3+cabinet.length];
    buttons[0] = new Button(width/2-220, height-80, 200, 60, color(255, 0, 0), 0);
    buttons[0].setLabel("Sign Executive Order", 14, 255);
    buttons[0].extra = 29;
    buttons[1] = new Button(width/2+20, height-80, 200, 60, color(255, 0, 0), 0);
    buttons[1].setLabel("Float to the Media", 14, 255);
    buttons[2] = new Button(width/6, height-106, 150, 60, color(255, 0, 0), 29);
    buttons[2].setLabel("", 14, 255);
    buttons[2].extra = extra;
    buttons[2].clickable = false;
    textSize(14);

    for (int i = 3; i < buttons.length; i++) {
      buttons[i] = new Button(width+10-textWidth("Sec. of Housing and Urban Dev.   "), height/6+(i-3)*30, textWidth(cabinet[i-3].title), 30, color(0, 0, 0), 29);
      buttons[i].setLabel(cabinet[i-3].title, 14, color(200, 0, 0));
      buttons[i].extra = i-3;
      buttons[i].variance = 1;
    }

    scrollX = 0;

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);

    sliders = new Slider[3];

    sliders[0] = new Slider(width*5/6-(210+textWidth("100")), height-191, 100, 200);
    sliders[1] = new Slider(width*5/6-(210+textWidth("100")), height-157, 100, 200);
    sliders[2] = new Slider(width*5/6-(210+textWidth("100")), height-123, 100, 200);

    depIdeas = ideas.departmentNames(extra);

    extraActions();
  }

  // Does the extra actions
  // Precondition: extra is an int from the last Screen
  // Postcondition: actions are taken according to the int extra
  void extraActions() {
    if (lastButtonInd == 2) {
      if (lastchosen == 0) {}
      else if (lastchosen < 3) {
        tempOrder.removeIdea(tempOrder.ideas[lastchosen-1]);
        screens.remove(screens.size()-2);
      }
      else {
        tempOrder.addIdea(ideas.nameToInd(depIdeas.get(lastchosen-4)));
        screens.remove(screens.size()-2);
      }
    }
    // No repetition in the screens
    if (screens.get(screens.size()-2).toString() == "29") {
      screens.remove(screens.size()-2);
    }

    chosen = 0;

    for (int i = 0; i < sliders.length; i++) {
      sliders[i].value = tempOrder.percentages[i];
      sliders[i].units = "%";
      if (tempOrder != null && tempOrder.ideas[i] == -1)
        sliders[i].visible = false;
    }
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    tempOrder.percentages[0] = sliders[0].value;
    tempOrder.percentages[1] = sliders[1].value;
    tempOrder.percentages[2] = sliders[2].value;
    textSize(26);
    textAlign(CENTER, CENTER);
    fill(0);
    text(cabinet[extra].dep, width/2, (height-30)*1/12+30);
    // Create the ideas box
    fill(255);
    rect(width/6, height/6, width*2/3, height-215-height/6);
    fill(0);
    textAlign(LEFT, TOP);
    textSize(20);
    for (int i = 0; i < depIdeas.size(); i++) {
      if (height/6+24*i+scrollX >= height/6) {// 0 is none, 1-3 is already there, so 4 is 1
        if (i == chosen-4) {
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
    rect(width/6, height-208, width*2/3, 102);
    line(width/6, height-174, width*5/6, height-174);
    line(width/6, height-140, width*5/6, height-140);

    fill(hLColor);
    if (chosen == 1)
      rect(width/6, height-208, width*4/6, 34);
    if (chosen == 2)
      rect(width/6, height-174, width*4/6, 34);
    if (chosen == 3)
      rect(width/6, height-140, width*4/6, 34);

    textAlign(LEFT, CENTER);
    fill(0);
    if (tempOrder.ideas[0] != -1)
      text(ideas.names[tempOrder.ideas[0]], width/6, height-191);
    if (tempOrder.ideas[1] != -1)
      text(ideas.names[tempOrder.ideas[1]], width/6, height-157);
    if (tempOrder.ideas[2] != -1)
      text(ideas.names[tempOrder.ideas[2]], width/6, height-123);

    fill(0);

    displayButtonsSliders();
  }

}
