class Screen3 extends Screen {
  // Congress


  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "3";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[5];
    // Senate Speech, House Speech, New Bill
    buttons[0] = new Button(width/2-340, height/2+40, 300, 80, color(255, 0, 0), 10);
    buttons[0].setLabel("House of Representatives", 14, 255);
    buttons[1] = new Button(width/2+40, height/2+40, 300, 80, color(255, 0, 0), 11);
    buttons[1].setLabel("The Senate", 14, 255);

    buttons[2] = new Button(width/2-310, height/2-120, 300, 80, color(255, 0, 0), 12);
    buttons[2].setLabel("Introduce House Bill", 14, 255);
    buttons[2].extra = 0;
    buttons[3] = new Button(width/2+10, height/2-120, 300, 80, color(255, 0, 0), 12);
    buttons[3].setLabel("Introduce Senate Bill", 14, 255);
    buttons[3].extra = 1;
    
    buttons[4] = new Button(width/2-150, height/2+140, 300, 80, color(255, 0, 0), 13);
    buttons[4].setLabel("Talk to Legislators", 14, 255);
    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();

    textAlign(CENTER, CENTER);
    textSize(16);
    text("Or Make A Speech To...", width/2, height/2);
    for (int i = 0; i < buttons.length; i++)
      buttons[i].display();


  }

}
