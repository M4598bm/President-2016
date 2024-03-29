class NationalCom {
  String party;
  int funds;//   in millions
  int presFunds;
  int[] statePresFunds;
  boolean administration;// if it's the president's party


  /* Funding:
    NC budget - http://www.fec.gov/disclosure/partySummary.do
    Pres camp - http://www.washingtonpost.com/wp-srv/special/politics/campaign-finance/
    
  */

  // Constructor
  // Precondition: p is the party to make it the Republican National Committee or the Democratic National Committee
  // Postcondition: creates the Object
  NationalCom(String p) {
    party = p;
    funds = 100;
    statePresFunds = new int[50];
  }

  // Display the screen for the national committee
  // Precondition: The variables are set to display
  // Postcondition: The screen displays the national committee facts
  void display() {
    /*
      - statistics for after next election at this point
      - the congresspeople stacked in a table
        * name
        * state
        * district or 'sen.'
        * approval
        * polling (them-opponent)
        * funding
      - amount used for your campaign
      - avaliable funding
    */


    /* needs to be split into something probably region:
        * New England:
        * Southeast:
        * Midwest:
        * South:
        * Southwest:
        * Northwest:
        * California:

      */

  }

  // returns whether this is the administration's committee
  // Precondition: administration is a boolean
  // Postcondition: returns true or false
  boolean isAdmin() {
    return administration;
  }
}
