class Screen7 extends Screen {
  // Calandar

  String toString() {
    return "7";
  }

  void setScreen() {
    buttons = new Button[0];
    calendar.year = calendar.cYear;
    calendar.month = calendar.cMonth;
  }

  void display() {
    super.display();

    calendar.display();

  }

}
