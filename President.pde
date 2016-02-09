// President
// A realistic nation building game
// Created 2015-2016



// Static Variables
static int daysPerTurn = 7;// not sure what this should be yet

static color hLColor = #FFFF14;// Highlighted text box color



// Globals:

// Personalized settings
String name;// Player name (Set at start later)
char presParty;// Player party (Set at start later)
int presLib;// Player liberalism
int presSoc;// Player socialism

boolean menuOpen;// True or false if the Menu is up
int lastButtonInd;// the index of the last button pressed

ArrayList<Screen> screens;// In order of most recent, all the screens clicked on since home screen
Screen screen;// Handles most display aspects
MenuScreen menuScreen;// Displays if menuOpen
Calendar calendar;// the calendar
Calendar houseCalendar;// calendar for the house floor
Calendar senateCalendar;// calendar for the senate floor
FedBudget fedBudget;// Handles the budget
Ideas ideas;// Handles the 'ideas', Bills are made of up to 3 of ideas held in this object

NationalCom you;// Your party's national committee
NationalCom them;// Opposing party's national committee

int turn;// number of turns so far (starting from 0 at setup to 1 at first turn)
int session;// number of this congress (starts with )
int houseNumber;// number of bills presented to the floor
int senateNumber;// number of bills presented to the floor
char houseMajority;// who has a majority in the house
char senateMajority;// who has a majority in the senate

int approval;// national polling approval of you
boolean houseSpeech;// have you made a speech to the house this turn?
boolean senateSpeech;// have you made a speech to the senate this turn?

ArrayList<ExecutiveOrder> executiveOrders;// all executive orders signed
ArrayList<Bill> bills;// all bills created at the moment
ArrayList<Bill> hBills;// bills in the house
ArrayList<Bill> sBills;// bills in the senate
ArrayList<Bill> yourDesk;// bills on your desk
ArrayList<Bill> laws;// all laws passed
Congressman[] house;// array of congressmen in the house
Congressman[] senate;// array of congressmen in the senate
Committee[] houseCommittees;// array of committees in the house
Committee[] senateCommittees;// array of committees in the senate
ArrayList<Committee> conferenceComs;// conference committee that finalizes bills
Secretary[] cabinet;// array of secretaries in your cabinet
SCJustice[] scotus;// array of justices in the Supreme Court (will I need this at alL?)

// Temporary things
ExecutiveOrder tempOrder;// current ExecutiveOrder being drafted and floated
Bill tempBill;// current bill that you're having drafted (only stored here because it has to be global)
Slider currSlider;// The slider that was just clicked on and is being dragged

// Images
ElectoralMap eM;// this is also tentative, it draws an electoral map, handle it later prob


// Deals
int[] mustSpeakFor;// you made a deal to speak in favor of these
int[] mustSpeakAgainst;// you made a deal to speak against these

// Other
ArrayList<Integer> suppS;// these are slightly complicated and not useful for really anything other than
ArrayList<Integer> agS;//   what I already wrote anyway, so don't worry about it. But if you want to know
ArrayList<Integer> suppH;// what these are, they're basically so that each turn the senate and house speeches
ArrayList<Integer> agH;//   the player made in the turn are processed. It holds those.


// menuActions
MenuActions menuActions;// controls all aspects of the game setup
boolean mainMenu;
/* Any settings for a new game */
String[] parties = {"Democratic", "Republican"};// only temporarily autoset
//int presLib = 50;
//int presSoc = 50;
//                             //
//                             //
/* =========================== */




// Sets the size of the game
// Precondition: size() or fullScreen()
// Postcondition: creates the game window
void settings() {
  Table options = loadTable("options.csv", "header");
  //if (options.getRow(0).getString(1).equals("yes")) {// fullScreen
  //  fullScreen();
  //}
  //else {// A smaller size setting
  size(displayWidth, (int)(displayHeight*.8));// *.8 is temp
  //}
}


/*
This is valuable for Processing, it's simply what sets up the game when it is initially run.
Right now this is developing a Beta so there isn't a nice menu, game setup, and loading games etc.
There will be all that stuff and I look forward to it. It will mostly be put here. But for now, this
is sort of a silly method that sets default variables that need to be set.
*/
// Precondition: No variables are set
// Postcondition: Variables are set and the game is playable default
void setup() {
  menuActions = new MenuActions();// always needed

  // This is the real code for this part but to write the game it needs to be tested
  /*
  mainMenu = true;
  screen = new MainMenuScreen();
  screen.setScreen();
  displayAll();
  */

  // Temporary:
  menuActions.newGame();

  menuActions.testCongress();
}




