import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class President extends PApplet {

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

public void setup() {
  int wid = displayWidth;
  int hei = (int)(displayHeight*.8f);
  size(displayWidth, 640);// 640 is temp bc processing 3 sucks a bit
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


public void draw() {
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

public void topBar() {// Turn # | Date | Approval Rating | Turns until next election
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

public void mainButton() {
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
public void createCongress() {
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

public void mouseClicked() {
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
public void mousePressed() {
  // ====== Sliders ======
  if (screen.sliders != null) {
    for (int i = 0; i < screen.sliders.length; i++)
      if (screen.sliders[i].isInside(mouseX, mouseY) && screen.sliders[i].visible)
        currSlider = screen.sliders[i];
  }

}
public void mouseReleased() {
  currSlider = null;
}
public void mouseDragged() {
  if (currSlider != null) {
    currSlider.value = (int)constrain(((mouseX+currSlider.boxSize/2-currSlider.x)*currSlider.maxVal/currSlider.len), 0, currSlider.maxVal);
  }
}



public void keyPressed() {
  //println(screen.scrollX);
  if (screen.currScreen == 21) {
    if (keyCode == BACKSPACE) {
      if (tempBill.name.length() != 0)
        tempBill.name = tempBill.name.substring(0, tempBill.name.length()-1);
    }

    else if (keyCode != ENTER)
      tempBill.name += key;
    //========
  }

  if (screen.currScreen == 10 || screen.currScreen == 11 || screen.currScreen == 13 || screen.currScreen == 16 || screen.currScreen == 18) {
    if (keyCode == UP && screen.scrollX != 0)
      screen.scrollX += 20;
    else if (keyCode == DOWN)
      screen.scrollX -= 20;
  }
  if (screen.currScreen == 13) {
    if (keyCode == BACKSPACE) {
      if (screen.input.length() != 0)
        screen.input = screen.input.substring(0, screen.input.length()-1);
    }

    else if (keyCode != ENTER && keyCode != UP && keyCode != DOWN)
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

public void nextTurn() {
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

public static void main() {
  draw();
}
class Agenda {
  ArrayList<Integer> events;
  ArrayList<Bill> billsChangedStatus;
  ArrayList<Bill> billsDenied;
  ArrayList<Integer> nationsSpoke;
  ArrayList<Integer> reminders;
  // Election details
  // Other election details
  ArrayList<Integer> scDecisions;
  ArrayList<Bill> billsOnDesk;
  
    /* Examples of news include:
       * How a speech went
       * Important events that happened and how you're going to treat them
       * Bills that went on floor this week
       * Bills that were denied this week
       * Nations that request a visit
       * When the next event is due (remember budget is soon, remember this goes into effect today
       * How your next election is going
       * How the next congressional election is going
       * Important Supreme Court cases coming up and recent decisions
       * Bills that you can sign or table
     */
  Agenda() {
    events = new ArrayList<Integer>();
    billsChangedStatus = new ArrayList<Bill>();
    billsDenied = new ArrayList<Bill>();
    nationsSpoke = new ArrayList<Integer>();
    reminders = new ArrayList<Integer>();
    scDecisions = new ArrayList<Integer>();
    billsOnDesk = new ArrayList<Bill>();
  }
  
  public void update() {
    // events haven't been done yet
    
    
  }
  
  
     
}
class Bill {
  int[] ideas;
  int[] percentages;// amount of force put on each one
  String name;
  int weeklyCost;
  int initialCost;
  int billNumber;
  int committee;
  Congressman broughtBy;
  boolean presBacked;// The president created this bill
  
  
  int status;//0: Committee, 1: House, 2: Senate, 3: Pres, 4: Veto, 5: Law
  int turnsHere;// committee gets infinite turns, house and senate 2 turns, pres 2 turns, veto 2 turns, law 0
  boolean isLaw;
  
  Bill() {
    ideas = new int[3];
    for (int i = 0; i < 3; i++)
      ideas[i] = -1;
    percentages = new int[3];
    for (int i = 0; i < percentages.length; i++)
      percentages[i] = 50;
    name = "Type name here";
    broughtBy = new Congressman("", "NY", 0);
  }
  
  public boolean contains(int idea) {
    for (int i = 0; i < 3; i++)
      if (ideas[i] == idea)
        return true;
    return false;
  }
  
  public boolean addIdea(int idea) {// returns if there was room in the bill for idea
    for (int i = 0; i < 3; i++)
      if (ideas[i] == -1 && !contains(idea)) {
        ideas[i] = idea;
        return true;
      }
    return false;
  }
  public boolean removeIdea(int idea) {
    if (ideas[0] == idea) {
      ideas[0] = ideas[1];
      ideas[1] = ideas[2];
      ideas[2] = -1;
      percentages[0] = percentages[1];
      percentages[1] = percentages[2];
      percentages[2] = 50;
    }
    else if (ideas[1] == idea) {
      ideas[1] = ideas[2];
      ideas[2] = -1;
      percentages[1] = percentages[2];
      percentages[2] = 50;
    }
    else if (ideas[2] == idea) {
      ideas[2] = -1;
      percentages[2] = 50;
    }
    else
      return false;
    return true;
  }
  
  public void addOpinions() {
    for (int i = 0; i < house.length; i++) {
      ArrayList<Integer> op = house[i].opinions;
      int initial = 100;
      initial -= pow(abs(house[i].socialism - avgSoc()), 2)*.005f;
      initial -= pow(abs(house[i].liberalism - avgLib()), 2)*.005f;
      op.add(initial);
      if (broughtBy.party == house[i].party)
        op.set(op.size()-1, op.get(op.size()-1)+(int)(25*house[i].loyalty*.01f));// 0 to 25
      else
        op.set(op.size()-1, op.get(op.size()-1)-(int)(25*house[i].loyalty*.01f));// 0 to 25
      
      if (presBacked)
        op.set(op.size()-1, op.get(op.size()-1)+(int)((house[i].youApproval-50)*.2f));// -10 to +10
      op.set(op.size()-1, constrain(op.get(op.size()-1), 0, 100));
    }
    for (int i = 0; i < senate.length; i++) {
      ArrayList<Integer> op = senate[i].opinions;
      int initial = 100;
      initial -= pow(abs(senate[i].socialism - avgSoc()), 2)*.005f;
      initial -= pow(abs(senate[i].liberalism - avgLib()), 2)*.005f;
      op.add(initial);
      if (broughtBy.party == senate[i].party)
        op.set(op.size()-1, op.get(op.size()-1)+(int)(25*senate[i].loyalty*.01f));// 0 to 25
      else
        op.set(op.size()-1, op.get(op.size()-1)-(int)(25*senate[i].loyalty*.01f));// 0 to 25
      
      if (presBacked)
        op.set(op.size()-1, op.get(op.size()-1)+(int)((senate[i].youApproval-50)*.2f));// -10 to +10
      op.set(op.size()-1, constrain(op.get(op.size()-1), 0, 100));
    }
  }
  
  public void sign() {
    status = 5;
    isLaw = true;
  }
  public float avgSoc() {
    int x = 100;// Temparary values, I just hate going into Ideas
    int y = 25;//
    int z = 75;// ===========
    x *= percentages[0];
    y *= percentages[1];
    z *= percentages[2];
    return (x+y+z)/percentages[0]+percentages[1]+percentages[2];
  }
  public float avgLib() {
    int x = 100;// Still also temp
    int y = 25;//
    int z = 75;// ===========
    x *= percentages[0];
    y *= percentages[1];
    z *= percentages[2];
    return (x+y+z)/percentages[0]+percentages[1]+percentages[2];
  }
}
class Button {
  int col;
  float x;
  float y;
  float w;
  float h;
  int command;
  int extra;
  boolean visible;
  boolean clickable;
  
  int variance;
  
  int scrollCol;
  boolean scrolled;
  
  String label;
  int lSize;
  int lCol;
  
  Button(float xV, float yV, float wV, float hV, int c, int s) {
    x = xV;
    y = yV;
    w = wV;
    h = hV;
    col = c;
    command = s;
    visible = true;
    clickable = true;
    lSize = 14;
  }
  public void setLabel(String l, int lS, int lC) {
    label = l;
    lSize = lS;
    lCol = lC;
  }
  
  public void display() {
    if (visible) {
      if (scrolled)
        fill(scrollCol);
      else
        fill(col);
      if (variance != 1) {
        rect(x, y, w, h, 5);
        textAlign(CENTER, CENTER);
      }
      else
        textAlign(LEFT, CENTER);
      fill(lCol);
      textSize(lSize);
      if (variance != 1)
        text(label, x+w/2, y+h/2);
      else
        text(label, x, y);
    }
  }
  
  public boolean isInside(float Mx, float My) {
    return Mx > x && Mx < x+w && My > y && My < y+h;
  }
}
String[] days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
int[] daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

class Calendar {
  int year;
  int month;
  
  int day;
  int cMonth;
  int cYear;
  
  Calendar() {
    year = cYear = 17;// year is the display year, cYear is game current year
    month = cMonth = 1;
    day = 22;
  }
  
  public void changeMonth(int direction) {
    if (direction < 0) {
      if (year != 17 || month != 1) {
        month--;
        if (month == 0) {
          month = 12;
          year--;
        }
      }
    }
    else {
      month++;
      if (month == 13) {
        month = 1;
        year++;
      }
    }
  }
  
  public void display() {
    fill(255);
    rect(width/6, height/6, width*2/3, height*2/3);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    for (int i = 1; i <= 6; i++)
      line(width/6, height/6+height*2/21*i, width*5/6, height/6+height*2/21*i);
    for (int i = 1; i <= 7; i++) {
      if (i != 7)
        line(width/6+width*2/21*i, height/6, width/6+width*2/21*i, height*5/6);
      text(days[i-1], width/6-width/21+width*2/21*i, height/6+height/21);
    }
    
    textAlign(RIGHT);
    String lMonth = "";
    String nMonth = "";
    int lYear, nYear;
    if (month == 1) {
      lMonth = "December";
      nMonth = "February";
      lYear = year-1;
      nYear = year;
    }
    else if (month == 12) {
      lMonth = "November";
      nMonth = "January";
      lYear = year;
      nYear = year+1;
    }
    else {
      lMonth = months[month-2];
      nMonth = months[month];
      lYear = nYear = year;
    }
    text("<   "+lMonth+" 20"+(lYear), width/2-40, height/6-50);
    textAlign(LEFT);
    text(nMonth+" 20"+(nYear)+"   >", width/2+40, height/6-50);
    int col = 0;
    int row = 0;
    int yearCount = 17;
    int monthCount = 1;
    int dayCount = 1;
    textAlign(CENTER, CENTER);
    text(months[month-1] + " 20"+year, width/2, height/6-25);
    while (yearCount != year || monthCount != month || dayCount < daysInMonth[month-1]) {
      if (yearCount == year && monthCount == month)
        text(dayCount, width/6+width/21+width*2/21*col, height/6+height*2/21+height/21+width/21*row);
        // ^ this needs to be cut down especially the 'y' part
      col++;
      if (col == 7) {
        row++;
        col = 0;
      }
      dayCount++;
      if (dayCount > daysInMonth[monthCount-1]) {
        dayCount = 1;
        monthCount++;
        row = 0;
        if (monthCount > 12) {
          monthCount = 1;
          yearCount++;
        }
      }
    }
    text(dayCount, width/6+width/21+width*2/21*col, height/6+height*2/21+height/21+width/21*row);
  }
  
  
}
class Congressman {
  String name;
  int socialism;// 0 capitalist, 100 socialist
  int liberalism;// 0 conservative, 100 liberal
  int approval;// home approval rating
  float youApproval;// approval of you
  int strength;// how they stand under pressure
  int loyalty;// party loyalty
  
  char party;// 'D' or 'R'
  String state;// "NY", "RI", "CA", "TN", "ME", etc.
  //int district;// 0 is senator
  int committee;// 15 is none
  int nextElection;// 2018 and every 2 years for all house reps, split in threes for senators
  int funding;// how much money they have for the next election
  int house;// 0 if house of reps, 1 if senate
  ArrayList<Integer> opinions;//each represents bill # index on the floor, less than 33 is nay, more than 66 is yea
  
  // Deal related
  ArrayList<Integer> mustVoteFor;//made a deal to vote for these
  ArrayList<Integer> mustVoteAgainst;//made a deal to vote against these
  boolean endorsed;
  boolean attackable;
  
  // Leaders are chosen after elections (democrats "caucus" republicans have a "conference")
  int leadership;// 0 is none, 1 is leader, 2 is whip, 3 is speaker. 1 and 2 have majority or minority and senate or house
  
  Congressman(String n, String s, int h) {
    name = n;
    state = s;
    house = h;
    committee = (int)random(16);
    opinions = new ArrayList<Integer>();
  }
  
  public void setPolitics(int s, int l, char p) {//, int d) {
    socialism = s;
    liberalism = l;
    party = p;
    //district = d;// I may not use district because of inaccuracies caused. Probably later
  }
  public void changeName(String n) { name = n; }
  
  public void setOpinion(int b) {
    
  }
  public void listenToSpeech(ArrayList<Integer> support, ArrayList<Integer> against) {
    /*  if you like the pres you like his bills
        if you don't like the pres you don't like his bills
        if you don't like his bills you like him less
        if you like his bills you like him more
    */
    if (support.size() > 0)
      opinions.set(support.get(0), (int)(opinions.get(support.get(0))+(youApproval-50)/2));
    if (support.size() > 1)
      opinions.set(support.get(1), (int)(opinions.get(support.get(1))+(youApproval-50)/2));
    if (against.size() > 0)
      opinions.set(against.get(0), (int)(opinions.get(against.get(0))-(youApproval-50)/2));
    if (against.size() > 1)
      opinions.set(against.get(1), (int)(opinions.get(against.get(1))-(youApproval-50)/2));
    
    if (support.size() > 0) {// if this.soc = 70 and bill.avgsoc = 100 it should start to go down
      youApproval -= pow(abs(socialism - bills.get(support.get(0)).avgSoc())*.01f, 2)*5-.45f;
      youApproval -= pow(abs(liberalism - bills.get(support.get(0)).avgLib())*.01f, 2)*5-.45f;
    }
    if (support.size() > 1) {
      youApproval -= pow(abs(socialism - bills.get(support.get(1)).avgSoc())*.01f, 2)*5-.45f;
      youApproval -= pow(abs(liberalism - bills.get(support.get(1)).avgLib())*.01f, 2)*5-.45f;
    }
    if (against.size() > 0) {
      youApproval += pow(abs(socialism - bills.get(against.get(0)).avgSoc())*.01f, 2)*5-.45f;
      youApproval += pow(abs(liberalism - bills.get(against.get(0)).avgLib())*.01f, 2)*5-.45f;
    }
    if (against.size() > 1) {
      youApproval += pow(abs(socialism - bills.get(against.get(1)).avgSoc())*.01f, 2)*5-.45f;
      youApproval += pow(abs(liberalism - bills.get(against.get(1)).avgLib())*.01f, 2)*5-.45f;
    }
  }
  
  public boolean vote(int b) {// true is yea, false is nay //
    int op = opinions.get(b);
    if (mustVoteFor.contains(b))// add strength (stronger people may resist)
      return true;
    else if (mustVoteAgainst.contains(b))
      return false;
      
    else if (op > 65) {// add strength to the equation
      if (random(op-64) > 1)
        return true;
      return false;
    }
    else if (op < 34) {
      if (random(35-op) > 1)
        return false;
      return true;
    }
    // I have to figure out the rest of it, it's going to be sort of random but how?? How to make it more random than before??
   // else if (op < 50) {
   //   if (random((51-op)/4) > 1)
   //     return false;
     if (random(2) < 1)
       return true;
     return false;
        
   }
  
}
class ElectoralMap {
  PImage map;
  
  ElectoralMap() {
    map = loadImage("electoralmap.jpg");
  }
  
  public void display() {
    image(map, 0, 30, width, height);
  }
}
class FedBudget {
  int income;// in billions
  int expense;// in billions
  int proposedExpense;
  float debtIntRate;// interest rate of the national debt
  boolean shutdown;// if there is a gov shutdown
  Table budget;
  int[] funding;
  int[] proposedFunding;
  
  FedBudget() {
    budget = loadTable("startingbudget.csv", "header");
    expense = 0;
    funding = new int[budget.getRowCount()];
    proposedFunding = new int[budget.getRowCount()];
    for (int i = 0; i < budget.getRowCount(); i++) {
      funding[i] = Utils.convertInt(budget.getRow(i).getString(1));
      proposedFunding[i] = Utils.convertInt(budget.getRow(i).getString(1));
    }
    for (TableRow row : budget.rows())
      expense += Utils.convertInt(row.getString(1));
  }
  
  /* I needed a place to put info on this and stuff, it's good to separate all of it.
     How it goes:
       - Pres submits a budget between first Monday of September and first Monday of February
       - Houses of Congress then suggest their own budgets and meet to create a budget resolution.
       - This bill goes to the President who signs or vetos. Veto leads to shutdown unless temp. deal is reached.
       - Appropriations bills happen occasionally and will be put in 'ideas', and military appropriations can only be yearly
       - Budget goes into effect October 1st, or gov shutdown.
  */
  public void updatePropExpense() {
    proposedExpense = 0;
    for (int i = 0; i < proposedFunding.length; i++)
      proposedExpense += proposedFunding[i];
  }
  
  
  
}
class Ideas {
  Table ideaTable;
  String[] names;
  
  Ideas() {
    ideaTable = loadTable("ideas.csv", "header");
    names = new String[ideaTable.getRowCount()];
    for (int i = 0; i < names.length; i++)
      names[i] = ideaTable.getRow(i).getString(0);
    //println(departmentNames(11));
    //println(loadTable("majordepartments.csv").getRow(11).getString(0));
  }
  
  public ArrayList<String> departmentNames(int d) {
    ArrayList<String> list = new ArrayList<String>();
    for (int i = 0; i < names.length; i++)
      if (Utils.convertInt(ideaTable.getRow(i).getString(1)) == d)
        list.add(names[i]);
    return list;
  }
  
  public int nameToInd(String s) {
    for (int i = 0; i < names.length; i++)
      if (names[i].equals(s))
        return i;
    return 0;
  }
}
class NationalCom {
  String party;
  int funds;//   in millions
  int presFunds;
  int[] statePresFunds;
  boolean administration;// if it's the president's party
  
  NationalCom(String p) {
    party = p;
    funds = 100;
    statePresFunds = new int[50];
  }
  
  public void display() {
    /*
      - statistics for after next election at this point
      - the congresspeople stacked in a table
        * name
        * state
        * district or 'sen.'
        * approval
        * polling (them-opponent)
        * funding
      - amount used for your campaign
      - avaliable funding
    */
    textAlign(CENTER, CENTER);
    textSize(16);
    text("Funds available for this year: ", width/2, 40);
    text("Funds reserved for your Presidential Campaign for this year: ", width/2, 60);
    /* needs to be split into something probably region:
        * New England: 
        * Southeast: 
        * Midwest: 
        * South: 
        * Southwest: 
        * Northwest: 
        * California: 
      
      */
    
  }
  
  public boolean isAdmin() {
    return administration;
  }
}
class SCJustice {
  String name;
  int socialism;// 0 capitalist, 100 socialist
  int liberalism;// 0 conservative, 100 liberal
  char party;
  boolean chief;
  
  SCJustice(int s, int l, char p) {
    socialism = s;
    liberalism = l;
    party = p;
  }
  
  
  
}
class Screen {
  /* Different Screens:
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
  int currScreen;
  int lastScreen;
  int lastButton;
  int extra;
  Button[] buttons;
  Slider[] sliders;
  int scrollX;
  int chosen;

  // Variables for specific instances
  ArrayList<String> depIdeas;
  ArrayList<Congressman> search;
  ArrayList<Integer> d1;
  ArrayList<Integer> d2;
  String input;
  String[] themActions = {" Support a bill (+)", " Denounce a bill (+)", " Vote for a bill (+)", " Vote against a bill (+)", " Endorse President"};
  String[] youActions = {"Support a bill (+) ", "Denounce a bill (+) ", "Sign a bill (+) ", "Veto a bill (+) ", "Promise funding ", "Endorse Congressperson "};

  // for a timer functionality
  int time;


  Screen() {
    setScreen(0);
    d1 = new ArrayList<Integer>();
    d2 = new ArrayList<Integer>();
  }


  public void setScreen(int c) {
    currScreen = c;
    if (currScreen == 0) {
      buttons = new Button[10];
      buttons[0] = new Button(width/2-320, height/2-110, 200, 60, color(255, 0, 0), 2);
      buttons[0].setLabel("Cabinet", 14, 255);
      buttons[1] = new Button(width/2-100, height/2-110, 200, 60, color(255, 0, 0), 3);
      buttons[1].setLabel("Congress", 14, 255);
      buttons[2] = new Button(width/2+120, height/2-110, 200, 60, color(255, 0, 0), 4);
      buttons[2].setLabel("International Treaties", 14, 255);
      buttons[3] = new Button(width/2-320, height/2-30, 200, 60, color(255, 0, 0), 5);
      buttons[3].setLabel(presParty+" National Committee", 12, 255);
      buttons[4] = new Button(width/2-100, height/2-30, 200, 60, color(255, 0, 0), 6);
      buttons[4].setLabel("United Nations Ambassador", 14, 255);
      buttons[5] = new Button(width/2+120, height/2-30, 200, 60, color(255, 0, 0), 7);
      buttons[5].setLabel("Calendar", 14, 255);
      buttons[6] = new Button(width/2-320, height/2+50, 200, 60, color(255, 0, 0), 1);
      buttons[6].setLabel("Statistics", 14, 255);
      buttons[7] = new Button(width/2-100, height/2+50, 200, 60, color(255, 0, 0), 8);
      buttons[7].setLabel("War Room", 14, 255);
      buttons[8] = new Button(width/2+120, height/2+50, 200, 60, color(255, 0, 0), 9);
      buttons[8].setLabel("Intellegence", 14, 255);
      for (int i = 0; i < buttons.length-1; i++)
        buttons[i].scrollCol = color(200, 0, 0);
      buttons[9] = new Button(width/2-100, height/2+130, 200, 60, color(0, 0, 255), 0);
      buttons[9].setLabel("Next Turn", 14, 255);
      buttons[9].scrollCol = color(0, 0, 200);
      buttons[9].extra = 1;

      // ============================
      // ==== Completing actions ====
      // ============================
      if (extra == 1) {// new turn
        nextTurn();
        setScreen(22);
      }
      else if (extra == 2) {// federal budget
        for (int i = 0; i < sliders.length; i++)
          fedBudget.proposedFunding[i] = sliders[i].value;
        fedBudget.updatePropExpense();
      }
      else if (extra == 3) {// new bill
        bills.add(tempBill);
        tempBill.addOpinions();
        tempBill = null;
      }
      else if (extra == 4) {// party budget

      }


      else if (extra == 10) {// speechwriting house
        suppH = d1;
        agH = d2;
      }
      else if (extra == 11) {// speechwriting senate
        suppS = d1;
        agS = d2;
      }
      // ============================
      // ============================

      sliders = null;
      extra = 0;
      chosen = 0;
    }

    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 1) {// Stats
      buttons = new Button[0];
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 2) {// Cabinet
      textSize(14);
      buttons = new Button[18];
      buttons[0] = new Button(width/2-100, height-100, 200, 60, color(255, 0, 0), 0);
      buttons[0].setLabel("See Bills", 14, 255);
      buttons[1] = new Button(width-textWidth("Sec. of Housing and Urban Dev.   ")-200, height-100, 200, 60, color(255, 0, 0), 2);
      buttons[1].setLabel("Next", 14, 255);
      buttons[1].extra = extra+1;
      if (extra == cabinet.length-1)
        buttons[1].visible = false;
      buttons[2]= new Button(width/6, height-100, 200, 60, color(255, 0, 0), 2);
      buttons[2].setLabel("Back", 14, 255);
      buttons[2].extra = extra-1;
      if (extra == 0)
        buttons[2].visible = false;

      for (int i = 3; i < buttons.length; i++) {
        buttons[i] = new Button(width+10-textWidth("Sec. of Housing and Urban Dev.   "), 40+(i-3)*30, textWidth(cabinet[i-3].title), 30, color(0, 0, 0), 2);
        buttons[i].setLabel(cabinet[i-3].title, 14, color(200, 0, 0));
        buttons[i].extra = i-3;
        buttons[i].variance = 1;
      }



      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
      /* How this will work:

       See some info from all 15 in boxes, and click on some to enlarge.
       Button for the current status of your bills
       Each may tell about issues that exist with their department and ways to fix them
       Each may ask for more funding


       */
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 3) {// Congress
      buttons = new Button[4];
      // Senate Speech, House Speech, New Bill
      buttons[0] = new Button(width/2-340, height/2+40, 300, 80, color(255, 0, 0), 10);
      buttons[0].setLabel("House of Representatives", 14, 255);
      buttons[1] = new Button(width/2+40, height/2+40, 300, 80, color(255, 0, 0), 11);
      buttons[1].setLabel("The Senate", 14, 255);
      buttons[2] = new Button(width/2-150, height/2-120, 300, 80, color(255, 0, 0), 12);
      buttons[2].setLabel("Introduce New Bill", 14, 255);
      buttons[3] = new Button(width/2-150, height/2+140, 300, 80, color(255, 0, 0), 13);
      buttons[3].setLabel("Talk to Legislators", 14, 255);
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
    }

    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 5) {// National Committee
      buttons = new Button[2];
      /* Will include:
       Control Funding
       2020 Election - will disappear sometimes
       */
      buttons[0] = new Button(width/2-150, height/2-100, 300, 80, color(255, 0, 0), 14);
      buttons[0].setLabel("Control Funding", 14, 255);
      buttons[1] = new Button(width/2-150, height/2, 300, 80, color(255, 0, 0), 17);
      buttons[1].setLabel("2020 Election", 14, 255);
      if (false)// too lazy
        buttons[1].visible = false;
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 6) {// UN
      buttons = new Button[3];
      buttons[0] = new Button(width/2-460, height/2-80, 300, 80, color(255, 0, 0), 25);
      buttons[0].setLabel("General Assembly Resolutions", 14, 255);
      buttons[1] = new Button(width/2-150, height/2-100, 300, 80, color(255, 0, 0), 26);
      buttons[1].setLabel("Security Council", 14, 255);
      buttons[2] = new Button(width/2+160, height/2-100, 300, 80, color(255, 0, 0), 27);
      buttons[2].setLabel("International Treaties", 14, 255);
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 7) {// Calendar
      buttons = new Button[0];
      calendar.year = calendar.cYear;
      calendar.month = calendar.cMonth;
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 8) {// war
      buttons = new Button[4];
      buttons[0] = new Button(width/6, height/2-100, width*5/24, 100, color(255, 0, 0), 0);
      buttons[0].setLabel("Army", 14, 255);
      buttons[1] = new Button(width/6, height/2-100, width*5/24, 100, color(255, 0, 0), 0);
      buttons[1].setLabel("Navy", 14, 255);
      buttons[2] = new Button(width/6, height/2-100, width*5/24, 100, color(255, 0, 0), 0);// 1/6
      buttons[2].setLabel("Marines", 14, 255);
      buttons[3] = new Button(width*5/6, height/2-100, width*5/24, 100, color(255, 0, 0), 0);
      buttons[3].setLabel("Advisors", 14, 255);


    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 10 || currScreen == 11) {//house or senate speech
      buttons = new Button[3];
      buttons[0] = new Button(width/2-150, height-100, 300, 80, color(255, 0, 0), 0);
      buttons[0].setLabel("Update Speech", 14, 255);
      buttons[0].extra = currScreen;

      buttons[1] = new Button(width/6, height/2+115, (width/3-40)/2, 50, color(0, 0, 255), 10);
      buttons[1].setLabel("", 14, 255);
      buttons[1].clickable = false;
      buttons[1].extra = 0;

      buttons[2] = new Button(width/2+40+(width/3-40)/2, height/2+115, (width/3-40)/2, 50, color(0, 0, 255), 10);
      buttons[2].setLabel("", 14, 255);
      buttons[2].clickable = false;
      buttons[2].extra = 1;

      if (chosen == 0) {
        if (currScreen == 10) {
          d1 = suppH;
          d2 = agH;
        }
        else if (currScreen == 11) {
          d1 = suppS;
          d2 = agS;
        }
      }
      else if (chosen < 3) {
        d1.remove(chosen-1);
        chosen = 0;
      }
      else if (chosen < 5) {
        d2.remove(chosen-3);
        chosen = 0;
      }
      else if (extra == 0) {
        if (d1.size() < 2) {
          d1.add(chosen-5);
          chosen = 0;
        }
      }
      else if (extra == 1) {
        if (d2.size() < 2) {
          d2.add(chosen-5);
          chosen = 0;
        }
      }

      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(0, 0, 200);
      buttons[0].scrollCol = color(200, 0, 0);
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 12) {// new bill step 1
      Table t = loadTable("majordepartments.csv", "header");
      buttons = new Button[16];
      int y = height/6+50;
      int x = 0;
      for (int i = 0; i < 15; i++) {
        buttons[i] = new Button(width/6+(width*2/3)*x++/3, y, width*2/9, 50, color(255, 0, 0), 18);
        buttons[i].setLabel(t.getRow(i).getString(0), 14, 255);
        buttons[i].extra = i;
        if (x == 3) {
          x = 0;
          y += 50;
        }
      }
      chosen = 0;
      buttons[15] = new Button(width/2-150, height/6+50*7, 300, 80, color(0, 0, 255), 15);
      buttons[15].setLabel("Submit a Budget Proposal", 14, 255);


      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
      buttons[15].scrollCol = color(0, 0, 200);
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 13) {// talk to legislators
      buttons = new Button[1];
      buttons[0] = new Button(width/2-150, height*5/6+10, 300, height/6-40, color(255, 0, 0), 23);
      buttons[0].setLabel("Create Deal", 14, 255);
      input = "";
    /*
      buttons = new Button[2];
      buttons[0] = new Button(width/2-320, height*5/6+20, 300, height/6-40, color(255, 0, 0), 0);
      buttons[0].setLabel("Suggest Deal", 14, 255);
      buttons[1] = new Button(width/2+20, height*5/6+20, 300, height/6-40, color(255, 0, 0), 0);
      buttons[1].setLabel("Speak to Party Members", 14, 255);
*/
/*  Things in this screen:
      * search bar for state, name, party that updates always
      * list of people that fit this ^
      * button on the bottom to automatically 'make deal' with each (link to next screen)
*/
      search = Utils.searchThrough(input, house, senate);
      input = "";
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 14) {// control funding
      buttons = new Button[2];
      buttons[0] = new Button(width/2-320, height*5/6+20, 300, height/6-40, color(255, 0, 0), 0);
      buttons[0].setLabel("Cancel", 14, 255);
      buttons[1] = new Button(width/2-320, height*5/6+20, 300, height/6-40, color(255, 0, 0), 0);
      buttons[1].setLabel("Update", 14, 255);
      buttons[1].extra = 4;

      sliders = new Slider[1];
      textSize(16);
      sliders[0] = new Slider(width/2+textWidth("Funds reserved for your Presidential Campaign for this year: 0 ")/2, 64, you.funds, 200);
      sliders[0].units = "Million";
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 15) {// budget policies
      buttons = new Button[2];
      buttons[0] = new Button(width/6, height*5/6+20, width/6-20, 60, color(255, 0, 0), 0);
      buttons[0].setLabel("Cancel", 14, 255);
      buttons[1] = new Button(width/3+20, height*5/6+20, width/6-20, 60, color(255, 0, 0), 0);
      buttons[1].setLabel("Update", 14, 255);
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
      buttons[1].extra = 2;
      sliders = new Slider[fedBudget.budget.getRowCount()];
      int y = height/6;
      int x = width/6;
      int half = (int)((height*2/3)/(fedBudget.budget.getRowCount()/2));
      for (int i = 0; i < sliders.length; i++) {// needs to give room for bottom
        if (y > height*5/6) {
          y = height/6;
          x = width/2;
        }
        int maxV = 2*Utils.convertInt(fedBudget.budget.getRow(i).getString(1));
        if (x == width/6)
          sliders[i] = new Slider(x+textWidth("Unemployment and Welfare")+5, y, maxV, width/2-textWidth("10000") - (width/6+textWidth("Unemployment and Welfare")+5));
        else
          sliders[i] = new Slider(x+textWidth("Environmental Protection Agency")+5, y, maxV, width*5/6 - (width/2+textWidth("Environmental Protection Agency")+5));
        sliders[i].value = fedBudget.proposedFunding[i];
        y += half;
      }
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 16) {// find representative for bill
      buttons = new Button[1];
      buttons[0] = new Button(width/2-100, height*5/6+20, 200, 60, color(255, 0, 0), 21);
      buttons[0].setLabel("Propose Bill", 14, 255);

      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);

      chosen = 0;
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 17) {// electoral map
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 18) {// New Bill step 2
      buttons = new Button[2];
      buttons[0] = new Button(width/6, height-80, 300, 60, color(255, 0, 0), 19);
      buttons[0].setLabel("Find a Rider for Bill", 14, 255);
      buttons[1] = new Button(width/6, height-140, 150, 60, color(255, 0, 0), 18);
      buttons[1].setLabel("", 14, 255);
      buttons[1].extra = extra;
      buttons[1].clickable = false;
      scrollX = 0;

      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);

      sliders = new Slider[2];

      sliders[0] = new Slider(width*5/6-(210+textWidth("100")), height-191, 100, 200);
      sliders[1] = new Slider(width*5/6-(210+textWidth("100")), height-157, 100, 200);

      depIdeas = ideas.departmentNames(extra);
      if (chosen == 0) {
        tempBill = new Bill();
        tempBill.committee = extra;
        tempBill.presBacked = true;
      } else if (chosen < 3) {
        tempBill.removeIdea(tempBill.ideas[chosen-1]);
        chosen = 0;
      } else {
        tempBill.addIdea(ideas.nameToInd(depIdeas.get(chosen-3)));
        chosen = 0;
      }
      for (int i = 0; i < sliders.length; i++) {
        sliders[i].value = tempBill.percentages[i];
        if (tempBill != null && tempBill.ideas[i] == -1)
          sliders[i].visible = false;
      }
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 19) {// New Bill step 3
      Table t = loadTable("majordepartments.csv", "header");
      buttons = new Button[15];
      int y = height/6+50;
      int x = 0;
      for (int i = 0; i < 15; i++) {
        buttons[i] = new Button(width/6+(width*2/3)*x++/3, y, width*2/9, 50, color(255, 0, 0), 20);
        buttons[i].setLabel(t.getRow(i).getString(0), 14, 255);
        buttons[i].extra = i;
        if (x == 3) {
          x = 0;
          y += 50;
        }
      }
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 20) {// New Bill step 4
      buttons = new Button[2];
      buttons[0] = new Button(width/6, height-80, 300, 60, color(255, 0, 0), 16);
      buttons[0].setLabel("Find a Rep. for Bill", 14, 255);
      buttons[1] = new Button(width/6, height-140, 150, 60, color(255, 0, 0), 20);
      buttons[1].setLabel("", 14, 255);
      buttons[1].extra = extra;
      buttons[1].clickable = false;
      scrollX = 0;

      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);

      depIdeas = ideas.departmentNames(extra);
      if (chosen == 0) {
      } else if (chosen == 1) {
        tempBill.removeIdea(tempBill.ideas[2]);
        chosen = 0;
      } else {
        tempBill.addIdea(ideas.nameToInd(depIdeas.get(chosen-2)));
        chosen = 0;
      }

      sliders = new Slider[1];

      sliders[0] = new Slider(width*5/6-(210+textWidth("100")), height-157, 100, 200);
      sliders[0].value = tempBill.percentages[2];
      if (tempBill != null && tempBill.ideas[2] == -1)
        sliders[0].visible = false;
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 21) {// Finish bill
      buttons = new Button[2];
      buttons[0] = new Button(width/2-210, height*5/6+20, 200, 60, color(255, 0, 0), 0);
      buttons[0].setLabel("Cancel", 14, 255);
      buttons[1] = new Button(width/2+10, height*5/6+20, 200, 60, color(255, 0, 0), 0);
      buttons[1].setLabel("Propose Bill", 14, 255);
      buttons[1].extra = 3;

      int x = 0;
      for (int i = 0; i < house.length; i++) {
        if (house[i].committee == tempBill.committee) {
          if (x == chosen)
            tempBill.broughtBy = house[i];
          x++;
        }
      }

      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 22) {// Show agenda:
    	 buttons = new Button[0];
    /* Examples of news include:
       * Important events that happened and how you're going to treat them
       * Bills that went on floor this week
       * Bills that were denied this week
       * Nations that request a visit
       * When the next thing is due
       * How your next election is going
       * How the next congressional election is going
       * Important Supreme Court cases coming up and recent decisions
       * Bills that you can sign or table
     */



    }

    else if (currScreen == 23) {// legislative deals (with multiple people)
      buttons = new Button[3];
      buttons[0] = new Button(width/2-100, height*5/6, 200, 60, color(255, 0, 0), 24);
      buttons[0].setLabel("Suggest Deal", 14, 255);
      buttons[1] = new Button(width/6, height/2+115, (width/3-40)/2, 50, color(0, 0, 255), 10);
      buttons[1].setLabel("", 14, 255);
      buttons[1].clickable = false;
      buttons[1].extra = 0;

      buttons[2] = new Button(width/2+40+(width/3-40)/2, height/2+115, (width/3-40)/2, 50, color(0, 0, 255), 10);
      buttons[2].setLabel("", 14, 255);
      buttons[2].clickable = false;
      buttons[2].extra = 1;

    }
  }





  public void display() {
    background(50, 125, 250);
    fill(0);
    //============================
    if (currScreen == 0) {
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }
    if (currScreen == 1) {
      if (extra == 3) {
         textSize(30);
         textAlign(CENTER, TOP);
         text("Your Bill was successfully submitted to the House of Representatives", width/2, height/6);
      }
    for (int i = 0; i < buttons.length; i++)
      buttons[i].display();
    }
    if (currScreen == 2) {
      fill(255);
      textSize(14);
      float end = width*5/6-textWidth("Sec. of Housing and Urban Dev.   ");
      rect(width/6, 40, min(width*2/3, end), height-150);

      fill(0);
      textSize(20);
      textAlign(CENTER, CENTER);
      text(cabinet[extra].title, width/2, 55);
      // shows: bills through this department, amount of funding, is the funding too much or little, statistics that can be fixed through this dept.
      // ========================================================== //
      // ========================================================== //
      textAlign(LEFT, TOP);
      textSize(20);
      // budget:
      text("This department's budget: $"+cabinet[extra].funding+" Billion", width/6, 70);
      line(width/6, 95, width/6+end, 95);
      //bills:
      textSize(24);
      text("Current Bills in Congress for this department:", width/6, 100);
      textSize(18);
      int y = 130;
      for (int i = 0; i < bills.size(); i++) {
        Bill bill = bills.get(i);
        if (bill.committee == extra) {
          String mes = " \u2022 Bill #"+bill.billNumber+": "+bill.name+" (";
          if (bill.status == 0)
            mes += "in committee";
          else if (bill.status == 1)
            mes += "in the House";
          else if (bill.status == 2)
            mes += "in the Senate";
          else if (bill.status == 3)
            mes += "on your desk";
          else if (bill.status == 4)
            mes += "awaiting veto override";
          mes += ")";
          text(mes, width/6, y);
          y += 20;
        }
      }


     /*  THIS IS CODE FOR A GRID WHICH WAS BAD BUT JUST IN CASE IT'S HERE

      line(width/6+width*2/9, 40, width/6+width*2/9, height-110);
      line(width/6+width*4/9, 40, width/6+width*4/9, height-110);
      for(int i = 1; i < 5; i++)
      line(width/6, 40+(height-150)*i/5, width*5/6, 40+(height-150)*i/5);
      */


      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }

    if (currScreen == 3) {
      textAlign(CENTER, CENTER);
      textSize(16);
      text("Or Make A Speech To...", width/2, height/2);
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }

    if (currScreen == 5) {
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }

    if (currScreen == 7) {
      calendar.display();
    }

    if (currScreen == 10) {
      textAlign(CENTER, CENTER);
      textSize(20);
      text("Bills on the House floor:", width/2, height/6-20);
    }

    if (currScreen == 11) {
      textAlign(CENTER, CENTER);
      textSize(20);
      text("Bills on the Senate floor:", width/2, height/6-20);
    }

    if (currScreen == 10 || currScreen == 11) {
      fill(255);
      rect(width/6, height/6, width*2/3, height/3);// all bills
      textAlign(LEFT, TOP);
      fill(0);
      for (int i = 0; i < bills.size(); i++) {// 0 is none, 1-2 is support, 3-4 is criticize, so 5 is the first
        if (height/6+24*i+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6) {
          if (i == chosen-5) {
            fill(0, 0, 100);
            rect(width/6, height/6+24*i+scrollX, width*4/6, 24);
            fill(0);
          }
          text(bills.get(i).name, width/6+5, height/6+24*i+scrollX);
        }
        if (height/6+24*(i+1)+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6)
          line(width/6, height/6+24*(i+1)+scrollX, width*5/6, height/6+24*(i+1)+scrollX);
      }
      fill(255);
      textAlign(CENTER, CENTER);
      rect(width/6, height/2+65, width/3-40, 50);// to support
      rect(width/2+40, height/2+65, width/3-40, 50);// to criticize
      fill(0);
      text("Bills to Support", width/4, height/2+45);
      text("Bills to Criticize", width*3/4, height/2+45);
      line(width/6, height/2+90, width/2-40, height/2+90);
      line(width/2+40, height/2+90, width*5/6, height/2+90);
      textAlign(LEFT, TOP);
      if (d1.size() > 0) {
        text(d1.get(0), width/6, height/2+65);
        if (chosen == 1) {
          fill(0, 0, 100);
          rect(width/6, height/2+65, width/3-40, 25);
          fill(0);
        }
      }
      if (d1.size() > 1) {
        text(d1.get(1), width/6, height/2+90);
        if (chosen == 2) {
          fill(0, 0, 100);
          rect(width/6, height/2+90, width/3-40, 25);
          fill(0);
        }
      }
      if (d2.size() > 0) {
        text(d2.get(0), width/2+40, height/2+65);
        if (chosen == 3) {
          fill(0, 0, 100);
          rect(width/2+40, height/2+65, width/3-40, 25);
          fill(0);
        }
      }
      if (d2.size() > 1) {
        text(d2.get(1), width/2+40, height/2+90);
        if (chosen == 4) {
          fill(0, 0, 100);
          rect(width/2+40, height/2+90, width/3-40, 25);
          fill(0);
        }
      }

      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }

    if (currScreen == 12) {
      textSize(30);
      textAlign(CENTER, CENTER);
      text("Find a department for most of the bill", width/2, height/6+25);
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }

    if (currScreen == 13) {
      // search bar for state, name, party, position
      textAlign(CENTER, TOP);
      textSize(20);
      text("Make private deals with groups or individuals in Congress", width/2, 35);
      textAlign(LEFT, TOP);
      float w = textWidth("Search by state, name, party, or position:")+5;
      fill(0);
      text("Search by state, name, party, or position:", width/6, 65);
      fill(255);
      rect(width/6+w, 62, width*2/3-w, 26);
      fill(0);
      text(input, width/6+w, 65);

      if ((millis()/1000)%2 == 0)
        line(width/6+w+textWidth(input)+1, 65, width/6+w+textWidth(input)+1, 65+20);
      fill(255);
      rect(width/6, height/6, width*2/3, height*2/3);//Congressmen
      fill(0);
      textAlign(CENTER, TOP);
      textSize(20);
      text("Congressmen:", width/2, height/6-30);
      /* Needs to show:
         - state/party
         - you approval
         - approval
      */

      ArrayList<Congressman> list = Utils.searchThrough(input, house, senate);
      textAlign(LEFT, TOP);
      for (int i = 0; i < list.size(); i++) {
        if (height/6+24*i+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6) {
          if (i == chosen) {
            fill(0, 0, 100);
            rect(width/6, height/6+24*i+scrollX, width*4/6, 24);
            fill(0);
          }
          text("Sen. "+list.get(i).name+"  ("+list.get(i).party+", "+list.get(i).state+")", width/6+5, height/6+24*i+scrollX);
        }
        if (height/6+24*(i+1)+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6)
          line(width/6, height/6+24*(i+1)+scrollX, width*5/6, height/6+24*(i+1)+scrollX);
      }

      //===============================================================================
      //===============================================================================
      // This is the code that represents one scroll bar. The directions for what to do
      // are in the github issue. Use listLength and space.
      fill(50, 125, 250);
      float listLength = max(1, 24*list.size());// size of the list in pixels. List.size() is # of items
      float space = height*2/3;// Space that the text area takes up.
      if (space < listLength) {
        float scrollLength = space/listLength;
        rect(width*5/6, height/6-scrollX*space/listLength, 10, scrollLength, 5);// This is the problem line.
      }
      //===============================================================================
      //===============================================================================
      //===============================================================================


      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }

    if (currScreen == 14) {
      you.display();

      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
      for (int i = 0; i < sliders.length; i++)
        sliders[i].display();
    }

    if (currScreen == 15) {
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(25);

      if (calendar.cMonth == 1) {
        text("Federal Budget Proposal For Fiscal Year 20"+calendar.cYear, width/2, 40);
        /* the sliders will increase the spending for each, and then it overflows the total spending. Other things must
        be lowered before submitting, or the total spending can be raised
        */
        int y = height/6;
        int x = width/6;
        int i = 0;
        int half = (int)((height*2/3)/(fedBudget.budget.getRowCount()/2));
        while (i < fedBudget.budget.getRowCount()) {// needs to give room for bottom
          if (y > height*5/6) {
            y = height/6;
            x = width/2;
          }
          textAlign(LEFT, CENTER);
          textSize(half/2);
          String name = fedBudget.budget.getRow(i).getString(0);
          text(name, x, y);
          sliders[i].display();
          y += half;
          i++;
        }
        y -= half;
        textSize((height-y)/3-20);
        textAlign(LEFT, TOP);
        fedBudget.updatePropExpense();
        text("Total Proposed Expense: " + fedBudget.proposedExpense, width/2+20, y+10);
        text("Projected Income Through Tax: " + fedBudget.income, width/2+20, y+(height-y)/3);
        text("Projected Deficit: ", width/2+20, y+(height-y)*2/3-10);
      }
      else {
        text(" ", width/2, 40);
      }
      strokeWeight(0);
    }

    if (currScreen == 16) {// find rep for bill
      fill(255);
      rect(width/6, height/6, width*2/3, height*4/6);//Congressmen
      fill(0);
      textAlign(LEFT, TOP);
      int x = 0;
      for (int i = 0; i < house.length; i++) {
        if (house[i].committee == tempBill.committee) {
          if (height/6+24*x+scrollX >= height/6 && height/6+24*(x+1)+scrollX <= height*5/6) {
            if (x == chosen) {
              fill(0, 0, 100);
              rect(width/6, height/6+24*x+scrollX, width*4/6, 24);
              fill(0);
            }
            text("Rep. "+house[i].name+"  ("+house[i].state+")", width/6+5, height/6+24*x+scrollX);
          }
          if (height/6+24*(x+1)+scrollX >= height/6 && height/6+24*(x+1)+scrollX <= height*5/6)
            line(width/6, height/6+24*(x+1)+scrollX, width*5/6, height/6+24*(x+1)+scrollX);
            x++;
        }
      }
      fill(50, 125, 250);
      int listLength = 24*house.length;
      int space = height*2/3+25;// This was a good attempt but needs to be made better
      rect(width*5/6, height/6-scrollX*space/listLength, 10, 50, 5);

      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }

    if (currScreen == 17) {
      eM.display();
    }

    if (currScreen == 18) {
      tempBill.percentages[0] = sliders[0].value;
      tempBill.percentages[1] = sliders[1].value;
      textSize(26);
      textAlign(CENTER, CENTER);
      fill(0);
      text("Create a bill with two department policies:", width/2, (height-30)*1/12+30);
      // Create the ideas box
      fill(255);
      rect(width/6, height/6, width*2/3, height-215-height/6);
      fill(0);
      textAlign(LEFT, TOP);
      textSize(20);
      for (int i = 0; i < depIdeas.size(); i++) {
        if (height/6+24*i+scrollX >= height/6) {// 0 is none, 1-2 is already there, so 3 is 1
          if (i == chosen-3) {
            fill(0, 0, 100);
            rect(width/6, height/6+24*i+scrollX, width*4/6, 24);
            fill(0);
          }
          text(depIdeas.get(i), width/6+5, height/6+24*i+scrollX);
        }
        if (height/6+24*(i+1)+scrollX >= height/6)
          line(width/6, height/6+24*(i+1)+scrollX, width*5/6, height/6+24*(i+1)+scrollX);
      }

      fill(255);
      rect(width/6, height-208, width*2/3, 68);
      line(width/6, height-174, width*5/6, height-174);
      textAlign(LEFT, CENTER);
      fill(0);
      if (tempBill.ideas[0] != -1)
        text(ideas.names[tempBill.ideas[0]], width/6, height-191);
      if (tempBill.ideas[1] != -1)
        text(ideas.names[tempBill.ideas[1]], width/6, height-157);
      fill(0, 0, 100);
      if (chosen == 1)
        rect(width/6, height-208, width*4/6, 34);
      if (chosen == 2)
        rect(width/6, height-174, width*4/6, 34);
      fill(0);
      for (int i = 0; i < sliders.length; i++)
        sliders[i].display();
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }

    if (currScreen == 19) {
      textSize(30);
      textAlign(CENTER, CENTER);
      text("Find a Department for the Rider", width/2, height/6+25);
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }

    if (currScreen == 20) {
      tempBill.percentages[2] = sliders[0].value;
      textSize(26);
      textAlign(CENTER, CENTER);
      fill(0);
      text("Pick a rider from this department for your bill:", width/2, (height-30)*1/12+30);
      // Create the ideas box
      fill(255);
      rect(width/6, height/6, width*2/3, height-181-height/6);
      fill(0);
      textAlign(LEFT, TOP);
      textSize(20);
      for (int i = 0; i < depIdeas.size(); i++) {
        if (height/6+24*i+scrollX >= height/6) {// 0 is none, 1 is already there, so 2 is 1
          if (i == chosen-2) {
            fill(0, 0, 100);
            rect(width/6, height/6+24*i+scrollX, width*4/6, 24);
            fill(0);
          }
          text(depIdeas.get(i), width/6+5, height/6+24*i+scrollX);
        }
        if (height/6+24*(i+1)+scrollX >= height/6)
          line(width/6, height/6+24*(i+1)+scrollX, width*5/6, height/6+24*(i+1)+scrollX);
      }
      fill(255);
      rect(width/6, height-174, width*2/3, 34);
      textAlign(LEFT, CENTER);
      fill(0);
      if (chosen == 1) {
        fill(0, 0, 100);
        rect(width/6, height-174, width*2/3, 34);
        fill(0);
      }
      if (tempBill.ideas[2] != -1)
        text(ideas.names[tempBill.ideas[2]], width/6, height-157);
      // }
      for (int i = 0; i < sliders.length; i++)
        sliders[i].display();
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }

    if (currScreen == 21) {
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();

      textAlign(LEFT, TOP);
      textSize(40);
      float namespaceWidth = textWidth("Bill #" + (bills.size()+1)+":")+5;
      rect(width/6+namespaceWidth, height/6, width*2/3-namespaceWidth, 40);
      fill(255, 0, 0);
      text("Bill #" + (bills.size()+1)+":", width/6, height/6);
      fill(0);
      if (tempBill != null) {
        textSize(32);
        if (tempBill.name == "Type name here")
          fill(150);
        text(tempBill.name, width/6+namespaceWidth, height/6);
        fill(0);
        if ((millis()/1000)%2 == 0)
          line(width/6+namespaceWidth+textWidth(tempBill.name), height/6+3, width/6+namespaceWidth+textWidth(tempBill.name), height/6+37);
        fill(0);
        text("Brought to House committee by Rep. "+tempBill.broughtBy.name+"("+(tempBill.broughtBy.party+"").toUpperCase()+")", width/6, height/6+40);
        textSize(25);
        text("Main clauses of this bill:", width/6, height/6+90);
        text("1. "+ideas.names[tempBill.ideas[0]]+" ("+tempBill.percentages[0]+"%)", width/6, height/6+130);
        if (tempBill.ideas[1] != -1)
          text("2. "+ideas.names[tempBill.ideas[1]]+" ("+tempBill.percentages[1]+"%)", width/6, height/6+160);
        if (tempBill.ideas[2] != -1)
          text("3. "+ideas.names[tempBill.ideas[2]]+" ("+tempBill.percentages[2]+"%)", width/6, height/6+190);
      }
    }

    if (currScreen == 23) {
      fill(200, 0, 0);
      rect(width/6, height/2+10, width/6, height*2/6-10, 10);
      rect(width*2/3, height/2+10, width/6, height*2/6-10, 10);
      fill(0, 0, 255);
      rect(width/6, height/2+30, width/6, height*2/6-30);
      rect(width*2/3, height/2+30, width/6, height*2/6-30);

      fill(255);
      rect(width/6, height/6, width*2/3, height/2-height/6);
      textAlign(CENTER, CENTER);
      textSize(20);
      int xVal = width/6+max(max(wordWidths(themActions, 15)), max(wordWidths(youActions, 15)));
      rect(xVal, height/2+30, width-xVal*2, height*2/6-30);

      fill(0);
      text("Them", width/4, height/2+20);
      text("You", width*3/4, height/2+20);
      line(width/2, height/2+30, width/2, height*2/6-30);

      int x = height/2+40;
      textSize(15);
      for (int i = 0; i < themActions.length; i++) {
        for (int j = 0; j < themActions.length; j++) {

        }
        textAlign(LEFT, TOP);
        text(themActions[i], width/6, x);
        textAlign(RIGHT, TOP);
        text(youActions[i], width*5/6, x);
        x += 20;
      }
      // The - signs need to signify that the list is expanded, and then the things in the list must actually be expanded

      /*
          list of things they give and things you give with 'add' and 'remove'

          * support of a bill
          * denunciation of a bill
          * vote for a bill
          * vote against a bill
          * promise funding to those in your party
          * endorse their campaign

      */
    }
  }
  public int[] wordWidths(String[] words, int s) {
    textSize(s);
    int[] ls = new int[words.length];
    for (int i = 0; i < words.length; i++)
      ls[i] = (int)textWidth(words[i]);
    return ls;
  }
}
class Secretary {
  // This class holds information for each member of your cabinet
  String title;
  String dep;
  int[] events;// events having to do with this dept
  int happiness;// current state of the dept (does it have the capital to be efficient?)
  int funding;
  
  Secretary(String d, String t) {
    dep = d;
    title = t;
    happiness = 90;
  }
  
  public void findFunding() {
    funding = 0;
    Table t = loadTable("startingbudget.csv", "header");
    for (TableRow r: t.rows())
      if (cabinet[Utils.convertInt(r.getString(2))].dep == this.dep)
        funding += Utils.convertInt(r.getString(1));
  }
}
class Slider {
  float x;
  float y;
  float len;
  float boxSize;
  int value;
  int maxVal;
  float boxX;
  float boxY;
  boolean visible;
  
  String units;

  Slider(float xVal, float yVal, int max, float leng) {
    x = xVal;
    y = yVal;
    len = leng;
    maxVal = max;
    visible = true;
  }

  public void display() {
    if (visible) {
      fill(0);
      textAlign(LEFT, CENTER);
      textSize(16);
      text(maxVal+" "+units, x+len+5, y);
      strokeWeight(2);
      line(x, y, x+len, y);
      strokeWeight(1);
      textAlign(CENTER, CENTER);
      textSize(12);
      boxSize = textWidth(""+value)+5;
      fill(255);
      rect(x+value*len/maxVal-boxSize/2, y-boxSize/2, boxSize, boxSize);
      fill(0);
      text(value, x+value*len/maxVal, y);
    }
  }
  
  public boolean isInside(float mX, float mY) {
    return mX > x+value*len/maxVal-boxSize/2 && mX < x+value*len/maxVal+boxSize/2 && mY > y-boxSize/2 && mY < y+boxSize/2;
  }
}

static class Utils {

  // converts numbers from String to int //
  public static int convertInt(String num) {
    int n = 0;
    for (int i = 0; i < num.length (); i++)
      n += ((int)num.charAt(num.length()-1-i)-(int)'0')*pow(10, i);
    return n;
  }
  
  public static int findDems(int rating, float r) {
    int dems = 0;
    if (rating == 2 && r < 2)
      dems = 1;
    else if (rating == 3) {
      if (r < 2)
        dems = 1;
      else if (r < 4)
        dems = 2;
    }
    else if (rating == 4) {
      dems = 1;
      if (r < 2)
        dems = 2;
    }
    else if (rating == 5)
      dems = 2;
    return dems;
  }
  
  public static ArrayList<Congressman> searchThrough(String input, Congressman[] house, Congressman[] senate) {
    // +====== Returns an arraylist of congressmen that satisfy String input ======+
    input = input.toLowerCase();
    ArrayList<Congressman> r = new ArrayList<Congressman>();
    Congressman[] con = new Congressman[house.length+senate.length];
    for (int i = 0; i < house.length; i++)
      con[i] = house[i];
    for (int i = 0; i < senate.length; i++)
      con[house.length+i] = senate[i];
      
    for (int i = 0; i < con.length; i++) {
      boolean done = false;
      
      // * state search:
      if (input.indexOf(con[i].state.toLowerCase()) != -1)
        r.add(con[i]);
      //Table s = loadTable("states.csv", "header");
      //for (TableRow r : s.rows())
      //  if (con[i].state.equals(r.getString(1)))
      //    if (input.indexOf(r.getString(0).toLowerCase()) != -1)
      //      r.add(con[i]);
    
      // * name search:
      for (int j = 2; i < con[i].name.length() && !done; j++) {
        if (input.indexOf(con[i].name.substring(0, j).toLowerCase()) != -1) {// checking if they have full name in there
          done = true;
          r.add(con[i]);
        }
        if (!done && con[i].name.substring(0, j).indexOf(" ") != -1) {// is there a last name? Is that there?
          if (input.indexOf(con[i].name.substring(con[i].name.indexOf(" ")+1, j).toLowerCase()) != -1) {
            done = true;
            r.add(con[i]);
          }
        }
      }
    
      // * party search:
      if (!done && con[i].party == 'D' && (input.indexOf("d") != -1 || input.indexOf("democrat") != -1)) {
        done = true;
        r.add(con[i]);
      }
      if (!done && con[i].party == 'R' && (input.indexOf("r") != -1 || input.indexOf("republican") != -1)) {
        done = true;
        r.add(con[i]);
      }
    
      // * position search:
      //   0 is none, 1 is leader, 2 is whip, 3 is speaker. 1 and 2 have majority or minority and senate or house
      if (!done) {
        if (input.indexOf("leader") != -1 && con[i].leadership == 1) {
          done = true;
          r.add(con[i]);
        }
        else if (input.indexOf("whip") != -1 && con[i].leadership == 2) {
          done = true;
          r.add(con[i]);
        }
        else if (input.indexOf("speaker") != -1 && con[i].leadership == 3) {
          done = true;
          r.add(con[i]);
        }
      }
    }
    return r;
  }
}
}
