class Screen22 extends Screen {
  // Show agenda

  String toString() {
    return "22";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[0];
    /* Examples of news include:
     * Important events that happened and how you're going to treat them
     * Bills that went on floor this week
     * Bills that were denied this week
     * Nations that request a visit
     * When the next thing is due
     * How your next election is going
     * How the next congressional election is going
     * Important Supreme Court cases coming up and recent decisions
     * Bills that you can sign or table
     */
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();



  }

}
