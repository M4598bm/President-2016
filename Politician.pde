class Politician {
  String name;

  String state;// abbreviation (ex. NY, CA)
  int district;// 0 is senator
  char party;// d, r, i

  int socialism;// 0 capitalist, 100 socialist
  int liberalism;// 0 conservative, 100 socially liberal

  int youApproval;// approval of you
  int strength;// how they stand under pressure
  int fundStrength;// how well they can raise funds
  int loyalty;// party loyalty
  int ambition;// how much they want to get ahead

  int funding;// how much money they have for the next election without NC funding

  int[] lastElectionResults;// the results of the last election this politician was in

  // Methods:


  Politician(String s, int d) {
    state = s;
    district = d;
  }

  // find the state this congressperson is from
  // Precondition: state is an abbreviation
  // Postcondition: returns the state object
  State findState() {
    for (State s : states) {
      if (s.abvName.equals(this.state)) {
        return s;
      }
    }
    return new State(0);
  }

  // Sets the political stance
  // Precondition: PVI is positive for liberal, negative for conservative
  // Postcondition: the political values are set in this object
  void setPolitics(int pvi) {
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
    ambition = (int)(random(50)+random(50));
    loyalty = (int)(random(50)+random(50));
  }
}
