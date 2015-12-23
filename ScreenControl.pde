class ScreenControl {
  // Most used variables for basic structure

  int extra;// any extra input that a lot of buttons have
  Button[] buttons;// All the buttons displayed on the screen
  Slider[] sliders;// All the sliders displayed on the screen
  int scrollX;// The xval of what was scrolled
  int[] scrollsX;// The scrollX for when there are many areas that are scrollable
  int chosen;// a selected value, usually out of a list

  // Variables for specific instances
  ArrayList<String> depIdeas;// names of ideas
  ArrayList<Congressman> search;// the result of a search through congresses
  ArrayList<Integer> d1;// holds int data (used in speeches as for)
  ArrayList<Integer> d2;// holds more int data (used in speeches as against)
  String input;// a string input
  Interaction trade;// facilitates any kind of trading screen

  int time;// for a timer functionality, for example the blinking cursor




  void setScreen(int c) {
    /* One of the two major methods in this class
    It initializes the screen at the beginning, setting up Buttons and Sliders
    Each instance is defined at the beginning, so when searching through them use
    the 'if (currScreen == <x>)'
    */

  }

  int[] wordWidths(String[] words, int s) {
    textSize(s);
    int[] ls = new int[words.length];
    for (int i = 0; i < words.length; i++)
      ls[i] = (int)textWidth(words[i]);
    return ls;
  }

}