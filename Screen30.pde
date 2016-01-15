class Screen30 extends Screen {
  // See Bills Status

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "30";
  }


  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[5];
    if (chosen != -1)
      buttons = new Button[6];
    buttons[0] = new Button(width/6+width*0/15, 40, width*2/15, height/6-50, color(255, 0, 0), 30);
    buttons[0].setLabel("Committee", 14, 255);
    buttons[0].extra = 0;// 0, 1
    buttons[1] = new Button(width/6+width*2/15, 40, width*2/15, height/6-50, color(255, 0, 0), 30);
    buttons[1].setLabel("House Floor", 14, 255);
    buttons[1].extra = 1;// 2, 4
    buttons[2] = new Button(width/6+width*4/15, 40, width*2/15, height/6-50, color(255, 0, 0), 30);
    buttons[2].setLabel("Senate Floor", 14, 255);
    buttons[2].extra = 2;// 3, 5
    buttons[3] = new Button(width/6+width*6/15, 40, width*2/15, height/6-50, color(255, 0, 0), 30);
    buttons[3].setLabel("Conference Committee", 14, 255);
    buttons[3].extra = 3;// 6
    buttons[4] = new Button(width/6+width*8/15, 40, width*2/15, height/6-50, color(255, 0, 0), 30);
    buttons[4].setLabel("On Your Desk", 14, 255);
    buttons[4].extra = 4;// 7

    extraActions();

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
  }

  // Does the extra actions
  // Precondition: extra is an int from the last Screen, chosen also
  // Postcondition: actions are taken according to the ints extra and chosen
  void extraActions() {
    if (chosen != -1) {
      buttons[5] = new Button(width*2/3-100, height*2/3, 100, 40, color(255, 0, 0), 30);
      buttons[5].setLabel("Close", 14, 255);
      buttons[5].extra = extra;
    }
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    fill(255);
    rect(width/6, height/6, width*2/3, height*2/3);// all bills
    textAlign(LEFT, TOP);
    fill(0);
    int x = 0;
    for (int i = 0; i < bills.size(); i++) {
      if (
        (extra == 0 && (bills.get(i).status < 2)) ||
        (extra == 1 && (bills.get(i).status == 2 || bills.get(i).status == 4)) ||
        (extra == 2 && (bills.get(i).status == 3 || bills.get(i).status == 5)) ||
        (extra == 3 && (bills.get(i).status == 6)) ||
        (extra == 4 && (bills.get(i).status == 7))
      ) {
        if (height/6+24*x+scrollX >= height/6 && height/6+24*(x+1)+scrollX <= height*5/6) {
          if (i == chosen) {
            fill(hLColor);
            rect(width/6, height/6+24*x+scrollX, width*4/6, 24);
            fill(0);
          }
          text(bills.get(i).name, width/6+5, height/6+24*x+scrollX);
        }
        if (height/6+24*(x+1)+scrollX >= height/6 && height/6+24*(x+1)+scrollX <= height*5/6)
          line(width/6, height/6+24*(x+1)+scrollX, width*5/6, height/6+24*(x+1)+scrollX);
        x++;
      }
    }

    displayScrollBar(x, height*2/3);
    popUpWindow();
    displayButtonsSliders();
  }

  // Displays a popup with settings for the selected congressperson's funding
  // Precondition: chosen is the int from the search that was selected for the popup
  // Postcondition: A popup window is displayed over the Screen
  void popUpWindow() {
    if (chosen != -1) {
      fill(255);
      rect(width/3, height/3, width/3, height/3);
      fill(0);
      textAlign(CENTER, TOP);
      textSize(20);
      text(bills.get(chosen).name, width/2, height/3);
    }
  }

}
