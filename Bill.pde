class Bill {
  int[] ideas;
  String name;
  int weeklyCost;
  int initialCost;
  int billNumber;
  Congressman broughtBy;
  
  
  int status;//0: Committee, 1: House, 2: Senate, 3: Pres, 4: Veto, 5: Law
  int time;
  boolean isLaw;
  
  Bill() {
    ideas = new int[3];
    name = "Type name here";
  }
  
  boolean addIdea(int idea) {// returns if there was room in the bill for idea
    for (int i = 0; i < 3; i++)
      if (ideas[i] != 0) {
        ideas[i] = idea;
        return true;
      }
    return false;
  }
}
