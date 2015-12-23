class Screen20 extends Screen {
  // New Bill Step 20

  String toString() {
    return "20";
  }

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

    depIdeas = ideas.departmentNames(extra);
    if (chosen == 0) {
    }
    else if (chosen == 1) {
      tempBill.removeIdea(tempBill.ideas[2]);
      chosen = 0;
      screens.remove(screens.size()-2);
    }
    else {
      tempBill.addIdea(ideas.nameToInd(depIdeas.get(chosen-2)));
      chosen = 0;
      screens.remove(screens.size()-2);
    }

    sliders = new Slider[1];

    sliders[0] = new Slider(width*5/6-(210+textWidth("100")), height-157, 100, 200);
    sliders[0].value = tempBill.percentages[2];
    if (tempBill != null && tempBill.ideas[2] == -1)
      sliders[0].visible = false;
  }

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
          fill(0, 0, 100);
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
    fill(0);
    if (chosen == 1) {
      fill(0, 0, 100);
      rect(width/6, height-174, width*2/3, 34);
      fill(0);
    }
    if (tempBill.ideas[2] != -1)
      text(ideas.names[tempBill.ideas[2]], width/6, height-157);

    displayButtonsSliders();
  }

}
