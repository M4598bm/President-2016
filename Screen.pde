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
      13: Legislators
      
  */
  int currScreen;
  int extra;
  Button[] buttons;
  int scrollX;
  int chosen;
  String[] ideas;
  
  
  Screen() {
    currScreen = 0;
    extra = 0;
    setScreen(0);
    ideas = new String[4];
    ideas[0] = "This is a great idea";
    ideas[1] = "Raise all of the taxes";
    ideas[2] = "Do something cool";
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
      buttons[3] = new Button(width/2-150, height/2+140, 300, 80, color(255, 0, 0), 13);
      buttons[3].setLabel("Talk to Legislators", 14, 255);
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
    }
    
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 7) {// Calendar
      buttons = new Button[0];
    }
    
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 10) {//house speech
      buttons = new Button[1];
      buttons[0] = new Button(width/2-150, height-100, 300, 80, color(255, 0, 0), 0);
      buttons[0].setLabel("Speak", 14, 255);
      
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 11) {//senate speech
      buttons = new Button[1];
      buttons[0] = new Button(width/2-150, height-100, 300, 80, color(255, 0, 0), 0);
      buttons[0].setLabel("Speak", 14, 255);
      
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
    }
    //-------------------------------------------------
    //-------------------------------------------------
    else if (currScreen == 12) {
      buttons = new Button[1];
      buttons[0] = new Button(width/2-150, height-100, 300, 80, color(255, 0, 0), 0);
      buttons[0].setLabel("Introduce This Bill", 14, 255);
      scrollX = 0;
      tempBill = new Bill();
      
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
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
    
    if (currScreen == 7) {
      calendar.display();
    }
    
    if (currScreen == 10) {
      textAlign(CENTER, CENTER);
      textSize(20);
      text("Speech to the House of Representatives", width/2, height/8);
    }
    if (currScreen == 11) {
      textAlign(CENTER, CENTER);
      textSize(20);
      text("Speech to the Senate", width/2, height/8);
    }
    if (currScreen == 10 || currScreen == 11) {
      text("Bills on the floor:", width/2, height/8+25);
      fill(255);
      rect(width/6, height/8+45, width*2/3, height/3);// all bills
      
      rect(width/6, height/2+65, width/3-40, 50);// to support
      rect(width/2+40, height/2+65, width/3-40, 50);// to criticize
      fill(0);
      text("Bills to Support", width/4, height/2+45);
      text("Bills to Criticize", width*3/4, height/2+45);
      line(width/6, height/2+90, width/2-40, height/2+90);
      line(width/2+40, height/2+90, width*5/6, height/2+90);
      
      fill(0, 0, 200);
      rect(width/6, height/2+115, width/3-40, 50, 5);// add/remove buttons (Support)
      rect(width/2+40, height/2+115, width/3-40, 50, 5);// add/remove buttons (Criticize)
      /*Richard:
        the above two rectangles need lines between them, and they will be two separate sets of add and remove.
        The bulk of it however is that the bills in the above box with all availiable bills to support or criticize need to
        be selected (and therefore highlighted, use the int chosen) and then the add buttons will add them to the corresponding
        2 bill area above, and remove buttons being pressed will remove the bill ONLY from the corresp. box. The clicking thing
        must be done in void mouseClicked() in President.pde, and use an
        if (screen.currScreen == 10 || screen.currScreen == 11) {}. Thanks!
      
      */
      
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
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
      /* Richard:
        This whole section is pretty important and needs the same kind of thing (add/remove button). it only needs one add/remove
        because it's just picking which things go in the bill. ideas should be ints that correspond to String ideas, but those
        will be in a separate file that isnt worked out yet. The ideas just need to end up in that box and in the tempBill so
        that a button can be pressed to move on and introduce the bill.
        
        
        */
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
        
        line(width/6, height/2+64, width*5/6, height/2+64);
        line(width/6, height/2+88, width*5/6, height/2+88);
        line(width/6, height/2+112, width*5/6, height/2+112);
        // This is temporary
        for (int i = 0; i < 3; i++)
          text(tempBill.ideas[i], width/6, height/2+40+24*i);
        /*
          Here will be put sliders with the amount that the player wants each idea to go into effect
          
          Richard if you want to do that, you can. Use constrain(), from processing reference. Dont worry about what they
          actually change, just have the mouse action done
         */
        
      }
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }
    
    //if (currScreen == 13) {
    
  }
  
  
}
