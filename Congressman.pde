class Congressman extends Politician {
  // All are out of 100
  int approval;// home approval rating
  int termsInOffice;// How many terms this Congressman has served in current house

  int[] polling;// [this percentage, opponent percentage]

  int nextElection;// 2018 and every 2 years for all house reps, split in threes for senators
  int ncFunds;// how much money they get from the (D/R)NC
  int house;// 0 if house of reps, 1 if senate
  Politician opponent;// Who's running against them

  ArrayList<Integer> opinions;//each represents bill # index on the floor, less than 33 is nay, more than 66 is yea
  ArrayList<Bill> votedFor;// all bills this congressman has ever voted for
  ArrayList<Bill> votedAgainst;// all bills this congressman has ever voted against

  // Deal related
  ArrayList<Integer> mustVoteFor;//made a deal to vote for these
  ArrayList<Integer> mustVoteAgainst;//made a deal to vote against these
  boolean endorsed;
  boolean attackable;

  // Leaders are chosen after elections (democrats "caucus" republicans have a "conference")
  int leadership;// 0 is none, 1 is whip, 2 is leader, 3 is speaker. 1 and 2 have majority or minority and senate or house

  // Constructor
  // Precondition: n is name, s is state, h is house of congress
  // Postcondition: creates the Object
  Congressman(String n, String s, int h, int d) {
    name = n;
    state = s;
    house = h;
    district = d;
    opinions = new ArrayList<Integer>();
    polling = new int[2];
  }

  // Creates an opponent for this congressperson to run against
  // Precondition: this is a fully set Congressperson and pvi is politics of the state
  // Postcondition: opponent is a fully set Politician
  void setOpponent(int pvi) {
    opponent = new Politician();

  }


  // Sets the political stance
  // Precondition: PVI is positive for liberal, negative for conservative
  // Postcondition: the political values are set in this object
  void setPolitics(int pvi) {
    // party, liberalism, socialism, strength, loyalty, funding are set

    //==== PARTY ====//
    if (pvi > 0) {
      party = 'd';
      if ((int)random(pvi+2) == 0) {// The bigger the pvi the less of a chance it will differ
        party = 'r';
      }
    }
    else {// includes 0 bc there's a 50% chance it switches, bc of +2
      party = 'r';
      if ((int)abs(random(pvi+2)) == 0) {// The more negative the pvi the less of a chance it will differ
        party = 'd';
      }
    }

    //==== VALUES ====//
    liberalism = constrain(pvi+50+(int)(random(10)+random(10)-10), 0, 100);
    socialism = constrain(pvi+50+(int)(random(10)+random(10)-10), 0, 100);
    if (random(20) < 1) {
      liberalism = (int)(random(50)+random(50));
    }// either the value is set normally or it's set randomly
    if (random(20) < 1) {
      socialism = (int)(random(50)+random(50));
    }

    //==== PERSONALITY ====//
    strength = (int)(random(50)+random(50));
    loyalty = (int)(random(50)+random(50));
    ambition = (int)(random(50)+random(50));

    //==== APPROVAL ====//
    approval = constrain((int)(strength+random(10)+random(10)), 0, 100);
    int dev = (int)((abs(liberalism-pvi)+abs(socialism-pvi))/2);
    approval = max(approval-dev, 0);

    if (party == presParty) {
      youApproval = constrain(50+int(loyalty/2)+(int)(random(20)+random(20))-20, 0, 100);
    }
    else {// loyalty and party decide how much you are liked, then values is considered
      youApproval = constrain(50-int(loyalty/2)+(int)(random(20)+random(20))-20, 0, 100);
    }
    dev = (int)((abs(liberalism-presLib)+abs(socialism-presSoc))/2);
    youApproval = max(approval-dev, 0);

    setFunding();
    setTermsInOffice();
    setOpponent(pvi);
  }

  // sets the funding based on values
  // Precondition: setPolitics has been called and leadership has been chosen
  // Postcondition: funding and ncFunds are set based on lib soc party fundStrength and PVI (how well it matches)
  void setFunding() {
    if (house == 0) {// avg 2,000,000 max 20,000,000
      funding = (int)(1800*((fundStrength+approval)*.01))+(int)random(500);
      funding += leadership*4000+(int)random(1000);
      ncFunds = (int)(200*(loyalty*.02))+(int)random(100);
      ncFunds += leadership*500+(int)random(300);
    }
    if (house == 1) {// avg 10,000,000 max 50,000,000
      funding = (int)(8000*((fundStrength+approval)*.01))+(int)random(1000);
      funding += leadership*10000+(int)random(5000);
      ncFunds = (int)(2000*(loyalty*.02))+(int)random(500);
      ncFunds += leadership*1000+(int)random(500);
    }
  }

  // set terms in office
  // Precondition: loyalty and approval are set
  // Postcondition: terms in office are set
  void setTermsInOffice() {
    int yio = 0;// years in office
    boolean inOffice = true;
    for (int i = 0; i < 60 && inOffice; i++) {
      if (random((fundStrength+approval)/2) < 5) {
        inOffice = false;
      }
      yio++;
    }

    if (house == 0) {
      termsInOffice = (int)(yio/2);
    }
    else {
      termsInOffice = (int)(yio/6);
    }
  }

  //===========================================//
  //===========================================//
  //=============Real Methods==================//
  //===========================================//
  //===========================================//



  // Listens and reacts to a speech that the president made about bills
  // Precondition: support and against are lists of bills to respond to, party is an important factor
  // Postcondition: If the Congressman likes the president it will align itself, else it will follow the opposite
  int listenToSpeech(ArrayList<Integer> support, ArrayList<Integer> against) {
    /*  if you like the pres you like his bills
        if you don't like the pres you don't like his bills
        if you don't like his bills you like him less
        if you like his bills you like him more
    */
    int total = 0;
    int divisor = 0;
    if (support.size() > 0) {
      int b4 = opinions.get(support.get(0));
      opinions.set(support.get(0), (int)(opinions.get(support.get(0))+(youApproval-50)/2));
      total += opinions.get(support.get(0)) - b4;
      divisor++;
    }
    if (support.size() > 1) {
      int b4 = opinions.get(support.get(1));
      opinions.set(support.get(1), (int)(opinions.get(support.get(1))+(youApproval-50)/2));
      total += opinions.get(support.get(1)) - b4;
      divisor++;
    }
    if (against.size() > 0) {
      int b4 = opinions.get(against.get(0));
      opinions.set(against.get(0), (int)(opinions.get(against.get(0))-(youApproval-50)/2));
      total += b4 - opinions.get(against.get(0));
      divisor++;
    }
    if (against.size() > 1) {
      int b4 = opinions.get(against.get(1));
      opinions.set(against.get(1), (int)(opinions.get(against.get(1))-(youApproval-50)/2));
      total += b4 - opinions.get(against.get(1));
      divisor++;
    }

    if (support.size() > 0) {// if this.soc = 70 and bill.avgsoc = 100 it should start to go down
      youApproval -= pow(abs(socialism - bills.get(support.get(0)).avgSoc())*.01, 2)*5-.45;
      youApproval -= pow(abs(liberalism - bills.get(support.get(0)).avgLib())*.01, 2)*5-.45;
    }
    if (support.size() > 1) {
      youApproval -= pow(abs(socialism - bills.get(support.get(1)).avgSoc())*.01, 2)*5-.45;
      youApproval -= pow(abs(liberalism - bills.get(support.get(1)).avgLib())*.01, 2)*5-.45;
    }
    if (against.size() > 0) {
      youApproval += pow(abs(socialism - bills.get(against.get(0)).avgSoc())*.01, 2)*5-.45;
      youApproval += pow(abs(liberalism - bills.get(against.get(0)).avgLib())*.01, 2)*5-.45;
    }
    if (against.size() > 1) {
      youApproval += pow(abs(socialism - bills.get(against.get(1)).avgSoc())*.01, 2)*5-.45;
      youApproval += pow(abs(liberalism - bills.get(against.get(1)).avgLib())*.01, 2)*5-.45;
    }

    // return the average
    return total/divisor;
  }

  // Vote on a bill
  // Precondition: b is the bill number being voted on. They must vote for, against, or not vote
  // Postcondition: posts true or false (maybe not forever bc there's not voting option) deciding how to vote
  boolean vote(int b) {// true is yea, false is nay //
    int op = opinions.get(b);
    if (mustVoteFor.contains(b))// add strength (stronger people may resist)
      return true;
    else if (mustVoteAgainst.contains(b))
      return false;

    else if (op > 65) {// add strength to the equation
      if (random(op-64) > 1)
        return true;
      return false;
    }
    else if (op < 34) {
      if (random(35-op) > 1)
        return false;
      return true;
    }
    // I have to figure out the rest of it, it's going to be sort of random but how?? How to make it more random than before??
   // else if (op < 50) {
   //   if (random((51-op)/4) > 1)
   //     return false;
     if (random(2) < 1)
       return true;
     return false;

   }

}