// Loads the screen on loop continuously
// Precondition: Every aspect that needs to be run has a display type method, but this doesn't call all of them anymore
// Postcondition: Nothing really happens, but the method is required for other built-in methods
void draw() {
  /* An essential Processing function!
  This runs the whole thing. Eventually
  it will also run a starting screen.
  */
  //if ((millis()/500)%2 == 0) {// smaller the divisor, faster the blinking
  displayTextInputs();
  //}
}

void displayTextInputs() {
  if (isCurrScreen(13)) {
    screen.displayTextInput(width/6, 62, "Search by state, name, party, or position:", screen.input, width*2/3, 16);
  }
  else if (isCurrScreen(14)) {
    screen.displayTextInput(width/6, 62, "Search by state, name, party, or position:", screen.input, width*2/3, 16);
  }
  else if (isCurrScreen(16)) {
    screen.displayTextInput(width/6, 62, "Search by state, name, party, or position:", screen.input, width*2/3, 16);
  }
  else if (isCurrScreen(21)) {// this one is broken
    screen.displayTextInput(width/6, height/6, "Name: ", tempBill.name, width*2/3, 40);
  }
}

// Precondition: The topbar and menu button as well as screen exist
// Postcondition: the topbar and menu button and either screen or menu are displayed
void displayAll() {
  screen.display();
  if (!mainMenu) {
    // If the game is open and not the menu
    if (menuOpen) {
      // If the menu is open
      menuScreen.display();
    }
    topBar();
    if (!screen.toString().equals("0")) {
      // If the screen is not the main screen
      mainButton();// The button that returns to main screen
    }
  }
}

// displays a horizontal bar at the top of the screen most of the time.
// Precondition:
// Postcondition: Turn # | Date | Approval Rating | Menu
void topBar() {
  fill(255);
  rect(0, -5, width, 35, 3);
  fill(0);
  textSize(16);
  textAlign(LEFT, CENTER);
  text("Turn: " + turn, 5, 15);
  text("Date: "+calendar.cMonth+"/"+calendar.day+"/"+calendar.cYear, width/4, 15);
  text("Approval Rating: " + approval + "%", width/2, 15);
  text("|| Menu ||", width*3/4, 15);
}

// Creates a button on the top left that brings you back to main screen.
void mainButton() {
  strokeWeight(5);
  line(width/10, height/10, width/10+20, height/10-15);
  line(width/10, height/10, width/10+20, height/10+15);
  strokeWeight(1);
  textSize(16);
  textAlign(CENTER, TOP);
  fill(0);
  if (screens.size() == 2) {
    text("Main Menu", width/10+10, height/10+30);
  }
  else {
    text("Back", width/10+10, height/10+30);
  }
}










//================================
//========= Controls =============
//================================

// If the mouse is clicked
// Precondition: Mouse is pressed and released
// Postcondition: The goal of the mouseclick is fulfilled
void mouseClicked() {
  /* What to do when the mouse is clicked */
  float mX = mouseX;
  float mY = mouseY;

  mouseClickedMenu(mX, mY);

  if (!menuOpen) {
    if (mouseClickedButton(mX, mY)) {
      // placeholder to prevent other things
    }
    else if (isCurrScreen(7)) {// Calendar Screen
      mouseClicked7(mX, mY);
      if (screen.extra < 100) {
        ((Screen7)screen).currCalendar.clickMonth(mX, mY);
      }
    }
    else if (isCurrScreen(10) || isCurrScreen(11)) {// Speech Screens
      mouseClicked10and11(mX, mY);
    }
    else if (isCurrScreen(13)) {// Legislator Deal Choice
      mouseClicked13(mX, mY);
    }
    else if (isCurrScreen(14)) {// Open Congressperson Popup
      mouseClicked14(mX, mY);
    }
    else if (isCurrScreen(16)) {// Find a Rep for Bill
      mouseClicked16(mX, mY);
    }
    else if (isCurrScreen(17)) {
      mouseClicked17(mX, mY);
    }
    else if (isCurrScreen(18)) {// New Bill Step 2
      mouseClicked18(mX, mY);
    }
    else if (isCurrScreen(20)) {// New Bill Step 4
      mouseClicked20(mX, mY);
    }
    else if (isCurrScreen(23)) {// Legislative Deal
      mouseClicked23(mX, mY);
    }
    else if (isCurrScreen(28)) {// Show Executive Action
      mouseClicked28(mX, mY);
    }
    else if (isCurrScreen(29)) {// New Executive Order
      mouseClicked29(mX, mY);
    }
    else if (isCurrScreen(30)) {// See Bills Status
      mouseClicked30(mX, mY);
    }
  }
}


