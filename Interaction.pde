class Interaction {
  String[] yourOptions;
  String[] themOptions;
  ArrayList[] currYou;
  ArrayList[] currThem;
  ArrayList[] displays;
  // how displays works is that it holds ArrayLists of titles, and they link with stuff.
  // displays[i].get(0) is what is always shown, and if it is expanded, what is under it is.

  // Constructor
  // Precondition: you and them are the things to be traded between
  // Postcondition: creates the Object
  Interaction(String[] you, String[] them) {
    yourOptions = you;
    themOptions = them;
    currYou = new ArrayList[you.length];
    currThem = new ArrayList[them.length];
  }

// I think I'm going to scrap this class so ignore it

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
    int xVal = width/6+max(max(wordWidths(themOptions, 15)), max(wordWidths(yourOptions, 15)));
    rect(xVal, height/6, width-xVal*2, height*2/3);

    fill(0);
    text("Them", width/4, height/6-10);
    text("You", width*3/4, height/6-10);
    line(width/2, height/6, width/2, height*5/6);

    // This is a long process that I'm using brute force on....
    // But basically it's the display of the trades

    // themOptions = {" Vote for a bill (+)", " Vote against a bill (+)", " Endorse President"};

    textSize(15);
    textAlign(LEFT, TOP);
    int x = height/6-screen.scrollsX[0];

    for (int i = 0; i < themOptions.length; i++) {
      text((String)displays[i].get(0), width/6, x);
      x+=15;
      if (((String)displays[i].get(0)).contains("(-)")) {
        for (int j = 0; i < displays[i].size(); i++) {
          text((String)displays[i].get(j), width/6, x);
          x+=15;
        }
      }
    }

    textAlign(RIGHT, TOP);
    x = height/6-screen.scrollsX[0];

    for (int i = themOptions.length; i < displays.length; i++) {
      text((String)displays[i].get(0), width*5/6, x);
      x+=15;
      if (((String)displays[i].get(0)).contains("(-)")) {
        for (int j = 0; i < displays[i].size(); i++) {
          text((String)displays[i].get(j), width*5/6, x);
          x+=15;
        }
      }
    }
  }

  void setCongressTrade() {
    String[] themOptions =
    {" Vote for a bill (+)", " Vote against a bill (+)", " Endorse President"};
    String[] yourOptions =
    {"Support a bill (+) ", "Denounce a bill (+) ", "Sign a bill (+) ", "Veto a bill (+) ", "No attack ads for... (+) ", "Promise funding ", "Endorse Congressperson "};

    displays = new ArrayList[themOptions.length+yourOptions.length];

    //" Support a bill (+)"
    displays[0] = new ArrayList();
    displays[0].add(themOptions[0]);
    //" Denounce a bill (+)"
    displays[1] = new ArrayList();
    displays[1].add(themOptions[1]);
    if (screen.search.get(0).house == 0)// house of representatives
      for (int i = 0; i < bills.size(); i++) {
//        if (bills.get(i).status == 1) {
          displays[0].add(bills.get(i));
          displays[1].add(bills.get(i));
//        }
      }
    else if (screen.search.get(0).house == 1)// senate
      for (int i = 0; i < bills.size(); i++) {
//        if (bills.get(i).status == 2) {
          displays[0].add(bills.get(i));
          displays[1].add(bills.get(i));
//        }
      }
    // " Endorse President"
    displays[2] = new ArrayList();
    displays[2].add(themOptions[2]);


    // "Speak in support of a bill (+) "
    displays[3] = new ArrayList();
    displays[3].add(yourOptions[0]);
    // "Denounce a bill (+) "
    displays[4] = new ArrayList();
    displays[4].add(yourOptions[1]);

    for (int i = 0; i < bills.size(); i++) {
//      if (bills.get(i).status < 3) {
        displays[3].add(bills.get(i));
        displays[4].add(bills.get(i));
//      }
    }

    // "Sign a bill (+) "
    displays[5] = new ArrayList();
    displays[5].add(yourOptions[2]);
    // "Veto a bill (+) "
    displays[6] = new ArrayList();
    displays[6].add(yourOptions[3]);

    for (int i = 0; i < bills.size(); i++) {
//      if (bills.get(i).status == 3) {
        displays[5].add(bills.get(i));
        displays[6].add(bills.get(i));
//      }
    }
    // "No attack ads for... (+) "
    displays[7] = new ArrayList();
    displays[7].add(yourOptions[4]);

    displays[7].add("One month");
    displays[7].add("Six months");
    displays[7].add("One year");
    displays[7].add("Until after next election");

    // "Promise funding "
    displays[8] = new ArrayList();
    displays[8].add(yourOptions[5]);
    // "Endorse Congressperson "
    displays[9] = new ArrayList();
    displays[9].add(yourOptions[6]);
  }

  int dTotalLength() {
    int count = 0;
    for (int i = 0; i < displays.length; i++)
      count += displays[i].size();
    return count;
  }

}