class Screen33 extends Screen {
  // Propose Resolution

/*
    Again, basically Screen18. Replace the obvious differences. tempBill is replaced by tempResolution
    which you put underneath tempBill in the President class.

    Only difference is that there is a bunch of Buttons on the top. Don't worry about those for now.

    You should've written the Resolution class so those are the things you need to set. dw about name for now.

    Not much else to tell you about here, if you need help tell me.
*/


  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "33";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[0];
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();



  }

}
