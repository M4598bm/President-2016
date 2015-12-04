// Globals:
// this is good:
// https://www.whitehouse.gov/briefing-room/signed-legislation

String name;// Player name (Set at start later)
String presParty;// Player party (Set at start later)

Screen screen;// Handles most display aspects
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

// These are tentative and was a stupid way to do this lol
int sBalance;// percent of Democrats in the senate? Eww
int hBalance;// percent of Dems in the house, also eww
// ^ I think Richard gets to fix that algorithm.... ^

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

void setup() {
  /*
    This is valuable for Processing, it's simply what sets up the game when it is initially run.
    Right now this is developing a Beta so there isn't a nice menu, game setup, and loading games etc.
    There will be all that stuff and I look forward to it. It will mostly be put here. But for now, this
    is sort of a silly method that sets default variables that need to be set.
  */
  int wid = displayWidth;// for some reason size wouldn't take variables, so this is the solution. Ugh.
  int hei = (int)(displayHeight*.8);// Eventually this will just be displayHeight
  size(displayWidth, displayHeight);//640);// 640 is temp bc processing 3 sucks a bit
  //println(wid+","+hei);// just for testing

  turn = 0;

  // Sets up a default Party, eventually player decides this obv.
  presParty = "Democratic";// or "Republican"
  you = new NationalCom(presParty);
  if (presParty == "Democratic")
    them = new NationalCom("Republican");
  else
    them = new NationalCom("Democratic");
  you.administration = true;
  them.administration = false;

  // one of each class things
  screen = new Screen();
  calendar = new Calendar();
  fedBudget = new FedBudget();
  ideas = new Ideas();

  bills = new ArrayList<Bill>();
  laws = new ArrayList<Bill>();
  house = new Congressman[435];
  senate = new Congressman[100];
  scotus = new SCJustice[9];

  // ===================== //
  // stack the courts here //
  // ===================== //

  // This stacks the Cabinet //
  cabinet = new Secretary[15];
  Table d = loadTable("majordepartments.csv", "header");
  for (int i = 0; i < cabinet.length; i++)
    cabinet[i] = new Secretary(d.getRow(i).getString(0), d.getRow(i).getString(1));

  // This stacks Congress, sort of flawed //
  createCongress();

  // This will be decided in beginning so for now has default
  sBalance = 55;
  hBalance = 55;// Remember I told you these things suck? They do, I didn't lie

  // loading images
  eM = new ElectoralMap();// lol
  // Eventually all other images will be loaded.

  approval = 50;// Temporary because it needs to start somewhere! Eventually there will be a calculation here.


  // Needs to happen somewhere, don't worry about it.
  suppH = new ArrayList<Integer>();
  suppS = new ArrayList<Integer>();
  agH = new ArrayList<Integer>();
  agS = new ArrayList<Integer>();

  // This is temporary
  for (int i = 0; i < 5; i++) {
    bills.add(new Bill());
    bills.get(i).name = "Bill "+(i+1);
    bills.get(i).committee = i;
    bills.get(i).status = (int)random(5);
    bills.get(i).addOpinions();
  }
  // ^ Temporary ^ //


  // To decrease runtime, this will eventually happen at key times.
  // I might have to keep a variable for bgcolor because this is a
  // random assortment of numbers. We might also want a different
  // color, this one can be temp, so yea, that's a good idea
  background(50, 125, 250);
}


void draw() {
  /* Also an essential Processing function!
     This runs the whole thing. Eventually
     it will also run a starting screen.
  */
  screen.display();// For some reason we do this every loop... that
  //makes it slow and it doesn't need to happen so I'll work on that later
  topBar();// That menu at the top is displayed

  if (screen.currScreen != 0)
    mainButton();// The button that returns to main screen

  // The following checks if a button is being scrolled over
  if (screen.buttons != null)
    for (int i = 0; i < screen.buttons.length; i++) {
      if (screen.buttons[i].isInside(mouseX, mouseY))
        screen.buttons[i].scrolled = true;
      else
        screen.buttons[i].scrolled = false;
    }
}

void topBar() {// Turn # | Date | Approval Rating | Turns until next election
  /* This method displays a horizontal bar at the top of the screen that
  displays most of the time.
  */

  fill(255);
  rect(0, -5, width, 35, 3);
  fill(0);
  textSize(16);
  textAlign(LEFT, CENTER);
  text("Turn: " + turn, 5, 15);
  text("Date: "+calendar.cMonth+"/"+calendar.day+"/"+calendar.cYear, width/4, 15);
  text("Approval Rating: " + approval + "%", width/2, 15);
  text("Turns until next election", width*3/4, 15);// This needs to be found
}

