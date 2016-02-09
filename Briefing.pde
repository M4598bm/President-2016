class Briefing {
  ArrayList<Integer> events;// Any important events that occured
  ArrayList<Bill> billsChangedStatus;// Any bills that changed status
  ArrayList<Integer> nationsSpoke;// Nations that want to meet
  ArrayList<Integer> reminders;// Elections coming up, budget, etc
  // Election details
  // Other election details
  ArrayList<Integer> scDecisions;// Supreme court decisions
  ArrayList<Integer> stateActions;// State level events
  ArrayList<Bill> billsOnDesk;// Reminder that these bills are on your desk

    /* Examples of news include:
       * How a speech went
       * Important events that happened and how you're going to treat them
       * Bills that went on floor this week
       * Bills that were denied this week
       * Nations that request a visit
       * When the next event is due (remember budget is soon, remember this goes into effect today
       * How your next election is going
       * How the next congressional election is going
       * Important Supreme Court cases coming up and recent decisions
       * Bills that you can sign or table
     */
  // Constructor
  // Precondition: tons of ArrayLists
  // Postcondition: creates the Object
  Briefing() {
    events = new ArrayList<Integer>();
    billsChangedStatus = new ArrayList<Bill>();
    nationsSpoke = new ArrayList<Integer>();
    reminders = new ArrayList<Integer>();
    scDecisions = new ArrayList<Integer>();
    stateActions = new ArrayList<Integer>();
    billsOnDesk = new ArrayList<Bill>();
  }

  void update() {
    // events haven't been done yet


  }



}