// If the mouse is pressed
// Precondition: Mouse is pressed
// Postcondition: The goal of the mouse being pressed is fulfilled
void mousePressed() {
  // This is necessary for sliders, it's when the mouse is pressed and not released
  // ====== Sliders ======
  if (screen.sliders != null) {
    for (int i = 0; i < screen.sliders.length; i++)
    if (screen.sliders[i].isInside(mouseX, mouseY) && screen.sliders[i].visible)
    currSlider = screen.sliders[i];
  }

}


// If the mouse is released
// Precondition: Mouse is released from being held
// Postcondition: The slider is released so currSlider == null
void mouseReleased() {
  // Speaks for itself, sets currSlider to null
  currSlider = null;
}


// If the mouse is dragged
// Precondition: Mouse is pressed and dragged
// Postcondition: The slider's value is changed
void mouseDragged() {
  // If the mouse is held down and moved
  if (currSlider != null) {
    currSlider.value = (int)constrain(((
      mouseX+currSlider.boxSize/2-currSlider.x)*currSlider.maxVal/currSlider.len), 0, currSlider.maxVal);
    displayAll();
  }
}

// If the mousewheel is used
// Precondition: Mousewheel is used
// Postcondition: The goal of the mousewheel is fulfilled, usually a scrolling that happened
void mouseWheel(MouseEvent event) {
  // When the mouse is scrolled. Very useful for replacing the arrow keys
  float e = event.getCount();
  if (isCurrScreen(10) ||
  isCurrScreen(11) ||
  isCurrScreen(13) ||
  isCurrScreen(14) ||
  isCurrScreen(16) ||
  isCurrScreen(18)) {
    mouseWheelScrollX(e);
  }
}

// If the mouse is moved
// Precondition: Mouse is moved, not necessarily clicked or dragged
// Postcondition: The buttons recognize if they were scrolled over
void mouseMoved() {
  buttonsScrolled();
}

// If the keyboard is used
// Precondition: A key is pressed
// Postcondition: The goal of the key pressed is fulfilled
void keyPressed() {
  if (keyCode == ESC) {// this is really cool :D
    key = 0;// making sure it doesnt quit
    if (!mainMenu) {
      if (!isCurrScreen(0) && !menuOpen) {
        newScreen(new Button(0));
        screen.setScreen();
        displayAll();
      }
      else {
        menuOpen = !menuOpen;
        displayAll();
      }
    }
  }
  else if (isCurrScreen(21)) {
    tempBill.name = typeResult(tempBill.name);
    displayAll();
  }
  else if (isCurrScreen(13) || isCurrScreen(14) || isCurrScreen(16)) {
    screen.input = typeResult(screen.input);
    displayAll();
  }

  keyPressedScrollX();
  keyPressedScrollHoriz();

}




//===================================================//
//===================================================//
//============ Controls Helper Methods ==============//
//===================================================//
//===================================================//

/*

MouseClicked() Helpers

*/

// Checks whether a button is pressed and handles the action associated
// Precondition: The mouse is clicked
// Postcondition: The command of the button is fulfilled and a new screen is created
boolean mouseClickedButton(float mX, float mY) {
  // Main Menu Button
  boolean done = false;
  if (Utils.convertInt(screen.toString()) < 100) {
    textSize(16);
    float wordWidth = textWidth("Main Menu")/2;
    if (mX < width/10+10+wordWidth && mX > width/10+10-wordWidth && mY < height/10+46 && mY > height/10-15) {
      screens.remove(screens.size()-1);
      int screenNum = Utils.convertInt(screens.get(screens.size()-1).toString());
      screen = screens.get(screens.size()-1);
      displayAll();
    }

    // Normal buttons:
    if (screen.buttons != null) {
      for (int i = 0; i < screen.buttons.length && !done; i++)
      if (screen.buttons[i].isClicked(mX, mY)) {
        lastButtonInd = i;
        done = true;
        newScreen(screen.buttons[i]);
        displayAll();
      }
    }
  }
  return done;
}

// Checks whether the Menu button was pressed and opens the menu
// Precondition: The mouse is clicked
// Postcondition: The menu is opened
void mouseClickedMenu(float mX, float mY) {
  // text("|| Menu ||", width*3/4, 15);
  if (mX < width && mX > width*3/4 && mY < 30) {
    menuOpen = !menuOpen;
    displayAll();
  }
  // If menu buttons are clicked
  if (menuOpen) {
    boolean done = false;
    for (int i = 0; i < menuScreen.buttons.length && !done; i++)
      if (menuScreen.buttons[i].isInside(mX, mY) && menuScreen.buttons[i].visible && menuScreen.buttons[i].clickable) {
        done = true;
        newScreen(menuScreen.buttons[i]);
        // Do I need to display the menuScreen here?
      }
  }
}