void mainButton() {
  /* This method creates a button on the top left that brings you back to main screen.
  */
  strokeWeight(5);
  line(width/10, height/10, width/10+20, height/10-15);
  line(width/10, height/10, width/10+20, height/10+15);
  strokeWeight(1);
  textSize(16);
  textAlign(CENTER, TOP);
  fill(0);
  text("Main Menu", width/10+10, height/10+30);
}

void createCongress() {
  /* This method stacks the two arrays that hold Congress.
     It names congressmen, gives parties, gives states, gives districts (maybe),
     gives approvals ratings, gives election cycles for senators
  */
  //=== Names ===//
  // Initializes names of Congressmen, this is fine
  Table names = loadTable("names.csv", "header");// A table that has first and last names
  ArrayList<String> firstNames = new ArrayList<String>();
  ArrayList<String> lastNames  = new ArrayList<String>();
  for (TableRow row : names.rows()) {
    firstNames.add(row.getString(0));
    lastNames.add(row.getString(1));
  }


  // This section is a serious mess and needs to be, probably, completely redone.

  Table states = loadTable("states.csv", "header");// a table with states etc.
  //=== Senators ===//
  int partyCount = sBalance;
  int x = 0;
  for (TableRow row : states.rows()) {// Ok so everything about states is not an issue, keep these
    if (!row.getString(1).equals("DC")) {
      // Find name:

      // So this initializes congressmen, and it's actually also fine.
      String n = firstNames.remove((int)random(firstNames.size()))+" "+lastNames.remove((int)random(lastNames.size()));
      senate[x] = new Congressman(n, row.getString(1), 0);
      n = firstNames.remove((int)random(firstNames.size()))+" "+lastNames.remove((int)random(lastNames.size()));
      senate[x+1] = new Congressman(n, row.getString(1), 0);

      // how many democrats. Here's where it gets bad. This may be a teardown.

      // convertInt used below simply takes a string that is actually an int and turns it into an int, dw about that part
      int val = Utils.convertInt(row.getString(2));
      // val is an int from 0 to 5 inclusive that tells you how likely it is to be a dem (5 is very likely)
      //    ^    ^    ^    ^    ^    ^    ^    ^
      // The above is actually useful because it will tell you
      // how likely it is that it will be a democrat or republican, so don't delete it

      // ==================================================
      // This part sucks though, ugh

      // Liberalism and socialism (0 to 100 values for each) also need to be set, and you
      // can do that either separately or at the same time.
      // The method Congressman.setPolitics(int liberalism, int socialism, char party) works too
      int dems = Utils.findDems(val, random(5));
      if (dems == 0) {
        senate[x].party = 'R';
        senate[x+1].party = 'R';
        // how it works though is that it takes the amount given and sets the party accordingly
      }
      else if (dems == 1) {
        senate[x].party = 'R';
        senate[x+1].party = 'D';
      }
      else if (dems == 2) {
        senate[x].party = 'D';
        senate[x+1].party = 'D';
      }
      // Temporary
      //senate[x].party = 'R';
      //senate[x+1].party = 'D';
      if (dems > 0) {
        // see I started to set lib and soc but it failed sooo do that too
        //senate[x].setPolitics(
      }


      x+=2;
    }
  }

  // You may find this useful, it tests the code for senate
  int sum = 0;
  for (Congressman s : senate)
    if (s.party == 'D')
      sum++;
      println("Democrats in Senate: "+sum+"/"+senate.length);


  //=== Representatives ===//

  // After the failure of Senate stacking, I didn't even try. They simply start with names.

  // === Names === //
  x = 0;
  for (TableRow row : states.rows()) {
    if (!row.getString(1).equals("DC")) {
      for (int i = 0; i < Utils.convertInt(row.getString(3)); i++) {
        String n = firstNames.remove((int)random(firstNames.size()))+" "+lastNames.remove((int)random(lastNames.size()));
        house[x] = new Congressman(n, row.getString(1), 0);
        house[x].party = 'D';
        x++;
      }
    }
  }

  /*
  Here you can write the code for stacking the house. It's a little more difficult
  because each state has a different number of representatives. So you can take some aspects
  of what you write for Senate and put it here, but be sure to edit carefully to take into account.
  */

  // This is the end of the above mess. This is eventually necessary to fix because it's terrible...

  //for (int i = 0; i < house.length; i++) // idk what this is lol
  //  println(i + ": " + house[i].name + " (" + house[i].state + ")");
}





//================================
//========= Controls =============
//================================

