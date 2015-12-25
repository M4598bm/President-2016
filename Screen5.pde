class Screen5 extends Screen {
  // D/R National Committee

  String toString() {
    return "5";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[2];
    /* Will include:
     Control Funding
     2020 Election - will disappear sometimes
     */
    buttons[0] = new Button(width/2-150, height/2-100, 300, 80, color(255, 0, 0), 14);
    buttons[0].setLabel("Control Funding", 14, 255);
    buttons[1] = new Button(width/2-150, height/2, 300, 80, color(255, 0, 0), 17);
    buttons[1].setLabel("2020 Election", 14, 255);
    if (false)// too lazy
      buttons[1].visible = false;
    for (int i = 0; i < buttons.length; i++)
      buttons[i].scrollCol = color(200, 0, 0);
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();



  }

}