// Screen 7
// Precondition: The mouse is clicked
// Postcondition: The events on the day are displayed
void mouseClicked7(float mX, float mY) {
  if (screen.extra < 100) {
    ((Screen7)screen).currCalendar.clickMonth(mX, mY);
    int col = 0;
    int row = 0;
    int dayCount = 1;
    boolean done = false;
    Calendar cal = ((Screen7)screen).currCalendar;
    while (dayCount <= cal.realDaysInMonth(cal.cYear)[cal.cMonth-1] && !done) {
      if (mX > width/6+width*2/21*col && mX < width/6+width*2/21*col+width*2/21) {
        if (mY > height/6+height*2/21+height*2/21*row && mY < height/6+height*2/21+height*2/21*row+height*2/21) {
          if (cal.getEventsOn(dayCount, cal.cMonth, cal.cYear).size() != 0) {
            screen.chosen = dayCount-1;
            done = true;
            displayAll();
          }
        }
      }
      col++;
      if (col == 7) {
        row++;
        col = 0;
      }
      dayCount++;
    }
    if (screen.chosen != 0) {
      textSize(20);
      if (mX > width*3/4-textWidth("Close") && mX < width*3/4) {
        if (mY > height*3/4 && mY < height*3/4+20) {
          screen.chosen = -1;
          displayAll();
        }
      }
    }
  }
}


// Screen 10 and 11
// Precondition: The mouse is clicked
// Postcondition: The entry clicked on has been chosen and is highlighted
void mouseClicked10and11(float mX, float mY) {
  if (mX > width/6 && mX < width*5/6) {
    if (mY > height/6 && mY < height/2) {
      for (int i = 0; i < bills.size(); i++)
      if (mY > height/6+24*i+screen.scrollX && mY < height/6+24*i+screen.scrollX+24) {
        screen.chosen = i+5;
        if (screen.d1.size() != 2) {
          screen.buttons[1].setLabel("Add", 14, 255);
          screen.buttons[1].clickable = true;
        }
        else {
          screen.buttons[1].setLabel("", 14, 255);
          screen.buttons[1].clickable = false;
        }
        if (screen.d2.size() != 2) {
          screen.buttons[2].setLabel("Add", 14, 255);
          screen.buttons[2].clickable = true;
        }
        else {
          screen.buttons[2].setLabel("", 14, 255);
          screen.buttons[2].clickable = false;
        }
      }
      displayAll();
    }
    else if (mX < width/2-40) {
      if (screen.d1.size() > 0 && mY > height/2+65 && mY < height/2+90) {
        screen.chosen = 1;
      }
      else if (screen.d1.size() > 1 && mY > height/2+90 && mY < height/2+115) {
        screen.chosen = 2;
      }
      screen.buttons[1].setLabel("Remove", 14, 255);
      screen.buttons[1].clickable = true;
      displayAll();
    }
    else if (mX > width/2+40) {
      if (screen.d2.size() > 0 && mY > height/2+65 && mY < height/2+90) {
        screen.chosen = 3;
      }
      else if (screen.d1.size() > 1 && mY > height/2+90 && mY < height/2+115) {
        screen.chosen = 4;
      }
      screen.buttons[2].setLabel("Remove", 14, 255);
      screen.buttons[2].clickable = true;
      displayAll();
    }
  }
}

// Screen 13
// Precondition: The mouse is clicked
// Postcondition: The entry clicked on has been chosen and is highlighted, buttons change names
void mouseClicked13(float mX, float mY) {
  if (mX > width/6 && mX < width*5/6) {
    if (mY > height/6 && mY < height*5/6) {
      for (int i = 0; i < screen.search.size(); i++)
      if (mY > height/6+24*i+screen.scrollX && mY < height/6+24*i+screen.scrollX+24) {
        screen.chosen = i;
        displayAll();
      }
    }
  }
}

// Screen 14
// Precondition: The mouse is clicked
// Postcondition: The entry clicked on has been chosen and popup window comes up
void mouseClicked14(float mX, float mY) {
  if (screen.extra == 0) {
    if (mX > width/6 && mX < width*5/6) {
      if (mY > height/6 && mY < height*5/6) {
        for (int i = 0; i < screen.search.size(); i++)
        if (mY > height/6+24*i+screen.scrollX && mY < height/6+24*i+screen.scrollX+24) {
          screen.chosen = i;
          screen.extra = 1;
          screen.setScreen();
          displayAll();
        }
      }
    }
  }
}

