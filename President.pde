// Globals:
// this is good:
// https://www.whitehouse.gov/briefing-room/signed-legislation

String name;// Player name (Set at start later)
String presParty;// Player party (Set at start later)

boolean menuOpen;// True or false if the Menu is up

ArrayList<Screen> screens;
Screen screen;// Handles most display aspects
MenuScreen menuScreen;// Displays if menuOpen
Calendar calendar;// the calendar
FedBudget fedBudget;// Handles the budget
Ideas ideas;// Handles the 'ideas', Bills are made of up to 3 of ideas held in this object

NationalCom you;// Your party's national committee
NationalCom them;// Opposing party's national committee

int turn;// number of turns so far (starting from 0 at setup to 1 at first turn)

int approval;// national polling approval of you
boolean houseSpeech;// have you made a speech to the house this turn?
boolean senateSpeech;// have you made a speech to the senate this turn?
ArrayList<Bill> bills;// all bills created at the moment
ArrayList<Bill> laws;// all laws passed
Congressman[] house;// array of congressmen in the house
Congressman[] senate;// array of congressmen in the senate
Secretary[] cabinet;// array of secretaries in your cabinet
SCJustice[] scotus;// array of justices in the Supreme Court (will I need this at alL?)


Bill tempBill;// current bill that you're having drafted (only stored here because it has to be global)
Slider currSlider;// The slider that was just clicked on and is being dragged

// Images
ElectoralMap eM;// this is also tentative, it draws an electoral map, handle it later prob


// Deals
int[] mustSpeakFor;// you made a deal to speak in favor of these
int[] mustSpeakAgainst;// you made a deal to speak against these

ArrayList<Integer> suppS;// these are slightly complicated and not useful for really anything other than
ArrayList<Integer> agS;//   what I already wrote anyway, so don't worry about it. But if you want to know
ArrayList<Integer> suppH;// what these are, they're basically so that each turn the senate and house speeches
ArrayList<Integer> agH;//   the player made in the turn are processed. It holds those.

/*
  This is valuable for Processing, it's simply what sets up the game when it is initially run.
  Right now this is developing a Beta so there isn't a nice menu, game setup, and loading games etc.
  There will be all that stuff and I look forward to it. It will mostly be put here. But for now, this
  is sort of a silly method that sets default variables that need to be set.
*/
// Precondition: No variables are set
// Postcondition: Variables are set and the game is playable default
void setup() {

  int wid = displayWidth;// for some reason size wouldn't take variables, so this is the solution. Ugh.
  int hei = (int)(displayHeight*.8);// Eventually this will just be displayHeight
  size(displayWidth, displayHeight);//640);// 640 is temp bc processing 3 sucks a bit

  turn = 0;
  String[] parties = {"Democratic", "Republican"};
  setPresParty(parties);// Default is that Democrat is the presParty
  createSingleClasses();
  createCongress();
  createCabinet();
  createCourt();

  loadImages();

  calcApproval();

  // This is temporary
  for (int i = 0; i < 5; i++) {
    bills.add(new Bill());
    bills.get(i).name = "Bill "+(i+1);
    bills.get(i).committee = i;
    bills.get(i).status = (int)random(5);
    bills.get(i).addOpinions();
  }
  // ^ Temporary ^ //

  displayAll();
}

// Sets up the two parties
// Precondition: parties is a String array with .length == 2 where parties[0] is the
//    President's party and parties[1] is the opposition (["Democratic", "Republican"])
// Postcondition: you and them are new national committees for both parties
void setPresParty(String[] parties) {
  println("setPresParty");
  you = new NationalCom(parties[0]);
  them = new NationalCom(parties[1]);

  you.administration = true;
  them.administration = false;
}

// Sets up any case of one instance of each class
// Precondition: The variables with the class name created in President.pde
// Postcondition: The variables are set
void createSingleClasses() {
  println("createSingleClasses");
  // one of each class things
  screen = new Screen0();
  screen.setScreen();
  menuScreen = new MenuScreen();
  calendar = new Calendar();
  fedBudget = new FedBudget();
  ideas = new Ideas();

  bills = new ArrayList<Bill>();
  laws = new ArrayList<Bill>();
  house = new Congressman[435];
  senate = new Congressman[100];
  scotus = new SCJustice[9];

  screens = new ArrayList<Screen>();
  screens.add(screen);

  // Needs to happen somewhere, don't worry about it.
  suppH = new ArrayList<Integer>();
  suppS = new ArrayList<Integer>();
  agH = new ArrayList<Integer>();
  agS = new ArrayList<Integer>();
}

// Sets up the Cabinet
// Precondition: majordepartments.csv lists all of the major departments to have secretaries
// Postcondition: cabinet is an array of Secretaries with only department set
void createCabinet() {
  println("createCabinet");
  cabinet = new Secretary[15];
  Table d = loadTable("majordepartments.csv", "header");
  for (int i = 0; i < cabinet.length; i++)
    cabinet[i] = new Secretary(d.getRow(i).getString(0), d.getRow(i).getString(1));
}

