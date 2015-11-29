// Globals:
// this is good:
// https://www.whitehouse.gov/briefing-room/signed-legislation

String name;
String presParty;

Screen screen;
Calendar calendar;
FedBudget fedBudget;
Ideas ideas;

NationalCom you;
NationalCom them;

int turn;

int approval;
boolean houseSpeech;
boolean senateSpeech;
ArrayList<Bill> bills;
ArrayList<Bill> laws;
Congressman[] house;
Congressman[] senate;
Secretary[] cabinet;
SCJustice[] scotus;

int sBalance;// percent// what is this
int hBalance;// percent

Bill tempBill;
Slider currSlider;

// Images
ElectoralMap eM;


// Deals
int[] mustSpeakFor;//made a deal to vote for these
int[] mustSpeakAgainst;//made a deal to vote against these

ArrayList<Integer> suppS;
ArrayList<Integer> agS;
ArrayList<Integer> suppH;
ArrayList<Integer> agH;

void setup() {
  int wid = displayWidth;
  int hei = (int)(displayHeight*.8);
  size(displayWidth, displayHeight);//640);// 640 is temp bc processing 3 sucks a bit
  println(wid+","+hei);

  turn = 0;

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

    // -========================-
  laws = new ArrayList<Bill>();
  house = new Congressman[435];
  senate = new Congressman[100];
  scotus = new SCJustice[9];

  // stack the courts here //

  cabinet = new Secretary[15];
  Table d = loadTable("majordepartments.csv", "header");
  for (int i = 0; i < cabinet.length; i++)
    cabinet[i] = new Secretary(d.getRow(i).getString(0), d.getRow(i).getString(1));

  // This will be decided in beginning so for now has default
  sBalance = 55;
  hBalance = 55;

  // loading images
  eM = new ElectoralMap();

  approval = 50;

  createCongress();
  bills = new ArrayList<Bill>();
  // This is temporary
  for (int i = 0; i < 5; i++) {
    bills.add(new Bill());
    bills.get(i).name = "Bill "+(i+1);
    bills.get(i).committee = i;
    bills.get(i).status = (int)random(5);
    bills.get(i).addOpinions();
  }

  suppH = new ArrayList<Integer>();
  suppS = new ArrayList<Integer>();
  agH = new ArrayList<Integer>();
  agS = new ArrayList<Integer>();

  background(50, 125, 250);
}


void draw() {
  screen.display();
  topBar();
  if (screen.currScreen != 0)
    mainButton();
  if (screen.buttons != null)
    for (int i = 0; i < screen.buttons.length; i++) {
      if (screen.buttons[i].isInside(mouseX, mouseY))
        screen.buttons[i].scrolled = true;
      else
        screen.buttons[i].scrolled = false;
    }
}

void topBar() {// Turn # | Date | Approval Rating | Turns until next election
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
  strokeWeight(5);
  line(width/10, height/10, width/10+20, height/10-15);
  line(width/10, height/10, width/10+20, height/10+15);
  strokeWeight(1);
  textSize(16);
  textAlign(CENTER, TOP);
  fill(0);
  text("Main Menu", width/10+10, height/10+30);
}
// Names them, gives parties, gives states, gives districts, gives approvals, gives election cycle \\
void createCongress() {
  //=== Names ===//
  Table names = loadTable("names.csv", "header");
  ArrayList<String> firstNames = new ArrayList<String>();
  ArrayList<String> lastNames  = new ArrayList<String>();
  for (TableRow row : names.rows()) {
    firstNames.add(row.getString(0));
    lastNames.add(row.getString(1));
  }

  Table states = loadTable("states.csv", "header");
  //=== Senators ===//
  int partyCount = sBalance;
  int x = 0;
  for (TableRow row : states.rows()) {
    if (!row.getString(1).equals("DC")) {
      // Find name:
      String n = firstNames.remove((int)random(firstNames.size()))+" "+lastNames.remove((int)random(lastNames.size()));
      senate[x] = new Congressman(n, row.getString(1), 0);
      n = firstNames.remove((int)random(firstNames.size()))+" "+lastNames.remove((int)random(lastNames.size()));
      senate[x+1] = new Congressman(n, row.getString(1), 0);

      //how many democrats
      int val = Utils.convertInt(row.getString(2));
      int dems = Utils.findDems(val, random(5));
      if (dems == 0) {
        senate[x].party = 'R';
        senate[x+1].party = 'R';
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
        //senate[x].setPolitics(
      }


      x+=2;
    }
  }
  int sum = 0;
  for (Congressman s : senate)
    if (s.party == 'D')
      sum++;
      println("Democrats: "+sum+"/"+senate.length);
  //=== Representatives ===//
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
  //for (int i = 0; i < house.length; i++)
  //  println(i + ": " + house[i].name + " (" + house[i].state + ")");
}