// Screen 16
// Precondition: The mouse is clicked
// Postcondition: The entry clicked on has been chosen and is highlighted
void mouseClicked16(float mX, float mY) {
  if (mX > width/6 && mX < width*5/6) {
    if (mX > height/6 && mY < height*5/6) {
      println(((Screen16)screen).sponsors.length);
      for (int i = 0; i < ((Screen16)screen).sponsors.length; i++) {
        if (mY > height/6+24*i+screen.scrollX && mY < height/6+24*i+screen.scrollX+24) {
          screen.chosen = i;
          println(i);
          displayAll();
        }
      }
    }
  }
}

// Screen 17
// Precondition: The mouse is clicked
// Postcondition: Will click on states on the map
void mouseClicked17(float mX, float mY) {

}

// Screen 18
// Precondition: The mouse is clicked
// Postcondition: The entry clicked on has been chosen and is highlighted, buttons change names
void mouseClicked18(float mX, float mY) {
  if (mX > width/6 && mX < width*5/6) {
    if (mY > height/6 && mY < height/2) {
      for (int i = 0; i < screen.depIdeas.size(); i++)
      if (mY > height/6+24*i+screen.scrollX && mY < height/6+24*i+screen.scrollX+24) {
        screen.chosen = i+3;
        screen.buttons[1].setLabel("Add", 14, 255);
        screen.buttons[1].clickable = true;
        displayAll();
      }
    }
    else if (tempBill.ideas[0] != -1 && mY > height-208 && mY < height-174) {
      screen.chosen = 1;
      screen.buttons[1].setLabel("Remove", 14, 255);
      screen.buttons[1].clickable = true;
      displayAll();
    }
    else if (tempBill.ideas[1] != -1 && mY > height-174 && mY < height-140) {
      screen.chosen = 2;
      screen.buttons[1].setLabel("Remove", 14, 255);
      screen.buttons[1].clickable = true;
      displayAll();
    }
  }
}

// Screen 20
// Precondition: The mouse is clicked
// Postcondition: The entry clicked on has been chosen and is highlighted, buttons change names
void mouseClicked20(float mX, float mY) {
  if (mX > width/6 && mX < width*5/6) {
    if (mY > height/6 && mY < height-181) {
      for (int i = 0; i < screen.depIdeas.size(); i++)
      if (mY > height/6+24*i+screen.scrollX && mY < height/6+24*i+screen.scrollX+24) {
        screen.chosen = i+2;
        screen.buttons[1].setLabel("Add", 14, 255);
        screen.buttons[1].clickable = true;
        displayAll();
      }
    }
    else if (tempBill.ideas[2] != -1 && mY > height-174 && mY < height-140) {
      screen.chosen = 1;
      screen.buttons[1].setLabel("Remove", 14, 255);
      screen.buttons[1].clickable = true;
      displayAll();
    }
  }
}

// Screen 23
// Precondition: The mouse is clicked
// Postcondition: The entry clicked on has been chosen and is highlighted
void mouseClicked23(float mX, float mY) {
  if (mX > width/6 && mX < width/6+max(wordWidths(screen.trade.themOptions, 15))) {
    if (mY > height/6 && mY < height*5/6) {
      int x = 0;
      for (int i = 0; i < screen.trade.displays.length; i++) {
        for (int j = 0; j < screen.trade.displays[i].size(); i++) {
          if (mY > height/6+15*x+screen.scrollsX[0] && mY < height/6+15*x+screen.scrollsX[0]+24) {
            // somewhere displayAll();
          }
        }
        //if ((String)displays.get(i))
        //
      }
    }
  }
}

// Screen 28
// Precondition: The mouse is clicked
// Postcondition: The entry clicked on has been chosen and popup window comes up
void mouseClicked28(float mX, float mY) {
  if (screen.extra == 0) {
    if (mX > width/6 && mX < width*5/6) {
      if (mY > height/6 && mY < height*5/6) {
        for (int i = 0; i < executiveOrders.size(); i++)
        if (mY > height/6+24*i+screen.scrollX && mY < height/6+24*i+screen.scrollX+24) {
          screen.chosen = i;
          screen.extra = 1;
          screen.setScreen();
          displayAll();
        }
      }
    }
  }
}

