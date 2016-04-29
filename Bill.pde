class Bill {
  int[] ideas;
  ArrayList<Integer> amendmentsH;
  ArrayList<Integer> amendmentsS;

  int[] constitutional;// Each idea has constitutional safety, 0-100
  int[] percentages;// amount of force put on each one
  String name;
  String[] billNumbers;// [0] is House, [1] is Senate
  int committee;
  Congressman sponsor;
  boolean presBacked;// The president created this bill

  int[] date;// the next date set for this bill [5, 4, 17] --> April 5 2017

  int originChamber;// chamber the bill started in
  boolean passedHouse;
  boolean passedSenate;
  boolean isLaw;

  int weeklyCost;
  int initialCost;
  /*
  0: House committee - has markup date
  1: Senate committee - has markup date
  2: House committee markup - has vote date
  3: Senate committee markup - has vote date
  4: House - has vote date
  5: Senate - has vote date
  6: Conference Committee - has vote date
  7: Pres - date is null
  8: Veto - has override date
  9: Law - date is null

  */

  /* The legislative process in this game:

  - Bills start in house or senate
    * House member puts it in the hopper, senator introduces it on the floor.
  - Bill is referred to the appropriate committee and it is placed on that committee's calendar
    * If a bill is not being acted upon a discharge petition of 218 votes can release it
  - The committee holds a markup session of the bill
  - If more than two changes are made it is a clean bill and gets a new number
  - They vote on the bill
  - Bill is put on the House Calendar, Speaker and Majority Leader decide when it comes to the floor
  - For Senate it is Legislative Calendar, or Executive Calendar for appointments and treaties, and Majority Leader sets calendar but majority of the Senate decides when
  - In the House riders are not allowed but in the Senate they are, and sometimes filibusters destroy a bill
  - If it is passed it goes to the other house, and if the bills are different in each house it goes to the Conference Committee to merge both.
  - Then it goes to the president
  - If it's vetoed it gets an override vote of 2/3rds

  */


  // Constructor
  // Precondition: variables need to be set
  // Postcondition: creates the Object
  Bill() {
    ideas = new int[3];
    for (int i = 0; i < 3; i++)
      ideas[i] = -1;
    percentages = new int[3];
    for (int i = 0; i < percentages.length; i++)
      percentages[i] = 50;
    constitutional = new int[3];
    name = "Type name here";
    sponsor = new Congressman("", "NY", 0, 0);
  }

  String toString() {
    return name;
  }

  // If the int idea is part of the bill
  // Precondition: ideas contains ints (or is empty) representing ideas from ideas.csv
  // Postcondition: returns true or false
  boolean contains(int idea) {
    for (int i = 0; i < 3; i++)
      if (ideas[i] == idea)
        return true;
    return false;
  }

  // adds an idea
  // Precondition: ideas is an array of ints with ideas, can be empty or full
  // Postcondition: if ideas isn't full, adds the idea
  boolean addIdea(int idea) {// returns if there was room in the bill for idea
    for (int i = 0; i < 3; i++)
      if (ideas[i] == -1 && !contains(idea)) {
        ideas[i] = idea;
        return true;
      }
    return false;
  }
  // removes an idea
  // Precondition: ideas is an array of ints with ideas, can be empty or full
  // Postcondition: idea is removed from ideas if it was in it, the hole is filled
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

  // sets the opinion held of this bill for all Congresspeople
  // Precondition: house and senate are arrays of Congressmen, socialism and liberalism are values of this class
  // Postcondition: every Congressperson has an opinion, 0-100, on this bill parallel to this in bills
  void addOpinions() {
    addHouseOpinions();
    addSenateOpinions();
  }

  // set the opinion held of this bill for house members
  // Precondition: house is an array of Congressmen, socialism and liberalism are values of this class
  // Postcondition: every house Congressman has an opinion, 0-100, on this bill parallel to this in bills
  void addHouseOpinions() {
    for (int i = 0; i < house.length; i++) {
      ArrayList<Integer> op = house[i].opinions;
      int initial = 100;
      initial -= pow(abs(house[i].socialism - avgSoc()), 2)*.005;
      initial -= pow(abs(house[i].liberalism - avgLib()), 2)*.005;
      op.add(initial);
      if (sponsor.party == house[i].party)
        op.set(op.size()-1, op.get(op.size()-1)+(int)(25*house[i].loyalty*.01));// 0 to 25
      else
        op.set(op.size()-1, op.get(op.size()-1)-(int)(25*house[i].loyalty*.01));// 0 to 25

      if (presBacked)
        op.set(op.size()-1, op.get(op.size()-1)+(int)((house[i].youApproval-50)*.2));// -10 to +10
      op.set(op.size()-1, constrain(op.get(op.size()-1), 0, 100));
      house[i].opinions = op;
    }
  }

  // set the opinion held of this bill for house members
  // Precondition: senate is an array of Congressmen, socialism and liberalism are values of this class
  // Postcondition: every senator has an opinion, 0-100, on this bill parallel to this in bills
  void addSenateOpinions() {
    for (int i = 0; i < senate.length; i++) {
      ArrayList<Integer> op = senate[i].opinions;
      int initial = 100;
      initial -= pow(abs(senate[i].socialism - avgSoc()), 2)*.005;
      initial -= pow(abs(senate[i].liberalism - avgLib()), 2)*.005;
      op.add(initial);
      if (sponsor.party == senate[i].party)
        op.set(op.size()-1, op.get(op.size()-1)+(int)(25*senate[i].loyalty*.01));// 0 to 25
      else
        op.set(op.size()-1, op.get(op.size()-1)-(int)(25*senate[i].loyalty*.01));// 0 to 25

      if (presBacked)
        op.set(op.size()-1, op.get(op.size()-1)+(int)((senate[i].youApproval-50)*.2));// -10 to +10
      op.set(op.size()-1, constrain(op.get(op.size()-1), 0, 100));
      senate[i].opinions = op;
  }
}

  // Have the president sign this Bill
  // Precondition: the player wishes to sign this bill into law, 5 is signed status
  // Postcondition: this is a law, and added to laws
  void sign() {
    isLaw = true;
    laws = (Bill[])append(laws, this);
  }

  // Precondition: chamber - 0 is house, 1 is senate, 2 is conference committee
  // Postcondition: edits the bill slightly in committee and returns the result described in a String
  String markup(int chamber, Congressman[] members) {
    return "";
  }

  String amend(int chamber) {
    return "";
  }

  // holds a vote in a chamber of Congress
  // Precondition: chamber of the house the vote is in, members voting
  // Postcondition: the bill is either passed or voted down, and returns a String response
  String vote(int chamber, String com, Congressman[] members) {// add committee? //
    String[] names = {"HR", "S", ""};
    String[] result = {" passed", " was voted down"};

    String markResults = markup(chamber, members);

    int yea = 0;
    int nay = 0;
    for (Congressman c : members) {
      if (random(c.loyalty*.01*c.termsInOffice*c.leadership) != 0) {/*if they are present*/
        if (true/*they vote for it*/) {
          yea++;
          c.votedFor.add(this);
        }
        else if (true/*they vote against it*/) {
          nay++;
          c.votedAgainst.add(this);
        }
      }
    }
    String place = "";
    if (com != null) {
      place = com+" Committee";
    }
    else {
      place = chambers[chamber];
    }

    return
    names[chamber]+billNumbers[chamber]+": "+name+result[constrain(nay-yea, 0, 1)]
    +" in the "+place+" with a vote of "+yea+"-"+nay+". "+markResults;
    // [HR/S]#: [Name] [passed/was voted down] in the [House/Senate/< > Committee] with a vote of yea-nay. [markup]
  }


  // Find average socialism rating of this Bill
  // Precondition: each idea has a socialism and liberalism value, percentages says how strong each idea will be
  // Postcondition: a Socialism rating is given, 0-100
  float avgSoc() {
    int x = 100;// Temparary values, I just hate going into Ideas
    int y = 25;//
    int z = 75;// ===========
    x *= percentages[0];
    y *= percentages[1];
    z *= percentages[2];
    return (x+y+z)/percentages[0]+percentages[1]+percentages[2];
  }
  // Find average liberalism rating of this Bill
  // Precondition: each idea has a socialism and liberalism value, percentages says how strong each idea will be
  // Postcondition: a Liberalism rating is given, 0-100
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
