class Screen17 extends Screen {
  // Electoral Map

  String toString() {
    return "17";
  }

  void setScreen() {
    buttons = new Button[0];
  }

  void display() {
    super.display();

    eM.display();

  }

}