// Screen 29
// Precondition: The mouse is clicked
// Postcondition: The entry clicked on has been chosen and is highlighted, buttons change names
void mouseClicked29(float mX, float mY) {
  if (mX > width/6 && mX < width*5/6) {
    if (mY > height/6 && mY < height/2) {
      for (int i = 0; i < screen.depIdeas.size(); i++)
      if (mY > height/6+24*i+screen.scrollX && mY < height/6+24*i+screen.scrollX+24) {
        screen.chosen = i+4;
        screen.buttons[2].setLabel("Add", 14, 255);
        screen.buttons[2].clickable = true;
        displayAll();
      }
    }
    else if (tempOrder.ideas[0] != -1 && mY > height-208 && mY < height-174) {
      screen.chosen = 1;
      screen.buttons[2].setLabel("Remove", 14, 255);
      screen.buttons[2].clickable = true;
      displayAll();
    }
    else if (tempOrder.ideas[1] != -1 && mY > height-174 && mY < height-140) {
      screen.chosen = 2;
      screen.buttons[2].setLabel("Remove", 14, 255);
      screen.buttons[2].clickable = true;
      displayAll();
    }
    else if (tempOrder.ideas[2] != -1 && mY > height-140 && mY < height-116) {
      screen.chosen = 3;
      screen.buttons[2].setLabel("Remove", 14, 255);
      screen.buttons[2].clickable = true;
      displayAll();
    }
  }
}

// Screen 30
// Precondition: The mouse is clicked
// Postcondition: The entry clicked on has been chosen and popup window comes up
void mouseClicked30(float mX, float mY) {
  if (screen.chosen == -1) {
    if (mX > width/6 && mX < width*5/6) {
      if (mY > height/6 && mY < height*5/6) {
        ArrayList<Bill> billList = new ArrayList<Bill>();
        if (screen.extra == 0) {// committee
          for (Committee c : houseCommittees) {
            for (Bill b : c.cBills) {
              billList.add(b);
            }
          }
          for (Committee c : senateCommittees) {
            for (Bill b : c.cBills) {
              billList.add(b);
            }
          }
        }
        else if (screen.extra == 1) {// House floor
          billList = hBills;
        }
        else if (screen.extra == 2) {// Senate floor
          billList = sBills;
        }
        else if (screen.extra == 3) {// Conference Committee
          for (Committee c : conferenceComs) {
            billList.add(c.cBills.get(0));
          }
        }
        else if (screen.extra == 4) {// Your Desk
          billList = yourDesk;
        }

        for (int i = 0; i < billList.size(); i++) {
          if (mY > height/6+24*i+screen.scrollX && mY < height/6+24*i+screen.scrollX+24) {
            screen.chosen = i;
            screen.setScreen();
            displayAll();
          }
        }
      }
    }
  }
}

/*

mouseWheel() Helpers

*/

// The mousewheel is used to scroll
// Precondition: The mousewheel is scrolled
// Postcondition: The info displayed is shifted up or down depending on the scroll direction
void mouseWheelScrollX(float e) {
  if (e > 0 && screen.scrollX != 0) {
    screen.scrollX += 20;
    displayAll();
  }
  else if (e < 0) {
    screen.scrollX -= 20;
    displayAll();
  }
}

/*

mouseMoved() Helpers

*/

// Checks if a button is being scrolled over
// Precondition: The mouse is moved somewhere
// Postcondition: If the mouse is on a button, the button is set to scrolled == true
void buttonsScrolled() {
  if (!menuOpen) {
    if (screen.buttons != null)
    for (int i = 0; i < screen.buttons.length; i++) {
      if (screen.buttons[i].isInside(mouseX, mouseY)) {
        screen.buttons[i].scrolled = true;
        displayAll();
      }
      else {
        if (screen.buttons[i].scrolled == true) {
          screen.buttons[i].scrolled = false;
          displayAll();
        }
      }
    }
  }
  else {
    if (menuScreen.buttons != null)
    for (int i = 0; i < menuScreen.buttons.length; i++) {
      if (menuScreen.buttons[i].isInside(mouseX, mouseY)) {
        menuScreen.buttons[i].scrolled = true;
        displayAll();
      }
      else {
        if (menuScreen.buttons[i].scrolled == true) {
          menuScreen.buttons[i].scrolled = false;
          displayAll();
        }
      }
    }
  }
}
/*

keyPressed() Helpers

*/

// Changes a String through typing
// Precondition: The keyboard letters are typed, it is an appropriate screen
// Postcondition: The String s is changed in the way the keyboard has requested
String typeResult(String s) {
  if (keyCode == BACKSPACE) {
    if (s.length() != 0)
    s = s.substring(0, s.length()-1);
  }

  else if (keyCode != ENTER && keyCode != SHIFT && keyCode != UP && keyCode != DOWN) {
    if (s.equals("Type name here")) {
      return key+"";
    }
    s += key;
  }
  return s;
}

