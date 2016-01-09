class Screen28 extends Screen {
  // See Executive Orders

  // toString method
  // Precondition: none
  // Postcondition: returns screen number
  String toString() {
    return "28";
  }

  // Sets the screen when it is first created
  // Precondition: This is the current Screen, buttons and sliders are arrays
  // Postcondition: The screen is prepared to be displayed
  void setScreen() {
    buttons = new Button[0];
  }

  // Displays the screen
  // Precondition: setScreen has been called for this screen, this is the current Screen
  // Postcondition: this screen is displayed
  void display() {
    super.display();
    if (extra == 0) {
      fill(0);
      textAlign(CENTER, BOTTOM);
      textSize(30);
      text("All Executive Orders", width/2, height/6);
      fill(255);
      rect(width/6, height/6, width*2/3, height*2/3);
      textAlign(LEFT, TOP);
      fill(0);
      for (int i = 0; i < executiveOrders.size(); i++) {
        if (height/6+24*i+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6) {
          text(executiveOrders.get(i).name, width/6+5, height/6+24*i+scrollX);
        }
        if (height/6+24*(i+1)+scrollX >= height/6 && height/6+24*(i+1)+scrollX <= height*5/6)
          line(width/6, height/6+24*(i+1)+scrollX, width*5/6, height/6+24*(i+1)+scrollX);
      }
      displayScrollBar(executiveOrders.size(), height*5/6);
    }
    else {// extra = 1
      fill(255);
      rect(width/6, height/6, width*2/3, height*2/3);
      fill(0);
      textAlign(CENTER, TOP);
      textSize(20);
      text(executiveOrders.get(chosen).name, width/2, height*2/3);
    }
  }

}