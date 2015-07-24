// Globals:
String name;
Screen screen;
int turn;
int[] date;
int approval;
boolean houseSpeech;
boolean senateSpeech;
ArrayList<Bill> bills;
ArrayList<Bill> laws;
Bill tempBill;


void setup() {
  size(displayWidth, (int)(displayHeight*.8));//*.8 is temp
  background(50, 125, 250);
  screen = new Screen();
  approval = 50;
  int[] dateTemp = {1, 20, 17};
  date = dateTemp;
  bills = new ArrayList<Bill>();
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
  text("Date: " + date[0] + "/" + date[1] + "/" + date[2], width/4, 15);
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
//================================
//========= Controls =============
//================================

void mouseClicked() {
  float mX = mouseX;
  float mY = mouseY;
  textSize(16);
  float wordWidth = textWidth("Main Menu")/2;
  if (mX < width/10+10+wordWidth && mX > width/10+10-wordWidth && mY < height/10+46 && mY > height/10-15)
    screen.setScreen(0);
  if (screen.buttons != null) {
    boolean done = false;
    for (int i = 0; i < screen.buttons.length && !done; i++)
      if (screen.buttons[i].isInside(mX, mY)) {
        done = true;
        screen.setScreen(screen.buttons[i].command);
      }
  }
}

void keyPressed() {
  println(screen.scrollX);
  if (screen.currScreen == 12) {
    if (keyCode == UP && screen.scrollX != 0)
      screen.scrollX += 10;
    else if (keyCode == DOWN)
      screen.scrollX -= 10;
    else if (keyCode == BACKSPACE) {
      if (tempBill.name.length() != 0)
        tempBill.name = tempBill.name.substring(0, tempBill.name.length()-1);
    }
    else if (keyCode != ENTER)
      tempBill.name += key;
  }
}
