class Screen14 extends Screen {
  // Control Funding

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
    buttons[0] = new Button(width/2-320, height*5/6+20, 300, height/6-40, color(255, 0, 0), 0);
    buttons[0].setLabel("Cancel", 14, 255);
    buttons[1] = new Button(width/2-320, height*5/6+20, 300, height/6-40, color(255, 0, 0), 0);
    buttons[1].setLabel("Update", 14, 255);
    buttons[1].extra = 4;

    input = "";
    search = new ArrayList<Congressman>();
    chosen = -1;

    sliders = new Slider[1];
    textSize(16);
    sliders[0] = new Slider(width/2+textWidth("Funds reserved for your Presidential Campaign for this year: 0 ")/2, 64, you.funds, 200);
    sliders[0].units = "Million";
  }

    // Displays the screen
    // Precondition: setScreen has been called for this screen, this is the current Screen
    // Postcondition: this screen is displayed
  void display() {
    super.display();

    you.display();

    textAlign(LEFT, TOP);
    float w = textWidth("Search by state, name, party, or position:")+5;
    fill(0);
    text("Search by state, name, party, or position:", width/6, 65);
    fill(255);
    rect(width/6+w, 62, width*2/3-w, 26);
    fill(0);
    text(input, width/6+w, 65);

    if ((millis()/1000)%2 == 0)
      line(width/6+w+textWidth(input)+1, 65, width/6+w+textWidth(input)+1, 65+20);
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
        if (i == chosen) {
          fill(0, 0, 100);
          rect(width/6, height/6+24*i+scrollX, width*4/6, 24);
          fill(0);
        }
        text("Sen. "+search.get(i).name+"  ("+search.get(i).party+", "+search.get(i).state+")", width/6+5, height/6+24*i+scrollX);
      }
      if (height/6+24*(i+1)+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6)
        line(width/6, height/6+24*(i+1)+scrollX, width*5/6, height/6+24*(i+1)+scrollX);
    }
    float listLength = max(1, 24*search.size());// listlength is size of the list in pixels. List.size() is # of items
    float space = height*2/3;// Space that the text area takes up.
    displayScrollBar(listLength, space);
  }
}