// All cases where the arrow keys are used to scroll through a list
// Precondition: The keyboard arrow keys are used
// Postcondition: The info displayed is shifted up or down depending on the arrow keys used
void keyPressedScrollX() {
  if (isCurrScreen(10) ||
  isCurrScreen(11) ||
  isCurrScreen(13) ||
  isCurrScreen(14) ||
  isCurrScreen(16) ||
  isCurrScreen(18)) {
    if (keyCode == UP && screen.scrollX != 0) {
      screen.scrollX += 20;
      displayAll();
    }
    else if (keyCode == DOWN) {
      screen.scrollX -= 20;
      displayAll();
    }
  }
}

// All cases where arrow keys are used horizontally
// Precondition: The LEFT RIGHT arrow keys are used
// Postcondition: The screen reacts to the Horizontal arrow keys
void keyPressedScrollHoriz() {
  if (isCurrScreen(2)) {
    if (keyCode == LEFT && screen.extra != 0) {
      newScreen(screen.buttons[2]);
      displayAll();
    }
    else if (keyCode == RIGHT && screen.extra != cabinet.length-1) {
      newScreen(screen.buttons[1]);
      displayAll();
    }
  }
  else if (isCurrScreen(7)) {
    if (keyCode == LEFT) {
      ((Screen7)screen).currCalendar.changeMonth(-1);
      displayAll();
    }
    else if (keyCode == RIGHT) {
      ((Screen7)screen).currCalendar.changeMonth(1);
      displayAll();
    }
  }
}

//===================================================//
//===================================================//
//================== Other Methods ==================//
//===================================================//
//===================================================//

// Adds a new screen and makes it the current screen shown
// Precondition: Button b has just been pressed, uses b.command, the screen it should go to
// Postcondition: a new Screen is set up and added to the query of past Screens (0 resets)
void newScreen(Button b) {
  int lastchosen = screen.chosen;
  switch (b.command) {
    case 0:
      screen = new Screen0();
      screens = new ArrayList<Screen>();
      screens.add(screen);
      break;
    case 1:
      screen = new Screen1();
      screens.add(screen);
      break;
    case 2:
      screen = new Screen2();
      screens.add(screen);
      break;
    case 3:
      screen = new Screen3();
      screens.add(screen);
      break;
    case 4:
      screen = new Screen4();
      screens.add(screen);
      break;
    case 5:
      screen = new Screen5();
      screens.add(screen);
      break;
    case 6:
      screen = new Screen6();
      screens.add(screen);
      break;
    case 7:
      screen = new Screen7();
      screens.add(screen);
      break;
    case 8:
      screen = new Screen8();
      screens.add(screen);
      break;
    case 9:
      screen = new Screen9();
      screens.add(screen);
      break;
    case 10:
      screen = new Screen10();
      screens.add(screen);
      break;
    case 11:
      screen = new Screen11();
      screens.add(screen);
      break;
    case 12:
      screen = new Screen12();
      screens.add(screen);
      break;
    case 13:
      screen = new Screen13();
      screens.add(screen);
      break;
    case 14:
      screen = new Screen14();
      screens.add(screen);
      break;
    case 15:
      screen = new Screen15();
      screens.add(screen);
      break;
    case 16:
      screen = new Screen16();
      screens.add(screen);
      break;
    case 17:
      screen = new Screen17();
      screens.add(screen);
      break;
    case 18:
      screen = new Screen18();
      screens.add(screen);
      break;
    case 19:
      screen = new Screen19();
      screens.add(screen);
      break;
    case 20:
      screen = new Screen20();
      screens.add(screen);
      break;
    case 21:
      screen = new Screen21();
      screens.add(screen);
      break;
    case 22:
      screen = new Screen22();
      screens.add(screen);
      break;
    case 23:
      screen = new Screen23();
      screens.add(screen);
      break;
    case 24:
      screen = new Screen24();
      screens.add(screen);
      break;
    case 25:
      screen = new Screen25();
      screens.add(screen);
      break;
    case 26:
      screen = new Screen26();
      screens.add(screen);
      break;
    case 27:
      screen = new Screen27();
      screens.add(screen);
      break;
    case 28:
      screen = new Screen28();
      screens.add(screen);
      break;
    case 29:
      screen = new Screen29();
      screens.add(screen);
      break;
    case 30:
      screen = new Screen30();
      screens.add(screen);
      break;
    case 31:
      screen = new Screen31();
      screens.add(screen);
      break;
    case 32:
      screen = new Screen32();
      screens.add(screen);
      break;
    case 33:
      screen = new Screen33();
      screens.add(screen);
      break;
    case 34:
      screen = new Screen34();
      screens.add(screen);
      break;
    case 35:
      screen = new Screen35();
      screens.add(screen);
      break;
    case 36:
      screen = new Screen36();
      screens.add(screen);
      break;
    case 37:
      screen = new Screen37();
      screens.add(screen);
      break;

    // MenuScreen Cases
    case 100:
      menuScreen = new MenuScreen();
      menuScreen.extra = 0;
      break;
    case 101:
      menuScreen = new MenuScreen();
      menuScreen.extra = 1;
      break;
    case 102:
      menuScreen = new MenuScreen();
      menuScreen.extra = 2;
      break;
    case 103:
      menuScreen = new MenuScreen();
      menuScreen.extra = 3;
      break;
    case 104:
      menuScreen = new MenuScreen();
      menuScreen.extra = 4;
      break;

    // MainMenuScreen Cases
    case 200:
      screen = new MainMenuScreen();
      break;
    case 201:
      screen = new MainMenuScreen1();
      break;
    case 202:
      screen = new MainMenuScreen2();
      break;
    case 203:
      screen = new MainMenuScreen3();
      break;

    // Briefing Cases
    case 300:
      screen = new BriefingScreen1();
  }
  screen.extra = b.extra;
  if (!mainMenu && screens.size() > 1) {
    screen.lastchosen = lastchosen;
    screen.d1 = screens.get(screens.size()-2).d1;
    screen.d2 = screens.get(screens.size()-2).d2;
    screen.input = screens.get(screens.size()-2).input;
  }
  if (!menuOpen) {
    screen.setScreen();
  }
  else {
    menuScreen.setScreen();
  }
  println(screens);
}