void mouseClicked() {
  /* What to do when the mouse is clicked */
  float mX = mouseX;
  float mY = mouseY;

  // Clicking buttons:
  textSize(16);
  // If the main menu is selected
  float wordWidth = textWidth("Main Menu")/2;
  if (mX < width/10+10+wordWidth && mX > width/10+10-wordWidth && mY < height/10+46 && mY > height/10-15)
    screen.setScreen(0);

  // ===== Buttons =====
  if (screen.buttons != null) {
    boolean done = false;
    for (int i = 0; i < screen.buttons.length && !done; i++)
      if (screen.buttons[i].isInside(mX, mY) && screen.buttons[i].visible && screen.buttons[i].clickable) {
        done = true;
        screen.extra = screen.buttons[i].extra;
        screen.setScreen(screen.buttons[i].command);
      }
  }

  //=======================================================
  //=======================================================
  // This section deals with when there is a calendar up and when
  // the buttons to change what month is shown are selected.
  if (screen.currScreen == 7) {
    textSize(20);
    if (mY > height/6-70 && mY < height/6-50) {
      if (mX < width/2-40 && mX > width/2-40-textWidth("<   September 2020"))
        calendar.changeMonth(-1);
      else if (mX > width/2-40 && mX < width/2-40+textWidth("September 2020   >"))
        calendar.changeMonth(1);
    }
  }
  //=======================================================
  //=======================================================
  else if (screen.currScreen == 10 || screen.currScreen == 11) {
    // This is complicated but basically for when an item of a list in the screen
    // where a speech is being built is selected. It changes the appearance of
    // the specific buttons that are associated.
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
      }
      else if (mX < width/2-40) {
        if (screen.d1.size() > 0 && mY > height/2+65 && mY < height/2+90) {
          screen.chosen = 1;
          screen.buttons[1].setLabel("Remove", 14, 255);
          screen.buttons[1].clickable = true;
        }
        else if (screen.d1.size() > 1 && mY > height/2+90 && mY < height/2+115) {
          screen.chosen = 2;
          screen.buttons[1].setLabel("Remove", 14, 255);
          screen.buttons[1].clickable = true;
        }
      }
      else if (mX > width/2+40) {
        if (screen.d2.size() > 0 && mY > height/2+65 && mY < height/2+90) {
          screen.chosen = 3;
          screen.buttons[2].setLabel("Remove", 14, 255);
          screen.buttons[2].clickable = true;
        }
        else if (screen.d1.size() > 1 && mY > height/2+90 && mY < height/2+115) {
          screen.chosen = 4;
          screen.buttons[2].setLabel("Remove", 14, 255);
          screen.buttons[2].clickable = true;
        }
      }
    }
  }
  //=======================================================
  //=======================================================
  else if (screen.currScreen == 13) {
    // it selects what you click on in the list for Screen 13
    if (mX > width/6 && mX < width*5/6) {
      if (mY > height/6 && mY < height*5/6) {
        for (int i = 0; i < screen.search.size(); i++)
          if (mY > height/6+24*i+screen.scrollX && mY < height/6+24*i+screen.scrollX+24) {
            screen.chosen = i;
          }
      }
    }
  }
  //=======================================================
  else if (screen.currScreen == 16) {
    // This deals with selection from a list in a different screen,
    // I don't know which one, it's easy to check. It's Screen 16
    // rect(width/6, height/6+24*x+scrollX, width*4/6, 20);
    if (mX > width/6 && mX < width*5/6) {
      if (mX > height/6 && mY < height*5/6) {
        int x = 0;
        for (int i = 0; i < house.length; i++) {
          if (house[i].committee == tempBill.committee) {
            if (mY > height/6+24*x+screen.scrollX && mY < height/6+24*x+screen.scrollX+24)
              screen.chosen = x;
            x++;
          }
        }
      }
    }
  }
  //=======================================================
  else if (screen.currScreen == 18) {
    // Same as the above, but with Screen 18
    if (mX > width/6 && mX < width*5/6) {
      if (mY > height/6 && mY < height/2) {
        for (int i = 0; i < screen.depIdeas.size(); i++)
          if (mY > height/6+24*i+screen.scrollX && mY < height/6+24*i+screen.scrollX+24) {
            screen.chosen = i+3;
            screen.buttons[1].setLabel("Add", 14, 255);
            screen.buttons[1].clickable = true;
          }
      }
      else if (tempBill.ideas[0] != -1 && mY > height-208 && mY < height-174) {
        screen.chosen = 1;
        screen.buttons[1].setLabel("Remove", 14, 255);
        screen.buttons[1].clickable = true;
      }
      else if (tempBill.ideas[1] != -1 && mY > height-174 && mY < height-140) {
        screen.chosen = 2;
        screen.buttons[1].setLabel("Remove", 14, 255);
        screen.buttons[1].clickable = true;
      }
    }
  }
  //=======================================================
  // Ditto, Screen 20
  else if (screen.currScreen == 20) {
    if (mX > width/6 && mX < width*5/6) {
      if (mY > height/6 && mY < height-181) {
        for (int i = 0; i < screen.depIdeas.size(); i++)
          if (mY > height/6+24*i+screen.scrollX && mY < height/6+24*i+screen.scrollX+24) {
            screen.chosen = i+2;
            screen.buttons[1].setLabel("Add", 14, 255);
            screen.buttons[1].clickable = true;
          }
      }
      else if (tempBill.ideas[2] != -1 && mY > height-174 && mY < height-140) {
        screen.chosen = 1;
        screen.buttons[1].setLabel("Remove", 14, 255);
        screen.buttons[1].clickable = true;
      }
    }
  }
  //=======================================================
  else if (screen.currScreen == 23) {
    if (mX > width/6 && mX < width/6+max(wordWidths(themActions, 15)) {
      if (mY > height/6 && mY < height*5/6) {
        //for (int i = 0; i < screen.)
      }
    }

  }
}
void mousePressed() {
  // This is necessary for sliders, it's when the mouse is pressed and not released
  // ====== Sliders ======
  if (screen.sliders != null) {
    for (int i = 0; i < screen.sliders.length; i++)
      if (screen.sliders[i].isInside(mouseX, mouseY) && screen.sliders[i].visible)
        currSlider = screen.sliders[i];
  }

}
void mouseReleased() {
  // Speaks for itself, sets currSlider to null
  currSlider = null;
}
void mouseDragged() {
  // If the mouse is held down and moved
  if (currSlider != null) {
    currSlider.value = (int)constrain(((
      mouseX+currSlider.boxSize/2-currSlider.x)*currSlider.maxVal/currSlider.len), 0, currSlider.maxVal);
  }
}

