class Screen14 extends Screen {
  // Control Funding

  Congressman cperson;

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "14";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[2];
    if (extra == 1)
      buttons = new Button[3];

    buttons[0] = new Button(width/2-220, height*5/6+40, 200, height/6-50, color(255, 0, 0), 0);
    buttons[0].setLabel("Cancel", 14, 255);
    buttons[1] = new Button(width/2+20, height*5/6+40, 200, height/6-50, color(255, 0, 0), 0);
    buttons[1].setLabel("Update", 14, 255);
    buttons[1].extra = 4;

    search = Utils.searchThrough(input, house, senate);

    sliders = new Slider[1];
    if (extra == 1)
      sliders = new Slider[2];
    textSize(20);
    float wordsWidth = textWidth("Funds reserved for your Presidential Campaign for this year: ");
    sliders[0] = new Slider(width/6+wordsWidth, height*5/6+10, you.funds, width*5/6-(width/6+wordsWidth));
    sliders[0].units = "Million";

    extraActions();

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
  }

  // Does the extra actions
  // Precondition: extra is an int from the last Screen, chosen also
  // Postcondition: actions are taken according to the ints extra and chosen
  void extraActions() {
    if (extra == 1) {
      cperson = search.get(chosen);

      buttons[2] = new Button(width*2/3-100, height*2/3, 100, 40, color(255, 0, 0), 14);
      buttons[2].setLabel("Close", 14, 255);
      buttons[2].extra = 0;

      sliders[1] = new Slider(width/3+textWidth("Funding: "), height/3+30, cperson.ncFunds, width/6);
      sliders[1].units = "Thousand";
    }
  }
    // Displays the screen
    // Precondition: setScreen has been called for this screen, this is the current Screen
    // Postcondition: this screen is displayed
  void display() {
    super.display();

    you.display();

    textAlign(LEFT, TOP);

    textSize(16);
    text("Funds available for this year: ", width/6, 40);

    fill(255);
    rect(width/6, height/6, width*2/3, height*2/3);//Congressmen
    fill(0);
    textAlign(CENTER, TOP);
    textSize(20);
    text("Congressmen:", width/2, height/6-30);

    search = Utils.searchThrough(input, house, senate);
    textAlign(LEFT, TOP);
    for (int i = 0; i < search.size(); i++) {
      if (height/6+24*i+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6) {
        text("Sen. "+search.get(i).name+"  ("+search.get(i).party+", "+search.get(i).state+")", width/6+5, height/6+24*i+scrollX);
      }
      if (height/6+24*(i+1)+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6)
        line(width/6, height/6+24*(i+1)+scrollX, width*5/6, height/6+24*(i+1)+scrollX);
    }
    float listLength = max(1, 24*search.size());// listlength is size of the list in pixels. List.size() is # of items
    float space = height*2/3;// Space that the text area takes up.
    displayScrollBar(listLength, space);

    fill(0);
    text("Funds reserved for your Presidential Campaign for this year: ", width/6, height*5/6);

    popUpWindow();
    displayButtonsSliders();

    // displays a text input
    fill(0);
    textSize(16);
    textAlign(LEFT, TOP);
    text("Search by state, name, party, or position:", width/6, 65);
    displayTextInputs();
  }

  // Displays a popup with settings for the selected congressperson's funding
  // Precondition: chosen is the int from the search that was selected for the popup
  // Postcondition: A popup window is displayed over the Screen
  void popUpWindow() {
    if (extra == 1) {
      fill(255);
      rect(width/3, height/3, width/3, height/3);
      fill(0);
      textAlign(CENTER, TOP);
      textSize(20);
      text(cperson.name+"("+cperson.party+","+cperson.state+")", width/2, height/3);
      textAlign(LEFT, TOP);
      text("Funding: ", width/3, height/3+30);
    }
  }
}
