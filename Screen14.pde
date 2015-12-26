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

  }
}
