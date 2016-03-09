class Screen31 extends Screen {
  // Advise GA Delegate

/* How to code this:
    This screen affects the General Assembly Delegate's automatic decisions on:
      * Speeches
      * Voting
      * Trading (if that's checked)

    The Delegate class exists and extends Politician, so look that up.
    Do basic stuff in that class that has to do with the things here.

    You need to write a RadioButton class or a RadioButtonList class that somehow deals with radio buttons.
    Radio Buttons are those check things where only one is checked. Maybe that's why list is better?

    It shouldn't extend Button because that sounds completely different (unless you decide it's not)
    but you can look to that class, or the similar Slider class to get a sense of how to write
    visual clickable object classes.

    You also need Check Boxes to be a thing, where there's only one that could be checked or unchecked.
    Maybe have Radio Buttons be able to have neither button checked so that just one can become a Check Box.

    Radio Buttons can be stored as a RadioButton[] set in setScreen().


    Key for making Screens:
      The game follows an appearance where if there's a text box it is in the center of the screen.
      It's a rect(width/6, height/6, width*2/3, height*2/3). This should probably basically be the used
      part of the screen. Sometimes you're not making just one of these, but have things fit in this area.
      Buttons can be out of this, this is just for text.


    How Buttons work:
      When a button is clicked on it goes to a specified Screen number. It can go to the same screen.
      This is sometimes helpful. See Screen10 or Screen11 or Screen18.


    How clicking works:
      Radio Buttons can be attached to an x and y coord and have a boolean method that returns if it's clicked on.
      Then you can make a for loop that checks all buttons.

      Clicking in general is done in MouseClicked. Each screen has a MouseClicked[Screen #](int x, int y) as you can see.
      Put the one for each screen that needs clicking in the right chronological place
      with those (do a search to find them).

      If you have a list of things that gets clicked on you can look at MouseClicked10and11 as a good example.
      It's really badly commented code though, so good luck... tell me if you need help.

      Buttons and sliders don't need this! Neither should RadioButtons! They automatically do their thing.
      Search for mouseClickedButton() and put mouseClickedRadio(int x, int y) below it.

      If any change occurs once you've clicked something, call displayAll() which will reset the screen.
      Thankfully now changes don't occur unless you do that. It was disastrously slow.

      Look at classes and stuff if you don't understand something.


    How Screens work:
      setScreen() initially creates the Screen object. Here you put creation of buttons (see Screen0)
      or creation of Sliders, basically the same thing. (also creation of Radio Buttons)

      ExtraActions() is the typical method for extra actions having to do with extra or chosen.

      Display() displays the Screen. Put shapes and text there.

      extra is any int that pertains to the screen. Buttons have an extra that automatically sets when pressed.

      chosen is a chosen int probably clicked on

      see anything else in Screen.


      */


  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "31";
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