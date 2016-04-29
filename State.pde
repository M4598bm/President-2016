class State {
  String name;// ful name (New York, California, New Jersey)
  String abvName;// abbreviated name (NY, CA, NJ)
  int population;// number of citizens
  int districtCount;// number of congressional districts

  int pvi;
  int[] districtPVIs;
  Politician governor;
  int[][] citizens;// each row is [party, lib, soc, anger, loyalty, apathy, rationality, district]

  // list other stats to make events more and less likely
  State(int stateNum) {
    // load state stats
    TableRow state = loadTable("states.csv", "header").getRow(stateNum);

    name = state.getString(0);
    println(name);
    abvName = state.getString(1);
    population = Utils.convertInt(state.getString(4));
    pvi = Utils.convertInt(state.getString(2));
    districtCount = Utils.convertInt(state.getString(3));
    districtPVIs = getDistrictPVIs();

    setStatePolitics();

    // choose gov and other stats. maybe include them in a TableRow
  }

  // sets the political climate of the state
  // Precondition: population and other stats are set
  // Postcondition: the array citizens is set
  void setStatePolitics() {
    citizens = new int[population][8];
    for (int[] c : citizens) {
      char party = '0';
      char[] p = {'d', 'r', 'i'};
      // temp.....
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
      // ====
      c[0] = (int)party;
      c[1] = constrain(pvi+50+(int)(random(10)+random(10)-10), 0, 100);
      c[2] = constrain(pvi+50+(int)(random(10)+random(10)-10), 0, 100);
      c[3] = (int)(random(100)+random(100));
      c[4] = (int)(random(100)+random(100));
      c[5] = (int)(random(100)+random(100));
      c[6] = (int)(random(100)+random(100));
      c[7] = (int)(random(distictCount)+1);
    }
  }

  // gets an array of district PVIs where district number = i+1
  // Precondition: districts.csv contains pvi of all the districts in the country in getString(3)
  // Poscondition: an int[] of district PVIs in order of districts
  int[] getDistrictPVIs() {
    Table districts = loadTable("districts.csv", "header");
    int[] PVIs = new int[districtCount];
    int x = 0;
    for (int i = 0; i < districts.getRowCount(); i++) {
      if (districts.getRow(i).getString(1).equals(abvName)) {
        PVIs[x++] = Utils.convertInt(districts.getRow(i).getString(3));
      }
    }
    return PVIs;
  }

  // decide who to vote for out of a candidate array (individual person)
  // Precondition: citizen is who is voting, choices is an array of politicians to choose from
  // Postcondition: returns index of the voted for candidate
  private int vote(int[] citizen, Politician[] choices) {
    // [party, lib, soc, anger, loyalty, apathy]
    char party = (char)citizen[0];
    int liberalism = citizen[1];
    int socialism = citizen[2];
    int loyalty = citizen[4];
    int apathy = citizen[5];
    int rationality = citizen[6];
    if (random(100) < apathy) {
      int[] op = new int[choices.length];
      for (int i = 0; i < choices.length; i++) {
        op[i] -= abs(socialism - choices[i].socialism) - abs(liberalism - choices[i].liberalism);
        if (choices[i].party == party && random(100) < loyalty) {
          // if they're rational they'll vote for what their partyLoyalty tells them
          op[i] += random(rationality)+random(rationality);
        }
      }
      for (int i = 0; i < choices.length; i++) {
        if (op[i] == max(op)) {
          return i;
        }
      }
    }// else:
    return -1;
  }

  // the whole state will vote
  // Precondition: choices is an array of politicians, district is the district voting (0 is none)
  // Postcondition: returns an array with votes corresponding to each choice
  int[] stateVote(Politician[] choices, int district) {
    int[] votes = new int[choices.length];
    for (int[] c : citizens) {
      if (district == 0 || district == c[7]) {
        int v = vote(c, choices);
        if (v != -1) {
          votes[v]++;
        }
      }
    }
    return votes;
  }


  Constituent[] findDistrictConstituents(int d) {
    Constituent[] distCons = new Constituent[0];
    for (Constituent c : citizens) {
      if (c.district == d) {
        distCons = (Constituent[])append(distCons, c);
      }
    }
    return distCons;
  }


}