// Sets up the Supreme Court
// Precondition:
// Postcondition:
void createCourt() {
  println("createCourt");

}
// You can split this into helper functions, but here's the bulk
// This method stacks the two arrays that hold Congress.
// Precondition: states.csv has information about states, val is an int with how likely each state is to be Dem.
// Postcondition: senate and house are arrays of Congressmen fully initialized
void createCongress() {
  println("createCongress");
  Table states = loadTable("states.csv", "header");// a table with states etc.
  initCongress(states);
  int xSenate = 0;
  int xHouse = 0;
  for (TableRow row : states.rows()) {// Ok so everything about states is not an issue, keep these
    if (!row.getString(1).equals("DC")) {
    // val is an int from 0 to 5 inclusive that tells you how likely it is to be a dem (5 is very likely)
      int val = Utils.convertInt(row.getString(2));// This can be used anywhere you want

      //=== Senators ===//

      // senate[x] and senate[x+1] are Congressman objects to be accessed
      xSenate+=2;

      //=== Representatives ===//
      for (int i = 0; i < Utils.convertInt(row.getString(3)); i++) {// row.getString(3) says how many reps in the state
        // house[x] is the Congressman to be accessed
        xHouse++;
      }
    }
  }

  // You may find this useful, it tests the code for senate
  testCongress();
}

// Test to check the makeup of congress
// Precondition: senate and house are arrays of Congressmen that are initialized
// Postcondition: Prints the makeup of each house of congress
private void testCongress() {
  println("testCongress");
}

// Initialize Congresspeople
// Precondition: names.csv lists first and last names; states lists states and state info from states.csv
// Postcondition: Both houses of congress have Congressmen with names, states, and house set
void initCongress(Table states) {
  println("initCongress");
  Table names = loadTable("names.csv", "header");// A table that has first and last names
  ArrayList<String> firstNames = new ArrayList<String>();
  ArrayList<String> lastNames  = new ArrayList<String>();
  for (TableRow row : names.rows()) {
    firstNames.add(row.getString(0));
    lastNames.add(row.getString(1));
  }

  int xSenate = 0;
  int xHouse = 0;
  for (TableRow row : states.rows()) {
    if (!row.getString(1).equals("DC")) {
      // Initialize Senators
      String n = firstNames.remove((int)random(firstNames.size()))+" "+lastNames.remove((int)random(lastNames.size()));
      senate[xSenate] = new Congressman(n, row.getString(1), 1);
      n = firstNames.remove((int)random(firstNames.size()))+" "+lastNames.remove((int)random(lastNames.size()));
      senate[xSenate+1] = new Congressman(n, row.getString(1), 1);
      xSenate+=2;
      // Initialize Representatives
      for (int i = 0; i < Utils.convertInt(row.getString(3)); i++) {
        n = firstNames.remove((int)random(firstNames.size()))+" "+lastNames.remove((int)random(lastNames.size()));
        house[xHouse] = new Congressman(n, row.getString(1), 0);
        house[xHouse].party = 'D';
        xHouse++;
      }
    }
  }
}

// Loads all images necessary to the game
// Precondition: any images needed for the whole game are stored as variables
// Postcondition: load all images and set the variables to them
void loadImages() {
  println("loadImages");
  // The Electoral Map thing only sorta belongs here

  eM = new ElectoralMap();// move this to createSingleClasses()

  // Eventually all other images will be loaded.
}

// calculates the current presidential approval rate
// Precondition: This isn't a finished method so I don't really know yet
// Postcondition: Approval is a percentage between 0 - 100
void calcApproval() {
  println("calcApproval");
  approval = 50;// Temporary, eventually there will be a calculation here.
}








// Loads the screen on loop continuously
// Precondition: Every aspect that needs to be run has a display type method, but this doesn't call all of them anymore
// Postcondition: Nothing really happens, but the method is required for other built-in methods
void draw() {
  /* An essential Processing function!
     This runs the whole thing. Eventually
     it will also run a starting screen.
  */
}

