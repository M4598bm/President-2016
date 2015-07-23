// Globals:
String name;
Screen screen;
int turn;
int[] date;
int approval;
boolean houseSpeech;
boolean senateSpeech;

void setup() {
  size(displayWidth, (int)(displayHeight*.8));//*.8 is temp
  background(50, 125, 250);
  screen = new Screen();
  approval = 50;
  int[] dateTemp = {1, 20, 17};
  date = dateTemp;
}


void draw() {
  screen.display();
  topBar();
  if (screen.buttons != null)
    for (int i = 0; i < screen.buttons.length; i++) {
      if (screen.buttons[i].isInside(mouseX, mouseY))
        screen.buttons[i].scrolled = true;
      else
        screen.buttons[i].scrolled = false;
    }
}

void mouseClicked() {
  if (screen.buttons != null) {
    boolean done = false;
    for (int i = 0; i < screen.buttons.length && !done; i++)
      if (screen.buttons[i].isInside(mouseX, mouseY)) {
        done = true;
        screen.setScreen(screen.buttons[i].command);
      }
  }
}

void topBar() {// Turn # | Date | Approval Rating | Turns until next election
  fill(255);
  rect(0, -5, width, 35, 3);
  fill(0);
  textAlign(LEFT, CENTER);
  text("Turn: " + turn, 5, 15);
  text("Date: " + date[0] + "/" + date[1] + "/" + date[2], width/4, 15);
  text("Approval Rating: " + approval + "%", width/2, 15);
  text("Turns until next election", width*3/4, 15);// This needs to be found
}
