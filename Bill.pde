class Bill {
  int[] ideas;
  int[] percentages;// amount of force put on each one
  String name;
  int weeklyCost;
  int initialCost;
  int billNumber;
  int committee;
  Congressman broughtBy;
  boolean presBacked;// The president created this bill


  int status;//0: Committee, 1: House, 2: Senate, 3: Pres, 4: Veto, 5: Law
  int turnsHere;// committee gets infinite turns, house and senate 2 turns, pres 2 turns, veto 2 turns, law 0
  boolean isLaw;

  Bill() {
    ideas = new int[3];
    for (int i = 0; i < 3; i++)
      ideas[i] = -1;
    percentages = new int[3];
    for (int i = 0; i < percentages.length; i++)
      percentages[i] = 50;
    name = "Type name here";
    broughtBy = new Congressman("", "NY", 0);
  }

  String toString() {
    return name;
  }

  boolean contains(int idea) {
    for (int i = 0; i < 3; i++)
      if (ideas[i] == idea)
        return true;
    return false;
  }

  boolean addIdea(int idea) {// returns if there was room in the bill for idea
    for (int i = 0; i < 3; i++)
      if (ideas[i] == -1 && !contains(idea)) {
        ideas[i] = idea;
        return true;
      }
    return false;
  }
  boolean removeIdea(int idea) {
    if (ideas[0] == idea) {
      ideas[0] = ideas[1];
      ideas[1] = ideas[2];
      ideas[2] = -1;
      percentages[0] = percentages[1];
      percentages[1] = percentages[2];
      percentages[2] = 50;
    }
    else if (ideas[1] == idea) {
      ideas[1] = ideas[2];
      ideas[2] = -1;
      percentages[1] = percentages[2];
      percentages[2] = 50;
    }
    else if (ideas[2] == idea) {
      ideas[2] = -1;
      percentages[2] = 50;
    }
    else
      return false;
    return true;
  }

  void addOpinions() {
    for (int i = 0; i < house.length; i++) {
      ArrayList<Integer> op = house[i].opinions;
      int initial = 100;
      initial -= pow(abs(house[i].socialism - avgSoc()), 2)*.005;
      initial -= pow(abs(house[i].liberalism - avgLib()), 2)*.005;
      op.add(initial);
      if (broughtBy.party == house[i].party)
        op.set(op.size()-1, op.get(op.size()-1)+(int)(25*house[i].loyalty*.01));// 0 to 25
      else
        op.set(op.size()-1, op.get(op.size()-1)-(int)(25*house[i].loyalty*.01));// 0 to 25

      if (presBacked)
        op.set(op.size()-1, op.get(op.size()-1)+(int)((house[i].youApproval-50)*.2));// -10 to +10
      op.set(op.size()-1, constrain(op.get(op.size()-1), 0, 100));
    }
    for (int i = 0; i < senate.length; i++) {
      ArrayList<Integer> op = senate[i].opinions;
      int initial = 100;
      initial -= pow(abs(senate[i].socialism - avgSoc()), 2)*.005;
      initial -= pow(abs(senate[i].liberalism - avgLib()), 2)*.005;
      op.add(initial);
      if (broughtBy.party == senate[i].party)
        op.set(op.size()-1, op.get(op.size()-1)+(int)(25*senate[i].loyalty*.01));// 0 to 25
      else
        op.set(op.size()-1, op.get(op.size()-1)-(int)(25*senate[i].loyalty*.01));// 0 to 25

      if (presBacked)
        op.set(op.size()-1, op.get(op.size()-1)+(int)((senate[i].youApproval-50)*.2));// -10 to +10
      op.set(op.size()-1, constrain(op.get(op.size()-1), 0, 100));
    }
  }

  void sign() {
    status = 5;
    isLaw = true;
  }
  float avgSoc() {
    int x = 100;// Temparary values, I just hate going into Ideas
    int y = 25;//
    int z = 75;// ===========
    x *= percentages[0];
    y *= percentages[1];
    z *= percentages[2];
    return (x+y+z)/percentages[0]+percentages[1]+percentages[2];
  }
  float avgLib() {
    int x = 100;// Still also temp
    int y = 25;//
    int z = 75;// ===========
    x *= percentages[0];
    y *= percentages[1];
    z *= percentages[2];
    return (x+y+z)/percentages[0]+percentages[1]+percentages[2];
  }
}