// Displays everything
// Precondition: The topbar and menu button as well as screen exist
// Postcondition: the topbar and menu button and either screen or menu are displayed
void displayAll() {
  screen.display();
  if (menuOpen)
    menuScreen.display();
  topBar();
  if (!screen.toString().equals("0"))
    mainButton();// The button that returns to main screen
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
  text("Main Menu", width/10+10, height/10+30);
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
    mouseClickedButton(mX, mY);
    println(isCurrScreen(10));
    println(screen);
    if (isCurrScreen(7)) {// Calendar Screen
      calendar.clickMonth(mX, mY);
    }
    else if (isCurrScreen(10) || isCurrScreen(11)) {// Speech Screens
      mouseClicked10and11(mX, mY);
    }
    else if (isCurrScreen(13)) {// Legislator Deal Choice
      mouseClicked13(mX, mY);
    }
    else if (isCurrScreen(16)) {// Find a Rep for Bill
      mouseClicked16(mX, mY);
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
    if (!isCurrScreen(0)) {
      newScreen(new Button(0));
      screen.setScreen();
      displayAll();
    }
    else {
      menuOpen = !menuOpen;
      displayAll();
    }
  }
  else if (isCurrScreen(21)) {
    tempBill.name = typeResult(tempBill.name);
    displayAll();
  }
  else if (isCurrScreen(13) || isCurrScreen(14)) {
    screen.input = typeResult(screen.input);
    displayAll();
  }

  keyPressedScrollX();


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
void mouseClickedButton(float mX, float mY) {
  // Main Menu Button
  textSize(16);
  float wordWidth = textWidth("Main Menu")/2;
  if (mX < width/10+10+wordWidth && mX > width/10+10-wordWidth && mY < height/10+46 && mY > height/10-15) {
    newScreen(new Button(0));
    //screen.setScreen();
    displayAll();
  }

  // Normal buttons:
  if (screen.buttons != null) {
    boolean done = false;
    for (int i = 0; i < screen.buttons.length && !done; i++)
      if (screen.buttons[i].isInside(mX, mY) && screen.buttons[i].visible && screen.buttons[i].clickable) {
        done = true;
        newScreen(screen.buttons[i]);
        displayAll();
      }
  }
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

// Screen 10 and 11
// Precondition: The mouse is clicked
// Postcondition: The entry clicked on has been chosen and is highlighted
void mouseClicked10and11(float mX, float mY) {
  if (mX > width/6 && mX < width*5/6) {
    println("Hello");
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

// Screen 16
// Precondition: The mouse is clicked
// Postcondition: The entry clicked on has been chosen and is highlighted
void mouseClicked16(float mX, float mY) {
  if (mX > width/6 && mX < width*5/6) {
    if (mX > height/6 && mY < height*5/6) {
      int x = 0;
      for (int i = 0; i < house.length; i++) {
        if (house[i].committee == tempBill.committee) {
          if (mY > height/6+24*x+screen.scrollX && mY < height/6+24*x+screen.scrollX+24) {
            screen.chosen = x;
            displayAll();
          }
          x++;
        }
      }
    }
  }
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
    s += key;
  }
  return s;
}

// All cases where the arrow keys are used to scroll through a list
// Precondition: The keyboard arrow keys are used
// Postcondition: The info displayed is shifted up or down depending on the arrow keys used
void keyPressedScrollX() {
  if( isCurrScreen(10) ||
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

//===================================================//
//===================================================//
//================== Other Methods ==================//
//===================================================//
//===================================================//

// Adds a new screen and makes it the current screen shown
// Precondition: Button b has just been pressed, uses b.command, the screen it should go to
// Postcondition: a new Screen is set up and added to the query of past Screens (0 resets)
void newScreen(Button b) {
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
  }
  screen.extra = b.extra;
  if (screens.size() > 1) {
    screen.chosen = screens.get(screens.size()-2).chosen;
    screen.d1 = screens.get(screens.size()-2).d1;
    screen.d2 = screens.get(screens.size()-2).d2;
  }
  if (!menuOpen)
    screen.setScreen();
  else
    menuScreen.setScreen();
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

  setDay();

  // React to speeches
  for (int i = 0; i < senate.length; i++)
    senate[i].listenToSpeech(suppS, agS);
  for (int i = 0; i < house.length; i++)
    house[i].listenToSpeech(suppH, agH);

  suppH = new ArrayList<Integer>();
  suppS = new ArrayList<Integer>();
  agH = new ArrayList<Integer>();
  agS = new ArrayList<Integer>();

  // This is the beginning of code that changes the status of bills
  //  for (int i = 0; i < bills.length; i++) {
  //    if (bills.get(i).status == 1 || bills.get(i).status == 2)

 //   }

}
// This moves time forward once each turn
// Precondition: the current date, in calendar is outdated
// Postcondition: the day, month, and year are up to date and forward daysPerTurn days
void setDay() {
  int daysPerTurn = 7; // this decides how many days is one turn.
  // I don't really know what it should be yet, it depends on testing.

  for (int i = 0; i < daysPerTurn; i++) {// uses the above variable (will be a constant)
    calendar.day++;
    if (calendar.day > daysInMonth[calendar.cMonth-1]) {
      calendar.day = 1;
      calendar.cMonth++;
      if (calendar.cMonth > 12) {
        calendar.cMonth = 1;
        calendar.cYear++;
      }
    }
  }
}