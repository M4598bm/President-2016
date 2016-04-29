static final String[] titles = {
  "Results from last turn",
  "Legislation Update",
  "State News",
  "Supreme Court",
  "Intelligence",
  "International Relations",
  "Reminders",
  "Elections",
  "Important Events",
  "Notable quotes from this week"
};
static final int MAX_CURR = 9;

class Briefing {
  Table news;// Holds all news to be told for this briefing
  int curr;// current displayed news

  // [1]: String type, [2]: String message
  // Example: [1]: "Bill", [2]: "Affordable Care Act was passed in the house. it moves to the senate"
  /*
    Types:
      * 0) Result (from last turn)
        - speech
        - UN speech
        -
      * 1) Bill
        - 1
        - 2
        - 3
      * 2) States
        -
      * 3) Supreme court
        -
      * 4) Intelligence
        - Requested
        - Important
      * 5) International correspondence
        - request
        - you request response
      * 6) Reminder
        - New stats
        - Election update
      * 7) Election (Results)
        -
      * 8) Event (Will have a response option)
        -
      * 9) Quotes (from people to see what kinds of things are going on)
        -
  */


  // Constructor
  // Precondition: tons of ArrayLists
  // Postcondition: creates the Object
  Briefing() {
    news = new Table();
    news.addColumn("type");
    news.addColumn("message");
  }

  // returns the curr title
  // Precondition: curr is set
  // Postcondition: Returns title index curr
  String toString() {
    return titles[curr];
  }

  // adds news to the Briefing
  // Precondition: news is set and titles is set
  // Postcondition: returns if it adds an entry titles[t] and msg to news if index t is appropriate
  boolean addNews(int t, String msg) {
    if (t >= 0 && t < titles.length) {
      TableRow r = news.addRow();
      r.setString("type", titles[t]);
      r.setString("message", msg);
      return true;
    }
    return false;
  }

  // gets news pertaining to curr
  // Precondition: news is set and curr is not more than titles.length
  // Postcondition: Returns ArrayList with all messages to be displayed
  ArrayList<String> getNews() {
    ArrayList<String> n = new ArrayList<String>();

    for (TableRow tr : news.rows()) {
      if (tr.getString(0).equals(titles[curr])) {
        n.add(tr.getString(1));
      }
    }
    return n;
  }




  //===================================================//
  //===================================================//
  //================ Next Turn Methods ================//
  //===================================================//
  //===================================================//




  // This method progresses the game by setting up the next turn.
  // Precondition: The Next Turn button has been pressed, and values need to be reset
  // Postcondition: Values are reset and the events of the turn are set
  void nextTurn() {
    // Next day
    setCalendars();

    // React to last turn
    reactToSpeeches();

    // Bills
    moveBills();
    newBills();

    // States actions
    stateActions();

    // scotus
    scotusActions();

    // Intelligence
    internationalEvents();
    securityBriefing();

    // International Correspondence
    respondToRequests();

    // Reminders
    createReminders();

    // election Results
    holdElections();

    // events
    createRandomEvents();

    // quotes
    createQuotes();

    // reset values for the next turn
    resetForTurn();
  }

  // This moves time forward once each turn
  // Precondition: The calendars are outdated
  // Postcondition: the day, month, and year are up to date and forward DAYS_PER_TURN days
  void setCalendars() {
    calendar.setDayNewTurn();
    houseCalendar.setDayNewTurn();
    senateCalendar.setDayNewTurn();
    for (Committee com : houseCommittees) {
      com.cCalendar.setDayNewTurn();
    }
    for (Committee com : senateCommittees) {
      com.cCalendar.setDayNewTurn();
    }
  }

  // React to speeches
  // Precondition: congressmen are set
  // Postcondition: speech reactions are set and a report is made to the briefing
  void reactToSpeeches() {
    // Senate
    if (suppS.size() != 0 || agS.size() != 0) {
      int balance = 0;
      for (int i = 0; i < senate.length; i++) {
        balance += senate[i].listenToSpeech(suppS, agS);
      }
      String msg = "Your speech to the Senate was "+getReaction(balance);
      addNews(0, msg);
    }
    // House of reps
    println("SIZE: "+suppH.size());
    if (suppH.size() != 0 || agH.size() != 0) {
      int balance = 0;
      for (int i = 0; i < house.length; i++) {
        balance += house[i].listenToSpeech(suppH, agH);
      }
      String msg = "Your speech to the House was "+getReaction(balance);
      addNews(0, msg);
    }

    // UN

  }
  // returns the reaction given
  // Precondition: no precondition
  // Postcondition: The string that should be added
  String getReaction(int val) {
    if (val > 10) {
      return "hugely successful!";
    }
    else if (val > 0) {
      return "mildly successful.";
    }
    else if (val < -10) {
      return "hugely unsuccessful!";
    }
    else if (val < 0) {
      return "mildly unsucessful.";
    }
    return "";
  }

