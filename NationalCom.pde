class NationalCom {
  String party;
  int funds;//   in millions
  int presFunds;
  int[] statePresFunds;
  boolean administration;// if it's the president's party
  
  NationalCom(String p) {
    party = p;
    funds = 100;
    statePresFunds = new int[50];
  }
  
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
    textAlign(CENTER, CENTER);
    textSize(16);
    text("Funds available for this year: ", width/2, 40);
    text("Funds reserved for your Presidential Campaign for this year: ", width/2, 60);
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
  
  boolean isAdmin() {
    return administration;
  }
}