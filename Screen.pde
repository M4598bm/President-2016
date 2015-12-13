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
  int currScreen;// the current screen
  int lastScreen;// screen before this one. Not in use yet but will be good for a back button.
  // Maybe the above will be an ArrayList or tree so it can go back further?
  int lastButton;// The last button pressed, I don't remember what it's for
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


  Screen() {
    /* The constructor for string, mostly initializes values
    */
    setScreen(0);
    d1 = new ArrayList<Integer>();
    d2 = new ArrayList<Integer>();
  }


  void setScreen(int c) {
    /* One of the two major methods in this class
    It initializes the screen at the beginning, setting up Buttons and Sliders
    Each instance is defined at the beginning, so when searching through them use
    the 'if (currScreen == <x>)'
    */
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
      search = new ArrayList<Congressman>();
      chosen = -1;
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
        /*  Things in this screen:
            * search bar for state, name, party that updates always
            * list of people that fit this ^
            * button on the bottom to automatically 'make deal' with each (link to next screen)
        */
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
      buttons = new Button[0];
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

      Congressman cman = search.get(chosen);
      String[] themActions =
      {" Vote for a bill (+)", " Vote against a bill (+)", " Endorse President"};
      String[] youActions =
      {"Support a bill (+) ", "Denounce a bill (+) ", "Sign a bill (+) ", "Veto a bill (+) ", "No attack ads for... (+) ", "Promise funding ", "Endorse Congressperson "};
      trade = new Interaction(youActions, themActions);
      search.clear();
      search.add(cman);// The only thing in search should be the chosen congressman
      chosen = -1;
      scrollsX = new int[4];// 0: left, 1: center left, 2: center right, 3: right

    }
  }





  void display() {
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
          String mes = " • Bill #"+bill.billNumber+": "+bill.name+" (";
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

      search = Utils.searchThrough(input, house, senate);
      textAlign(LEFT, TOP);
      for (int i = 0; i < search.size(); i++) {
        if (height/6+24*i+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6) {
          if (i == chosen) {
            fill(0, 0, 100);
            rect(width/6, height/6+24*i+scrollX, width*4/6, 24);
            fill(0);
          }
          text("Sen. "+search.get(i).name+"  ("+search.get(i).party+", "+search.get(i).state+")", width/6+5, height/6+24*i+scrollX);
        }
        if (height/6+24*(i+1)+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6)
          line(width/6, height/6+24*(i+1)+scrollX, width*5/6, height/6+24*(i+1)+scrollX);
      }

      //===============================================================================
      //===============================================================================
      // This is the code that represents one scroll bar. The directions for what to do
      // are in the github issue. Use listLength and space.
      fill(50, 125, 250);
      float listLength = max(1, 24*search.size());// listlength is size of the list in pixels. List.size() is # of items
      float space = height*2/3;// Space that the text area takes up.
      if (space < listLength) {
        float scrollLength = space/listLength;// scrolllength is I think what is broken.
        rect(width*5/6, height/6-scrollX*space/listLength, 10, scrolllength, 5);// This is the problem line.
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


    }
  }
  int[] wordWidths(String[] words, int s) {
    textSize(s);
    int[] ls = new int[words.length];
    for (int i = 0; i < words.length; i++)
      ls[i] = (int)textWidth(words[i]);
    return ls;
  }
}
