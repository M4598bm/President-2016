class Screen13 extends Screen {
  // Talk to Legislators


  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "13";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[1];
    buttons[0] = new Button(width/2-150, height*5/6+10, 300, height/6-40, color(255, 0, 0), 23);
    buttons[0].setLabel("Create Deal", 14, 255);
    input = "";
    search = new ArrayList<Congressman>();
    chosen = -1;
    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
      /*  Things in this screen:
          * search bar for state, name, party that updates always
          * list of people that fit this ^
          * button on the bottom to automatically 'make deal' with each (link to next screen)
      */
  }





    // Displays the screen
    // Precondition: setScreen has been called for this screen, this is the current Screen
    // Postcondition: this screen is displayed
  void display() {
    super.display();


    // search bar for state, name, party, position
    textAlign(CENTER, TOP);
    textSize(20);
    text("Make private deals with groups or individuals in Congress", width/2, 35);
    textAlign(LEFT, TOP);
    float w = textWidth("Search by state, name, party, or position:")+5;

    // text input box
    fill(0);
    text("Search by state, name, party, or position:", width/6, 65);
    displayTextInputs();

    fill(255);
    rect(width/6, height/6, width*2/3, height*2/3);//Congressmen
    fill(0);
    textAlign(CENTER, TOP);
    textSize(20);
    text("Congressmen:", width/2, height/6-30);
    /* Needs to show:
       - state/party
       - you approval
       - approval
    */

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