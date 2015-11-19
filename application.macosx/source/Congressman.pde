class Congressman {
  String name;
  int socialism;// 0 capitalist, 100 socialist
  int liberalism;// 0 conservative, 100 liberal
  int approval;// home approval rating
  float youApproval;// approval of you
  int strength;// how they stand under pressure
  int loyalty;// party loyalty
  
  char party;// 'D' or 'R'
  String state;// "NY", "RI", "CA", "TN", "ME", etc.
  //int district;// 0 is senator
  int committee;// 15 is none
  int nextElection;// 2018 and every 2 years for all house reps, split in threes for senators
  int funding;// how much money they have for the next election
  int house;// 0 if house of reps, 1 if senate
  ArrayList<Integer> opinions;//each represents bill # index on the floor, less than 33 is nay, more than 66 is yea
  
  // Deal related
  ArrayList<Integer> mustVoteFor;//made a deal to vote for these
  ArrayList<Integer> mustVoteAgainst;//made a deal to vote against these
  boolean endorsed;
  boolean attackable;
  
  // Leaders are chosen after elections (democrats "caucus" republicans have a "conference")
  int leadership;// 0 is none, 1 is leader, 2 is whip, 3 is speaker. 1 and 2 have majority or minority and senate or house
  
  Congressman(String n, String s, int h) {
    name = n;
    state = s;
    house = h;
    committee = (int)random(16);
    opinions = new ArrayList<Integer>();
  }
  
  void setPolitics(int s, int l, char p) {//, int d) {
    socialism = s;
    liberalism = l;
    party = p;
    //district = d;// I may not use district because of inaccuracies caused. Probably later
  }
  void changeName(String n) { name = n; }
  
  void setOpinion(int b) {
    
  }
  void listenToSpeech(ArrayList<Integer> support, ArrayList<Integer> against) {
    /*  if you like the pres you like his bills
        if you don't like the pres you don't like his bills
        if you don't like his bills you like him less
        if you like his bills you like him more
    */
    if (support.size() > 0)
      opinions.set(support.get(0), (int)(opinions.get(support.get(0))+(youApproval-50)/2));
    if (support.size() > 1)
      opinions.set(support.get(1), (int)(opinions.get(support.get(1))+(youApproval-50)/2));
    if (against.size() > 0)
      opinions.set(against.get(0), (int)(opinions.get(against.get(0))-(youApproval-50)/2));
    if (against.size() > 1)
      opinions.set(against.get(1), (int)(opinions.get(against.get(1))-(youApproval-50)/2));
    
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
  }
  
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