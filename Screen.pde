public class Screen {
  /* Different Screens:
      0: Main
      1: Stats
      2: Cabinet
      3: Congress
      4: Bully Pulpit
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
  Button[] buttons;
  
  Screen() {
    currScreen = 0;
    setScreen(0);
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
      buttons[2].setLabel("Bully Pulpit", 14, 255);
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
      buttons = new Button[3];
      // Senate Speech, House Speech, New Bill
      buttons[0] = new Button(width/2-340, height/2+40, 300, 80, color(255, 0, 0), 10);
      buttons[0].setLabel("House of Representatives", 14, 255);
      buttons[1] = new Button(width/2+40, height/2+40, 300, 80, color(255, 0, 0), 11);
      buttons[1].setLabel("The Senate", 14, 255);
      buttons[2] = new Button(width/2-150, height/2-120, 300, 80, color(255, 0, 0), 12);
      buttons[2].setLabel("Introduce New Bill", 14, 255);
      for (int i = 0; i < buttons.length; i++)
        buttons[i].scrollCol = color(200, 0, 0);
    }
      
  }
    
  void display() {
    background(50, 125, 250);
    fill(0);
    /*=================
      Main Screen
    Has buttons for:
        Cabinet
        Congress
        Bully Pulpit
        National Committee
        United Nations Ambassador
        Calendar
        Statistics
        War Room
        Intelligence
    */
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
      text("Or Speak Before...", width/2, height/2);
      for (int i = 0; i < buttons.length; i++)
        buttons[i].display();
    }
    
  }
}