// Returns whether int s is the current screen
// Precondition: An int to test if it's the currentScreen
// Postcondition: A boolean true of false whether it is
boolean isCurrScreen(int s) {
  return screen.toString().equals(Utils.convertIntToString(s));
}

// Returns an array with the widths of words in String[] words
// Precondition: String[] words is an array of words, and int s is the textSize
// Postcondition: returns a parallel array with the lengths of each word in String[] words
int[] wordWidths(String[] words, int s) {
  textSize(s);
  int[] ls = new int[words.length];
  for (int i = 0; i < words.length; i++)
  ls[i] = (int)textWidth(words[i]);
  return ls;
}
//===================================================//
//===================================================//
//================ Next Turn Method =================//
//===================================================//
//===================================================//

// This method progresses the game by setting up the next turn.
// Precondition: The Next Turn button has been pressed, and values need to be reset
// Postcondition: Values are reset and the events of the turn are set
void nextTurn() {
  turn++;

  setDay(calendar);
  setDay(houseCalendar);
  setDay(senateCalendar);
  for (Committee com : houseCommittees)
  setDay(com.cCalendar);
  for (Committee com : senateCommittees)
  setDay(com.cCalendar);


  // React to speeches
  for (int i = 0; i < senate.length; i++)
  senate[i].listenToSpeech(suppS, agS);
  for (int i = 0; i < house.length; i++)
  house[i].listenToSpeech(suppH, agH);

  resetForTurn();

  // Set up the Briefing
  newScreen(new Button(300));
  displayAll();
}

// This moves time forward once each turn
// Precondition: the current date, in calendar is outdated
// Postcondition: the day, month, and year are up to date and forward daysPerTurn days
void setDay(Calendar c) {
  for (int i = 0; i < daysPerTurn; i++) {// uses the above variable (will be a constant)
    c.day++;
    if (c.day > daysInMonth[c.cMonth-1]) {
      c.day = 1;
      c.cMonth++;
      if (c.cMonth > 12) {
        c.cMonth = 1;
        c.cYear++;
      }
    }
  }
}

// handles any resetting required in a new turn
// Precondition: new turn
// Postcondition: values are reset
void resetForTurn() {
  suppH = new ArrayList<Integer>();
  suppS = new ArrayList<Integer>();
  agH = new ArrayList<Integer>();
  agS = new ArrayList<Integer>();
}





  /* THINGS TO DO CHECKLIST:

  - What to display for Cabinet members?
  - Hover over selection tables
  - See more information for each selection in selection tables
  - Selections disappear
  - Fix states names
  - Float Bills and Executive Orders to media

  - Election Map
  - UN
  - War
  - Intelligence
  - Stats

  */