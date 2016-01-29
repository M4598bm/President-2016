class Screen {
  /* Index of Screens shown:
   0: Main
   1: Stats < 0
   2: Cabinet < 0
   3: Congress < 0
   4: Executive orders < 0
   5: (D/R)NC < 0
   6: UN < 0
   7: Calendar < 0
   8: War < 0
   9: Intel < 0
   10: House speech < 3
   11: Senate speech < 3
   12: New bill step 1 < 3
   13: Legislators < 3
   14: Control NC Funding < 5
   15: Submit a Budget Proposal < 12
   16: Find Sponsor for Bill < 20
   17: 2020 Electoral Map < 5
   18: New bill step 2 < 12
   19: New bill step 3 < 18
   20: New bill step 4 < 19
   21: Finish bill < 16
   22: News < 0
   23: Legislative deal < 13
   24: Deal result < 23
   25: GA < 6
   26: Security Council < 6
   27: International Treaties < 6
   28: See Executive Orders < 4
   29: New Executive Order < 4
   30: Bills status < 2
   31: GA Delegate < 25
   32: UN Speech < 6
   33: Propose Resolution < 31
   34: Security Council Delegate < 26
   35: Propose Action < 34

   100: Menu Screen

   200: Main Menu Screen
   201: New game setup
   202: Load game
   203: Options
   204: Exit game
  */

  // Most used variables for basic structure

  int extra;// any extra input that a lot of buttons have
  Button[] buttons;// All the buttons displayed on the screen
  Slider[] sliders;// All the sliders displayed on the screen
  int scrollX;// The xval of what was scrolled
  int[] scrollsX;// The scrollX for when there are many areas that are scrollable
  int chosen;// a selected value, usually out of a list
  int lastchosen;// the selected value from the last screen
  ArrayList<Integer> d1;// holds int data (used in speeches as for)
  ArrayList<Integer> d2;// holds more int data (used in speeches as against)
  ArrayList<Congressman> search;// the result of a search through congresses
  ArrayList<String> depIdeas;// names of ideas
  String input;// a string input
  Interaction trade;// facilitates any kind of trading screen

  // Constructor
  // Precondition: each of the variables needs to be set
  // Postcondition: creates the Object
  Screen() {
    /* The constructor for string, mostly initializes values
    */
    d1 = new ArrayList<Integer>();
    d2 = new ArrayList<Integer>();
    input = "";
    chosen = -1;
    search = new ArrayList<Congressman>();
    buttons = new Button[0];
    sliders = new Slider[0];
  }

  String toString() {
    return "-1";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {

  }



  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    background(50, 125, 250);
    fill(0);
    displayButtonsSliders();
  }

  // Displays all buttons and sliders
  // Precondition: buttons and sliders are arrays that are either empty or filled
  // Postcondition: these two arrays are displayed
  void displayButtonsSliders() {
    for (int i = 0; i < buttons.length; i++)
      buttons[i].display();
    for (int i = 0; i < sliders.length; i++)
      sliders[i].display();
  }

  // Displays a scroll bar.
  //  The size of the bar is proportional to the size of the data compared to the space displayed
  //  At the bottom of the data, the bottom of the bar must be at the very bottom
  // Precondition: listlength is size of the list in pixels, space is the pixels of space shown at once
  // Postcondition: the bar is displayed if listlength is more than space, and it conforms to the instructions above
  void displayScrollBar(float listLength, float space) {
    fill(50, 125, 250);// needs to be the background color
    if (space < listLength) {
      float scrollLength = space/listLength;// scrolllength is I think what is broken.
      rect(width*5/6, height/6-scrollX*space/listLength, 10, scrollLength, 5);// This is the problem line.
    }
  }

  // Displays a textInput
  // Precondition:
  // Postcondition:
  void displayTextInput(float x, float y, String name, String text, float length, float textsize) {
    textAlign(LEFT, TOP);
    textSize(textsize);
    float w = textWidth(name)+5;
    fill(255);
    rect(x+w, y, length-w, textsize+6);
    fill(0);
    text(text, x+w, y+3);

    if ((millis()/500)%2 == 0)
      line(x+w+textWidth(text)+1, y+3, x+w+textWidth(text)+1, y+3+textsize);
  }




}
