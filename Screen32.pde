class Screen32 extends Screen {
  // UN Speech

/*

    This is basically the exact same thing as Screen10, which is about Senate Speeches.

    Make a Resolution class that's basically Bill and a ArrayList<Resolution> resolutionsGA

    Make a int[] UNSpeech where [0] and [1] are resolutionsGA indeces to speak for and [2] and [3] are against

    Replace these with the d1 d2 stuff from Screen10 and put it in this screen

*/


  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "32";
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
