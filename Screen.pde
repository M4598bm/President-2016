class Screen {
  /* Index of Screens shown:
   0: Main
   1: Stats < 0
   2: Cabinet < 0
   3: Congress < 0
   4: International < 0
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
   16: Find Rep for Bill < 20
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
  */

  // Most used variables for basic structure

  int extra;// any extra input that a lot of buttons have
  Button[] buttons;// All the buttons displayed on the screen
  Slider[] sliders;// All the sliders displayed on the screen
  int scrollX;// The xval of what was scrolled
  int[] scrollsX;// The scrollX for when there are many areas that are scrollable
  int chosen;// a selected value, usually out of a list

  ArrayList<Integer> d1;// holds int data (used in speeches as for)
  ArrayList<Integer> d2;// holds more int data (used in speeches as against)
  ArrayList<Congressman> search;// the result of a search through congresses
  ArrayList<String> depIdeas;// names of ideas
  String input;// a string input
  Interaction trade;// facilitates any kind of trading screen

  Screen() {
    /* The constructor for string, mostly initializes values
    */
    d1 = new ArrayList<Integer>();
    d2 = new ArrayList<Integer>();
    search = new ArrayList<Congressman>();
    buttons = new Button[0];
    sliders = new Slider[0];
  }

  String toString() {
    return "-1";
  }

  void setScreen() {

  }




  void display() {
    background(50, 125, 250);
    fill(0);
    displayButtonsSliders();
  }

  void displayButtonsSliders() {
    for (int i = 0; i < buttons.length; i++)
      buttons[i].display();
    for (int i = 0; i < sliders.length; i++)
      sliders[i].display();
  }
}
