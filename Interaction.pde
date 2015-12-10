class Interaction {
  String[] yourOptions;
  String[] themOptions;
  ArrayList<String> currYou;
  ArrayList<String> currThem;
  ArrayList<String>[] displays;
  // how displays works is that it holds ArrayLists of titles, and they link with stuff.
  // displays[i].get(0) is what is always shown, and if it is expanded, what is under it is.


  Interaction(String[] you, String[] them) {
    yourOptions = you;
    themOptions = them;
    currYou = new ArrayList<String>();
    currthem = new ArrayList<String>();
  }



  void displayCongressTrade() {
    fill(200, 0, 0);
    rect(width/6, height/6-20, width/6, 30, 10);
    rect(width*2/3, height/6-20, width/6, 30, 10);
    fill(0, 0, 255);
    rect(width/6, height/6, width/6, height*2/3);
    rect(width*2/3, height/6, width/6, height*2/3);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(20);
    int xVal = width/6+max(max(wordWidths(themActions, 15)), max(wordWidths(youActions, 15)));
    rect(xVal, height/6, width-xVal*2, height*2/3);

    fill(0);
    text("Them", width/4, height/6-10);
    text("You", width*3/4, height/6-10);
    line(width/2, height/6, width/2, height*5/6);

    // This is a long process that I'm using brute force on....
    // But basically it's the display of the trades

    // themActions = {" Vote for a bill (+)", " Vote against a bill (+)", " Endorse President"};

    textSize(15);
    textAlign(LEFT, TOP);
    int x = height/6-scrollsX[0];

    for (int i = 0; i < themActions.length; i++) {
      text(displays[i].get(0), width/6, x);
      x+=15;
      if (displays[i].get(0).contains("(-)")) {
        for (int j = 0; i < displays[i].size(); i++) {
          text(displays[i].get(j), width/6, x);
          x+=15;
        }
      }
    }

    textAlign(RIGHT, TOP);
    int x = height/6-scrollsX[0];

    for (int i = themActions.length; i < displays.length; i++) {
      text(displays[i].get(0), width*5/6, x);
      x+=15;
      if (displays[i].get(0).contains("(-)")) {
        for (int j = 0; i < displays[i].size(); i++) {
          text(displays[i].get(j), width*5/6, x);
          x+=15;
        }
      }
    }
  }

  void setCongressTrade() {
    displays[] = new ArrayList<String>[themActions.length+YouActions.length];

    displays[0] = new ArrayList<String>();
    displays[0] = themActions[0];
    if (search.get(0).house == 0)// house of representatives
      for (int i = 0; i < bills.size(); i++) {
        if (bills.get(i).status == 1) {
          displays[0].add(bills.get(i).name, i+1);
        }
      }
    else if (search.get(0).house == 1)// senate
      for (int i = 0; i < bills.size(); i++) {
        if (bills.get(i).status == 2) {
          text(bills.get(i).name, width/6, x);
          x+= 15;
        }
      }

    text(themActions[1], width/6, x);
    x+= 15;
    if (themActions[1].contains("(-)")) {
      if (search.get(0).house == 0)// house of representatives
        for (int i = 0; i < bills.size(); i++) {
          if (bills.get(i).status == 1) {
            text(bills.get(i).name, width/6, x);
            x+= 15;
          }
        }
      else if (search.get(0).house == 1)// house of representatives
        for (int i = 0; i < bills.size(); i++) {
          if (bills.get(i).status == 2) {
            text(bills.get(i).name, width/6, x);
            x+= 15;
          }
        }
    }

    text(themActions[2], width/6, x);
    x+=15;

    textAlign(RIGHT, TOP);
    x = height/6-scrollsX[0];
    // youActions =  {"Speak in support of a bill (+) ", "Denounce a bill (+) ", "Sign a bill (+) ", "Veto a bill (+) ", "No attack ads for... (+)", "Promise funding ", "Endorse Congressperson "};

    text(youActions[0], width*5/6, x);
    x+= 15;
    if (youActions[0].contains("(-)"))
      for (int i = 0; i < bills.size(); i++)
        if (bills.get(i).status < 3) {
          text(bills.get(i).name, width*5/6, x);
          x+= 15;
        }

    text(youActions[1], width*5/6, x);
    x+= 15;
    if (youActions[1].contains("(-)"))
      for (int i = 0; i < bills.size(); i++)
        if (bills.get(i).status < 3) {
          text(bills.get(i).name, width*5/6, x);
          x+= 15;
        }


    text(youActions[2], width*5/6, x);
    x+= 15;
    if (youActions[2].contains("(-)"))
      for (int i = 0; i < bills.size(); i++)
        if (bills.get(i).status == 3) {
          text(bills.get(i).name, width*5/6, x);
          x+= 15;
        }

    text(youActions[3], width*5/6, x);
    x+= 15;
    if (youActions[3].contains("(-)"))
      for (int i = 0; i < bills.size(); i++)
        if (bills.get(i).status == 3) {
          text(bills.get(i).name, width*5/6, x);
          x+= 15;
        }
    text(youActions[4], width*5/6, x);
    x+= 15;
    if (youActions[4].contains("(-)")) {
      text("One month", width*5/6, x);
      x+= 15;
      text("Six months", width*5/6, x);
      x+= 15;
      text("One year", width*5/6, x);
      x+= 15;
      text("Until after next election", width*5/6, x);
      x+= 15;
    }

    text(youActions[5], width*5/6, x);
    x+=15;
    text(youActions[6], width*5/6, x);
    x+=15;

    // The - signs need to signify that the list is expanded, and then the things in the list must actually be expanded
  }



}