void mouseWheel(MouseEvent event) {
  // When the mouse is scrolled. Very useful for replacing the arrow keys
  float e = event.getCount();
  if (screen.currScreen == 10 || screen.currScreen == 11 || screen.currScreen == 13 || screen.currScreen == 16 || screen.currScreen == 18) {
    if (e > 0 && screen.scrollX != 0)
      screen.scrollX += 20;
    else if (e < 0)
      screen.scrollX -= 20;
  }
}


void keyPressed() {
  // In the event that a key is pressed

  // ======================================
  // === Cases where the user is typing ===
  // ======================================
  if (screen.currScreen == 21) {
    if (keyCode == BACKSPACE) {
      // How to delete off of a name, useful for a lot of other things
      if (tempBill.name.length() != 0)
        tempBill.name = tempBill.name.substring(0, tempBill.name.length()-1);
    }

    else if (keyCode != ENTER && keyCode != SHIFT)
      // Typing, avoiding some keys that are not part of this
      tempBill.name += key;
    //========
  }
  if (screen.currScreen == 13) {
    if (keyCode == BACKSPACE) {
      if (screen.input.length() != 0)
        screen.input = screen.input.substring(0, screen.input.length()-1);
    }

    else if (keyCode != ENTER && keyCode != SHIFT && keyCode != UP && keyCode != DOWN)
      screen.input += key;
  }

  // All cases where the arrow keys are used to scroll through a list
  if( screen.currScreen == 10
    || screen.currScreen == 11
    || screen.currScreen == 13
    || screen.currScreen == 16
    || screen.currScreen == 18 ) {
    if (keyCode == UP && screen.scrollX != 0)
      screen.scrollX += 20;
    else if (keyCode == DOWN)// scrollX,
      screen.scrollX -= 20;
  }

  if (keyCode == ESC) {// this is really cool :D
    key = 0;// making sure it doesnt quit
    screen.setScreen(0);
  }
  if (key == 'q') {
  // this is temp but it enables a quit method in the future
  // Probably will link with the menu somehow (like if a button is pressed, key = 27)
    key = 27;// This is the escape key.
  }
}

//===================================================//
//===================================================//
//=============== Next Turn Method ==================//
//===================================================//
//===================================================//

void nextTurn() {
  /* This method progresses the game by setting up the next turn.

  */
  turn++;

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
  // React to speeches
  for (int i = 0; i < senate.length; i++)
    senate[i].listenToSpeech(suppS, agS);
  for (int i = 0; i < house.length; i++)
    house[i].listenToSpeech(suppH, agH);

  suppH = new ArrayList<Integer>();
  suppS = new ArrayList<Integer>();
  agH = new ArrayList<Integer>();
  agS = new ArrayList<Integer>();

  // This is the beginnign of code that changes the status of bills
  //  for (int i = 0; i < bills.length; i++) {
  //    if (bills.get(i).status == 1 || bills.get(i).status == 2)

 //   }





}
