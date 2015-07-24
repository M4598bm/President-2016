class Screen {
  /* Different Screens:
      0: Main
      1: Stats
      2: Cabinet
      3: Congress
      4: International
      5: NC
      6: UN
      7: Calendar
      8: War
      9: Intel
      10: House speech
      11: Senate speech
      12: New bill
      
  */
  int currScreen;
  int extra;
  Button[] buttons;
  int scrollX;
  String[] ideas;
  
  Screen() {
    currScreen = 0;
    extra = 0;
    setScreen(0);
    ideas = new String[4];
    ideas[0] = "This is a great idea";
    ideas[1] = "Raise all of the taxes";
    ideas[2] = "Kill them all";
    ideas[3] = "I love pie";
  }
  void setScreen(int c) {
    
    currScreen = c;
    if (currScreen == 0) {
      buttons = new Button[9];
      buttons[0] = new Button(width/2-320, height/2-110, 200, 60, color(255, 0, 0), 2);
      buttons[0].setLabel("Cabinet", 14, 255);
      buttons[1] = new Button(width/2-100, height/2-110, 200, 60, color(255, 0, 0), 3);
      buttons[1].setLabel("Congress", 14, 255);
      buttons[2] = new Button(width/2+120, height/2-110, 200, 60, color(255, 0, 0), 4);
      buttons[2].setLabel("International Treaties", 14, 255);
      buttons[3] = new Button(width/2-320, height/2-30, 200, 60, color(255, 0, 0), 5);
      buttons[3].setLabel("National Committee", 14, 255);
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
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
    }
    
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 1) {// Stats
      buttons = new Button[0];
      
      
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 2) {// Cabinet
      buttons = new Button[0];
      
      
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
      buttons[3] = new Button(width/2-150, height/2+140, 300, 80, color(255, 0, 0), 12);
      buttons[3].setLabel("Talk to Legislators", 14, 255);
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 10) {//house speech
      buttons = new Button[1];
      buttons[0] = new Button(width/2-340, height/2+40, 300, 80, color(255, 0, 0), 10);
      buttons[0].setLabel("Speak", 14, 255);
      
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 12) {
      buttons = new Button[0];
      scrollX = 0;
      tempBill = new Bill();
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
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }
    if (currScreen == 2) {
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
    if (currScreen == 10) {
      textAlign(CENTER, CENTER);
      textSize(20);
      text("Speech to the House of Representatives", width/2, height/8);
      
    }
    
    if (currScreen == 12) {
      textSize(26);
      textAlign(CENTER, CENTER);
      fill(0);
      text("Create a bill with up to three policies:", width/2, (height-30)*1/12+30);
      // Create the ideas box
      fill(255);
      rect(width/6, height/6, width*2/3, height*2/6);
      fill(0);
      textAlign(LEFT, TOP);
      textSize(20);
      for (int i = 0; i < ideas.length; i++) {
        if (height/6+24*i+scrollX >= height/6)
          text(ideas[i], width/6+5, height/6+24*i+scrollX);
        if (height/6+24*(i+1)+scrollX >= height/6)
          line(width/6, height/6+24*(i+1)+scrollX, width*5/6, height/6+24*(i+1)+scrollX);
      }
      
      fill(255);
      rect(width/6, height/2+40, width*2/3, height/4);
      float namespaceWidth = textWidth("Bill #" + (bills.size()+1)+":")+5;
      rect(width/6+namespaceWidth, height/2+10, width*2/3-namespaceWidth, 20);
      fill(0);
      text("Bill #" + (bills.size()+1)+":", width/6, height/2+10);
      if (tempBill != null) {
        textSize(16);
        if (tempBill.name == "Type name here")
          fill(150);
        text(tempBill.name, width/6+namespaceWidth, height/2+10);
        fill(0);
        line(width/6+namespaceWidth+textWidth(tempBill.name), height/2+13, width/6+namespaceWidth+textWidth(tempBill.name), height/2+27);
        tempBill.addIdea(1);
        tempBill.addIdea(12);
        tempBill.addIdea(5);
        line(width/6, height/2+64, width*5/6, height/2+64);
        line(width/6, height/2+88, width*5/6, height/2+88);
        line(width/6, height/2+112, width*5/6, height/2+112);
        // This is only for right now
        for (int i = 0; i < 3; i++)
          text(tempBill.ideas[i], width/6, height/2+40+24*i);
        // Here will be put sliders with the amount that the player wants it to go into effect, but I'm lazy
        
      }
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }
    
    //if (currScreen == 13) {
    
  }
  
  
}
