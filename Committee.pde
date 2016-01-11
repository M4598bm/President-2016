class Committee {
  String name;
  Congressman[] members;
  Congressman chairperson;
  Congressman rankingmember;
  Calendar cCalendar;
  ArrayList<Bill> cBills;

  int chamber;// 0 is house of reps, 1 is senate

  // create a new Committee
  // Precondition: String n is name, int size is the amount of people in the Committee
  // Postcondition: members array is set to size
  Committee(String n, int size, int ch) {
    name = n;
    chamber = ch;
    members = new Congressman[size+(int)random(-(size/4), size/4)];
    cCalendar = new Calendar();
    cBills = new ArrayList<Bill>();
  }

  // chooses who should be the leadership
  // Precondition: Seniority, party, and party favorability are factors
  // Postcondition: a chairperson and ranking member is set
  void pickLeadership() {

  }

  // puts a bill on the calendar
  // Precondition: Bill b is being considered.
  // Postcondition: The committee chairperson and ranking member set it on the calendar
  void putOnCalendar(Bill b) {

  }

  // hold a markup session on the bill
  // Precondition: Bill b is being considered.
  // Postcondition: Amendments are voted on, it is renumbered if there are substantial changes
  void markupSession(Bill b) {

  }

  // They vote on whether the bill should go to the floor
  // Precondition: Bill b is being considered.
  // Postcondition: Returns if it will go to the floor
  boolean holdVote(Bill b) {
    return true;
  }

}
