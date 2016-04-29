class BriefingScreen extends Screen {
  // Briefing each turn

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "briefing";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    briefing.curr = extra;

    buttons = new Button[1];
    buttons[0] = new Button(width*5/6-200, height*5/6, 200, 60, color(255, 0, 0), 300);
    if (briefing.curr < MAX_CURR) {
      buttons[0].setLabel("Next", 14, 255);
      buttons[0].extra = briefing.curr+1;
    }
    else {
      buttons[0].command = 0;
      buttons[0].setLabel("Back", 14, 255);
      buttons[0].extra = briefing.curr+1;
    }

    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    fill(255);
    rect(width/6, height/6, width*2/3, height*2/3);
    textAlign(CENTER, TOP);
    textSize(30);
    fill(0);
    text(briefing.toString(), width/2, height/6);
    if (briefing.curr != 8) {// Events are different
      textAlign(LEFT, TOP);
      textSize(20);
      ArrayList<String> news = briefing.getNews();
      for (int i = 0; i < news.size(); i++) {
        text(news.get(i), width/6, height/6+(i+1)*25);
      }
    }
    else {

    }

    displayButtonsSliders();
  }

}
