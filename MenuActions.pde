class MenuActions {


  // deletes all variables (or autosaves?) and opens the main menu
  // Precondition: a game is open
  // Postcondition: the menu is open and all varialbes are null
  void openMainMenu() {
    mainMenu = true;
  }

  // Saves the currently opened version of the game
  // Precondition: name of the save, all variables in the game are Set
  // Postcondition: if this save exists in saves.csv it is overriden, else added
  void saveGame(String name) {

  }

  // Loads a saved version of the game
  // Precondition: name of the game to open, the name exists
  // Poscondition: all variables in the game are set for this save
  void loadGame(String name) {

  }

  // creates a new game
  // Precondition: all variables exist in President.pde, and the settings there have been set
  // Postcondition: all variables are preset
  void newGame() {
    turn = 0;

    setPresParty(parties);// Default is that Democrat is the presParty
    createSingleClasses();

    initCongress();
    createHouse();
    createSenate();
    setLeadership();
    setElectionCycles();

    createCommittees();
    createCabinet();
    createCourt();
    createStates();
    setOtherValues();

    loadImages();

    calcApproval();

    setNewScreen();

    // Temp
    //calendar.addEvent(31, 1, 17, "Bill1 goes to House floor");
    //calendar.addEvent(31, 1, 17, "Bill2 goes to Senate floor");
    //calendar.addEvent(12, 1, 17, "Bill3 goes to Senate floor");
    //calendar.addEvent(8, 1, 17, "Bill4 goes to Senate floor");


    displayAll();
  }



  // =================
  // New Game Methods:
  // =================


  // Sets up the two parties
  // Precondition: parties is a String array with .length == 2 where parties[0] is the
  //    President's party and parties[1] is the opposition (["Democratic", "Republican"])
  // Postcondition: you and them are new national committees for both parties
  void setPresParty(String[] parties) {
    println("setPresParty");
    presParty = parties[0].toLowerCase().charAt(0);
    you = new NationalCom(parties[0]);
    them = new NationalCom(parties[1]);

    you.administration = true;
    them.administration = false;
  }

  // Sets up any case of one instance of each class
  // Precondition: The variables with the class name created in President.pde
  // Postcondition: The variables are set
  void createSingleClasses() {
    println("createSingleClasses");
    // one of each class things
    menuScreen = new MenuScreen();
    calendar = new Calendar();
    houseCalendar = new Calendar();
    senateCalendar = new Calendar();
    fedBudget = new FedBudget();
    ideas = new Ideas();

    executiveOrders = new ExecutiveOrder[0];
    bills = new ArrayList<Bill>();
    hBills = new Bill[0];
    sBills = new Bill[0];
    yourDesk = new Bill[0];
    vetoBills = new Bill[0];
    deadBills = new Bill[0];
    laws = new Bill[0];
    house = new Congressman[435];
    senate = new Congressman[100];

    cabinet = new Secretary[15];
    scotus = new SCJustice[9];
  }

  // Sets other values that need to be set
  // Precondition: no precondition
  // Postcondition: The variables are set
  void setOtherValues() {
    // Needs to happen somewhere, don't worry about it.
    suppH = new ArrayList<Integer>();
    suppS = new ArrayList<Integer>();
    agH = new ArrayList<Integer>();
    agS = new ArrayList<Integer>();

    tempOrder = new ExecutiveOrder();
    tempOrder.president = "you";
  }

  // Sets up the Cabinet
  // Precondition: majordepartments.csv lists all of the major departments to have secretaries
  // Postcondition: cabinet is an array of Secretaries with only department set
  void createCabinet() {
    println("createCabinet");
    Table d = loadTable("majordepartments.csv", "header");
    for (int i = 0; i < cabinet.length; i++)
    cabinet[i] = new Secretary(d.getRow(i).getString(0), d.getRow(i).getString(1));
  }

  // Sets up the Supreme Court
  // Precondition:
  // Postcondition:
  void createCourt() {
    println("createCourt");

  }

  // Gives senators liberalism and socialism stats
  // Precondition: Senators have no liberalism or socialism stats
  // Postcondition: Senators have liberalism and socialism stats
  void createSenate() {
    println("createSenate");
    Table states = loadTable("states.csv", "header");// a table with states etc.
    int countDems = 0;
    int xSenate = 0;
    for (TableRow row : states.rows()) {
      if (!row.getString(1).equals("DC")) {
        //=== Senators ===//

        // PVI is the index for how liberal the state is. Negative is GOP and positive is Dem
        int PVI = Utils.convertInt(row.getString(2));

        // Set approval, youApproval (based on lib soc party and PVI (how well it matches) and strength)
        // Set termsInOffice (completely random)
        senate[xSenate].setPolitics(PVI);
        senate[xSenate+1].setPolitics(PVI);

        // Counting for the majority
        if (senate[xSenate].party == 'd') {
          countDems++;
        }
        if (senate[xSenate+1].party == 'd') {
          countDems++;
        }

        xSenate+=2;
      }
    }
    if (countDems > 50) {
      senateMajority = 'd';
    }
    else if (countDems == 50) {
      senateMajority = presParty;
    }
    else {
      senateMajority = 'r';
    }

  }


  // Gives Representatives liberalism and socialism stats
  // Precondition: Representatives have no liberalism or socialism stats
  // Postcondition: Representatives have liberalism and socialism stats
  void createHouse() {
    println("createHouse");
    Table states = loadTable("states.csv", "header");// a table with states etc.
    Table districts = loadTable("districts.csv", "header");// a table with states etc.
    int countDems = 0;
    int xHouse = 0;
    for (TableRow row : states.rows()) {
      if (!row.getString(1).equals("DC")) {
        for (int i = 0; i < Utils.convertInt(row.getString(3)); i++) {// row.getString(3) says how many reps in the state
          // PVI is the index for how liberal the district is. Negative is GOP and positive is Dem
          int districtPVI = Utils.convertInt(districts.getRow(xHouse).getString(3));

          house[xHouse].setPolitics(districtPVI);

          // Counting for the majority
          if (house[xHouse].party == 'd') {
            countDems++;
          }

          xHouse++;
        }
      }
    }
    if (countDems > 435/2) {
      houseMajority = 'd';
    }
    else {
      houseMajority = 'r';
    }
  }

  // Chooses leadership based on qualifications
  // Precondition: This is temp
  // Postcondition: Leadership set based on loyalty and age
  void setLeadershipSorting() {

    // Sort by age, then choose the people in order randomly based on loyalty

    // if (random(100-loyalty) < 1 && party is right && leadership != 0) { set the leadership }

  }


  // Chooses the leadership in Congress
  // Precondition: Congress is otherwise set
  // Postcondition: Speaker, whips, majority leader and minority leader set
  void setLeadership() {
    // based on loyalty and age

    /* For now I'm just choosing randomly */
    // Maybe sorting eventually?
    Congressman speaker = null;
    Congressman hMaj = null;
    Congressman hMin = null;
    Congressman hMajWhip = null;
    Congressman hMinWhip = null;
    Congressman sMaj = null;
    Congressman sMin = null;
    Congressman sMajWhip = null;
    Congressman sMinWhip = null;
    boolean done = false;
    while (!done) {
      done = true;
      speaker = house[(int)random(435)];
      if (speaker.party != houseMajority) {
        done = false;
      }
    }

    done = false;
    while (!done) {
      done = true;
      hMaj = house[(int)random(435)];
      hMin = house[(int)random(435)];
      sMaj = senate[(int)random(100)];
      sMin = senate[(int)random(100)];
      if (hMaj.party == hMin.party) {
        done = false;
      }
      if (sMaj.party == sMin.party) {
        done = false;
      }
    }

    done = false;
    while (!done) {
      done = true;
      hMajWhip = house[(int)random(435)];
      hMinWhip = house[(int)random(435)];
      sMajWhip = senate[(int)random(100)];
      sMinWhip = senate[(int)random(100)];
      if (hMajWhip.party == hMinWhip.party) {
        done = false;
      }
      if (sMajWhip.party == sMinWhip.party) {
        done = false;
      }
    }

    hMajWhip.leadership = 1;
    hMinWhip.leadership = 1;
    hMaj.leadership = 2;
    hMin.leadership = 2;
    speaker.leadership = 3;

    sMajWhip.leadership = 1;
    sMinWhip.leadership = 1;
    sMaj.leadership = 2;
    sMin.leadership = 2;
  }

  // Sets the election cycles
  // Precondition: Congress is otherwise set
  // Postcondition: Election cycles are set
  void setElectionCycles() {
    for (int i = 0; i < house.length; i++) {
      house[i].nextElection = 2018;
    }
    for (int i = 0; i < senate.length; i++) {
      senate[i].nextElection = 2018+(i%3)*2;//  2018, 2020, 2022
    }
  }

  // Initialize Congresspeople
  // Precondition: names.csv lists first and last names; states lists state info from states.csv and districts is from districts.csv
  // Postcondition: Both houses of congress have Congressmen with names, states, and house set
  void initCongress() {
    println("initCongress");

    Table states = loadTable("states.csv", "header");// a table with states etc.
    Table districts = loadTable("districts.csv", "header");// a table with states etc.
    Table names = loadTable("names.csv", "header");// A table that has first and last names
    ArrayList<String> firstNames = new ArrayList<String>();
    ArrayList<String> lastNames  = new ArrayList<String>();
    for (TableRow row : names.rows()) {
      firstNames.add(row.getString(0));
      lastNames.add(row.getString(1));
    }

    int xSenate = 0;
    int xHouse = 0;
    for (TableRow row : states.rows()) {
      if (!row.getString(1).equals("DC")) {
        // Initialize Senators
        String n = firstNames.remove((int)random(firstNames.size()))+" "+lastNames.remove((int)random(lastNames.size()));
        senate[xSenate] = new Congressman(n, row.getString(1), 1, 0);
        n = firstNames.remove((int)random(firstNames.size()))+" "+lastNames.remove((int)random(lastNames.size()));
        senate[xSenate+1] = new Congressman(n, row.getString(1), 1, 0);
        xSenate+=2;

        // Initialize Representatives
        for (int i = 0; i < Utils.convertInt(row.getString(3)); i++) {
          n = firstNames.remove((int)random(firstNames.size()))+" "+lastNames.remove((int)random(lastNames.size()));
          house[xHouse] = new Congressman(n, row.getString(0), 0, Utils.convertInt(districts.getRow(xHouse).getString(1)));
          house[xHouse].party = 'd';// why does this happen???
          xHouse++;
        }
      }
    }
  }

  // Test to check the makeup of congress
  // Precondition: senate and house are arrays of Congressmen that are initialized
  // Postcondition: Prints the makeup of each house of congress
  private void testCongress() {
    println("testCongress");
    int sDems = 0;
    int hDems = 0;
    int sSoc = 0;
    int sLib = 0;
    int hSoc = 0;
    int hLib = 0;
    println("Senate Majority: "+senateMajority);
    for (Congressman c : senate) {
      if (c.leadership == 1) {
        println("Senate Whip: "+c.name+" ("+c.party+")");
      }
      if (c.leadership == 2) {
        println("Senate Leader: "+c.name+" ("+c.party+")");
      }
      if (c.party == 'd') {
        sDems++;
      }
      sSoc += c.socialism;
      sLib += c.liberalism;
    }

    println("\nHouse Majority: "+houseMajority);
    for (Congressman c : house) {
      if (c.leadership == 1) {
        println("House Whip: "+c.name+" ("+c.party+")");
      }
      if (c.leadership == 2) {
        println("House Leader: "+c.name+" ("+c.party+")");
      }
      if (c.leadership == 3) {
        println("House Speaker: "+c.name+" ("+c.party+")");
      }
      if (c.party == 'd') {
        hDems++;
      }
      hSoc += c.socialism;
      hLib += c.liberalism;
    }
    println(sDems+"/100 ("+(sDems*100/100)+"%) in Senate");
    println(hDems+"/435 ("+(hDems*100/435)+"%) in House");
    println("\nSenate Soc: "+sSoc/100);
    println("Senate Lib: "+sLib/100);
    println("\nHouse Soc: "+hSoc/435);
    println("House Lib: "+hLib/435);
  }



  // creates committees in both houses
  // Precondition: housecommittees.csv and senatecommittees.csv contain committee info
  // Postcondition: two arrays of committees are setup
  void createCommittees() {
    Table h = loadTable("housecommittees.csv", "header");
    Table s = loadTable("senatecommittees.csv", "header");

    conferenceComs = new Committee[0];
    houseCommittees = new Committee[h.getRowCount()];
    senateCommittees = new Committee[s.getRowCount()];

    for (int i = 0; i < h.getRowCount(); i++) {
      TableRow r = h.getRow(i);
      houseCommittees[i] = new Committee(r.getString(0), Utils.convertInt(r.getString(1)), 0);
      // put in members to committee
      for (int j = 0; j < houseCommittees[i].members.length; j++)
      houseCommittees[i].members[j] = house[(int)random(435)];
      // ^ ^ Temp ^ ^
    }
    for (int i = 0; i < s.getRowCount(); i++) {
      TableRow r = s.getRow(i);
      senateCommittees[i] = new Committee(r.getString(0), Utils.convertInt(r.getString(1)), 1);
      // put in members to committee
      for (int j = 0; j < senateCommittees[i].members.length; j++)
      senateCommittees[i].members[j] = senate[(int)random(100)];
      // ^ ^ Temp ^ ^
    }
  }

  // Creates the states with statistics
  // Precondition: states.csv has info, states is an array of State objects
  // Postcondition: all State objects are initialized
  void createStates() {
    println("createStates");
    states = new State[50];
    for (int i = 0; i < states.length; i++) {
      states[i] = new State(i);
    }
  }


  // Loads all images necessary to the game
  // Precondition: any images needed for the whole game are stored as variables
  // Postcondition: load all images and set the variables to them
  void loadImages() {
    println("loadImages");
    // The Electoral Map thing only sorta belongs here
    eM = new ElectoralMap();// move this to createSingleClasses()

    // This should use requestImage() it's apparently better

    // Eventually all other images will be loaded.
  }

  // calculates the current presidential approval rate
  // Precondition: This isn't a finished method so I don't really know yet
  // Postcondition: Approval is a percentage between 0 - 100
  void calcApproval() {
    println("calcApproval");
    approval = 50;// Temporary, eventually there will be a calculation here.
  }

  // Creates the starting screen in the game
  // Precondition: The whole new game is set up
  // Poscondition: The screen is set to a new game screen
  void setNewScreen() {
    // Default screen that it starts with atm
    screen = new Screen0();
    // ======================================

    screen.setScreen();

    screens = new ArrayList<Screen>();
    screens.add(screen);
  }

}