  // deal with bills each time
  // Precondition: Bills exist
  // Postcondition: All bills have progressed if they had an event and a report is made
  void moveBills() {
    /* Places for a bill to be:
        * Bills
        * houseCommittees[i].cBills - markup, vote
        * senateCommittees[i].cBills - markup, vote
        * confrenceComs[i].cBills - markup, vote
        * hBills - markup, vote
        * sBills - markup, vote
        * yourDesk - sign
        * vetoBills - vote
    */

    Committee[][] comArrays = {houseCommittees, senateCommittees, conferenceComs};

    for (int i = 0; i < comArrays.length; i++) {
      for (Committee c : comArrays[i]) {
        for (Bill b : c.cBills) {
          if (dateInInterval(b.date, DAYS_PER_TURN)) {
            // Committee bills:
            addNews(1, b.vote(i, c.name, c.members));
          }
        }
      }
    }

    Bill[][] houses = {hBills, sBills};
    Congressman[][] congress = {house, senate};

    for (int i = 0; i < houses.length; i++) {
      for (Bill b : houses[i]) {
        if (dateInInterval(b.date, DAYS_PER_TURN)) {
          // Chamber bills:
          addNews(1, b.vote(i, null, congress[i]));
        }
      }
    }

    for (Bill b : yourDesk) {
      if (dateInInterval(b.date, DAYS_PER_TURN)) {
        // On your desk bills:
        addNews(1, "A bill, "+b.name+
        ", has passed in Congress and made it to your desk. Decide whether to sign it into law or veto it:");
      }
    }
    for (Bill b : vetoBills) {
      if (dateInInterval(b.date, DAYS_PER_TURN)) {
        // Vetoed bills:
        addNews(1, "A bill, "+b.name+
        ", ");
      }
    }
  }

  // handles the new bills that come into play this turn
  // Precondition: new turn
  // Postcondition: the tempBill is dealt with and the computer creates new bills
  void newBills() {
    // do something with tempBill:
    if (tempBill != null) {
      if (tempBill.originChamber == 0) {
        if (houseCommittees[tempBill.committee].putOnCalendar(tempBill)) {
          addNews(1, "A new bill, "+tempBill.name+
          ", has been placed on the calendar for the House "+houseCommittees[tempBill.committee].name+
          " Committee. It will be introduced on "+tempBill.date[1]+"/"+tempBill.date[0]+"/"+tempBill.date[2]);
        }
        else {
          // Discharge petition?
        }
      }
      else /** (originChamber == 1) */ {
        if (senateCommittees[tempBill.committee].putOnCalendar(tempBill)) {
          addNews(1, "A new bill, "+tempBill.name+
          ", has been placed on the calendar for the Senate "+houseCommittees[tempBill.committee].name+
          "Committee. It will be introduced on "+tempBill.date[1]+"/"+tempBill.date[0]+"/"+tempBill.date[2]);
        }
      }
    }

    // new bills the computer writes:
  }


  void stateActions() {

  }

  void scotusActions() {

  }

  void internationalEvents() {

  }

  void securityBriefing() {

  }

  void respondToRequests() {

  }

  void createReminders() {
    /* Reminds of:
        * election coming up
        *
    */
  }

  // hold elections for a house of Congress
  // Precondition: c is chamber of congress (0 house, 1 senate)
  // Postcondition: finds winners for each race and adds a briefing entry
  void holdCongressElections(int ch) {
    if (/*it's election day*/true) {// election day is the Tuesday after the first Monday in November (how do I test that...)
      Congressman[][] chambers = {house, senate};
      int partyWins = 0;
      int partyLoss = 0;
      for (Congressman c : chambers[ch]) {
        if (c.nextElection == calendar.cYear) {
          int[] results = c.reelection();
          if (c.party == presParty) {
            if (results[0] > results[1]) {
              partyWins++;
            }
            else {
              partyLoss++;
            }
          }
          else {
            if (results[0] > results[1]) {
              partyLoss++;
            }
            else {
              partyWins++;
            }
          }
        }
      }// election briefing
      String[] cNames = {"Congressional", "Senatorial"};
      String[] houses = {"House", "Senate"}
      String msg = "This week, "+cNames[ch]+" elections were held. ";
      if (partyWins > partyLoss) {
        msg += "Your party won more seats than it lost in the "+houses[ch]+", losing "+partyLoss+" but gaining "+partyWins+". ";
        msg += "The "+presParty+" party will have a "+congressPartyCount(ch, true)[0]-congressPartyCount(ch, true)[1]
        +"person advantage in the "+houses[ch]+" in the next session, which begins in January.";// Give exact date
      }
      briefing.addNews(7, msg);
    }
  }

  void createRandomEvents() {

  }

  void createQuotes() {

  }

  // handles any resetting required in a new turn
  // Precondition: new turn
  // Postcondition: values are reset
  void resetForTurn() {
    tempBill = null;

    suppH = new ArrayList<Integer>();
    suppS = new ArrayList<Integer>();
    agH = new ArrayList<Integer>();
    agS = new ArrayList<Integer>();
    // sync the main calendar to the others
  }

}
