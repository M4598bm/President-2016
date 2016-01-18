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

    createCommittees();
    createCabinet();
    createCourt();
    createOther();

    loadImages();

    calcApproval();

    displayAll();
  }


}
