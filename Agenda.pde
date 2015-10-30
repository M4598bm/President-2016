class Agenda {
  ArrayList<Integer> events;
  ArrayList<Bill> billsChangedStatus;
  ArrayList<Bill> billsDenied;
  ArrayList<Integer> nationsSpoke;
  ArrayList<Integer> reminders;
  // Election details
  // Other election details
  ArrayList<Integer> scDecisions;
  ArrayList<Bill> billsOnDesk;
  
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
  Agenda() {
    events = new ArrayList<Integer>();
    billsChangedStatus = new ArrayList<Bill>();
    billsDenied = new ArrayList<Bill>();
    nationsSpoke = new ArrayList<Integer>();
    reminders = new ArrayList<Integer>();
    scDecisions = new ArrayList<Integer>();
    billsOnDesk = new ArrayList<Bill>();
  }
  
  void update() {
    // events haven't been done yet
    
    
  }
  
  
     
}