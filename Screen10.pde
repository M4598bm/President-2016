class Screen10 extends Screen {
  // House Speech

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "10";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[3];
    buttons[0] = new Button(width/2-150, height-100, 300, 80, color(255, 0, 0), 0);
    buttons[0].setLabel("Update Speech", 14, 255);
    buttons[0].extra = 10;

    buttons[1] = new Button(width/6, height/2+115, (width/3-40)/2, 50, color(0, 0, 255), 10);
    buttons[1].setLabel("", 14, 255);
    buttons[1].clickable = false;
    buttons[1].extra = 0;

    buttons[2] = new Button(width/2+40+(width/3-40)/2, height/2+115, (width/3-40)/2, 50, color(0, 0, 255), 10);
    buttons[2].setLabel("", 14, 255);
    buttons[2].clickable = false;
    buttons[2].extra = 1;

    extraActions();
    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(0, 0, 200);
    buttons[0].scrollCol = color(200, 0, 0);
  }

  // Does the extra actions
  // Precondition: extra is an int from the last Screen
  // Postcondition: actions are taken according to the int extra
  void extraActions() {
    if (lastchosen == -1) {
      d1 = suppH;
      d2 = agH;
      screens.add(screens.size()-1, null);
    }
    else if (lastchosen < 3) {
      d1.remove(lastchosen-1);
      lastchosen = 0;
    }
    else if (lastchosen < 5) {
      d2.remove(lastchosen-3);
      lastchosen = 0;
    }
    else if (extra == 0) {
      if (d1.size() < 2) {
        d1.add(lastchosen-5);
        lastchosen = 0;
      }
    }
    else if (extra == 1) {
      if (d2.size() < 2) {
        d2.add(lastchosen-5);
        lastchosen = 0;
      }
    }
    screens.remove(screens.size()-2);
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    textAlign(CENTER, CENTER);
    textSize(20);
    text("Bills on the House floor:", width/2, height/6-20);

    fill(255);
    rect(width/6, height/6, width*2/3, height/3);// all bills
    textAlign(LEFT, TOP);
    fill(0);
    for (int i = 0; i < bills.size(); i++) {// 0 is none, 1-2 is support, 3-4 is criticize, so 5 is the first
      if (height/6+24*i+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6) {
        if (i == chosen-5) {
          fill(hLColor);
          rect(width/6, height/6+24*i+scrollX, width*4/6, 24);
          fill(0);
        }
        text(bills.get(i).name, width/6+5, height/6+24*i+scrollX);
      }
      if (height/6+24*(i+1)+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6)
        line(width/6, height/6+24*(i+1)+scrollX, width*5/6, height/6+24*(i+1)+scrollX);
    }
    fill(255);
    textAlign(CENTER, CENTER);
    rect(width/6, height/2+65, width/3-40, 50);// to support
    rect(width/2+40, height/2+65, width/3-40, 50);// to criticize
    fill(0);
    text("Bills to Support", width/4, height/2+45);
    text("Bills to Criticize", width*3/4, height/2+45);
    line(width/6, height/2+90, width/2-40, height/2+90);
    line(width/2+40, height/2+90, width*5/6, height/2+90);
    textAlign(LEFT, TOP);
    if (d1.size() > 0) {
      if (chosen == 1) {
        fill(hLColor);
        rect(width/6, height/2+65, width/3-40, 25);
        fill(0);
      }
      text(bills.get(d1.get(0)).name, width/6, height/2+65);
    }
    if (d1.size() > 1) {
      if (chosen == 2) {
        fill(hLColor);
        rect(width/6, height/2+90, width/3-40, 25);
        fill(0);
      }
      text(bills.get(d1.get(1)).name, width/6, height/2+90);
    }
    if (d2.size() > 0) {
      if (chosen == 3) {
        fill(hLColor);
        rect(width/2+40, height/2+65, width/3-40, 25);
        fill(0);
      }
      text(bills.get(d2.get(0)).name, width/2+40, height/2+65);
    }
    if (d2.size() > 1) {
      if (chosen == 4) {
        fill(hLColor);
        rect(width/2+40, height/2+90, width/3-40, 25);
        fill(0);
      }
      text(bills.get(d2.get(1)).name, width/2+40, height/2+90);
    }

  }

}