//================================
//========= Controls =============
//================================

void mouseClicked() {
  float mX = mouseX;
  float mY = mouseY;

  // Clicking buttons:
  textSize(16);
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
  if (screen.currScreen == 10 || screen.currScreen == 11) {
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
  if (screen.currScreen == 16) {
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
  if (screen.currScreen == 18) {
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
  if (screen.currScreen == 20) {
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
}
void mousePressed() {
  // ====== Sliders ======
  if (screen.sliders != null) {
    for (int i = 0; i < screen.sliders.length; i++)
      if (screen.sliders[i].isInside(mouseX, mouseY) && screen.sliders[i].visible)
        currSlider = screen.sliders[i];
  }

}
void mouseReleased() {
  currSlider = null;
}
void mouseDragged() {
  if (currSlider != null) {
    currSlider.value = (int)constrain(((mouseX+currSlider.boxSize/2-currSlider.x)*currSlider.maxVal/currSlider.len), 0, currSlider.maxVal);
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (screen.currScreen == 10 || screen.currScreen == 11 || screen.currScreen == 13 || screen.currScreen == 16 || screen.currScreen == 18) {
    if (e > 0 && screen.scrollX != 0)
      screen.scrollX += 20;
    else if (e < 0)
      screen.scrollX -= 20;
  }
}


void keyPressed() {
  //println(screen.scrollX);
  if (screen.currScreen == 21) {
    if (keyCode == BACKSPACE) {
      if (tempBill.name.length() != 0)
        tempBill.name = tempBill.name.substring(0, tempBill.name.length()-1);
    }

    else if (keyCode != ENTER && keyCode != SHIFT)
      tempBill.name += key;
    //========
  }

  if (screen.currScreen == 10 || screen.currScreen == 11 || screen.currScreen == 13 || screen.currScreen == 16 || screen.currScreen == 18) {
    if (keyCode == UP && screen.scrollX != 0)
      screen.scrollX += 20;
    else if (keyCode == DOWN)// scrollX,
      screen.scrollX -= 20;
  }
  if (screen.currScreen == 13) {
    if (keyCode == BACKSPACE) {
      if (screen.input.length() != 0)
        screen.input = screen.input.substring(0, screen.input.length()-1);
    }

    else if (keyCode != ENTER && keyCode != SHIFT && keyCode != UP && keyCode != DOWN)
      screen.input += key;
  }

  if (keyCode == ESC) {// this doesnt currently work...
    key = 0;// making sure it doesnt quit
    screen.setScreen(0);
  }
  if (key == 'q') {// this is temp but it enables a quit method in the future
    key = 27;
  }
}

//===================================================//
//===================================================//
//=============== Next Turn Method ==================//
//===================================================//
//===================================================//

void nextTurn() {
  turn++;

  for (int i = 0; i < 7; i++) {// this decides how many days is one turn. I don't really know what it should be yet.
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
  //  for (int i = 0; i < bills.length; i++) {
  //    if (bills.get(i).status == 1 || bills.get(i).status == 2)

 //   }





}