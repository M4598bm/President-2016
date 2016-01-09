class ExecutiveOrder {
  int[] ideas;
  ArrayList<Integer> amendments;

  int[] constitutional;// Each idea has constitutional safety, 0-100
  int[] percentages;// amount of force put on each one
  String name;
  int orderNumber;
  int weeklyCost;
  int initialCost;

  String president;
  String dateSigned;// "04/05/17"

  // Constructor
  // Precondition: variables need to be set
  // Postcondition: creates the Object
  ExecutiveOrder() {
    ideas = new int[3];
    for (int i = 0; i < 3; i++)
      ideas[i] = -1;
      percentages = new int[3];
    for (int i = 0; i < percentages.length; i++)
      percentages[i] = 50;
    constitutional = new int[3];
    name = "Type name here";
  }

  String toString() {
    return name;
  }

  // If the int idea is part of the bill
  // Precondition: ideas contains ints (or is empty) representing ideas from ideas.csv
  // Postcondition: returns true or false
  boolean contains(int idea) {
    for (int i = 0; i < 3; i++)
      if (ideas[i] == idea)
        return true;
    return false;
  }

  // adds an idea
  // Precondition: ideas is an array of ints with ideas, can be empty or full
  // Postcondition: if ideas isn't full, adds the idea
  boolean addIdea(int idea) {// returns if there was room in the bill for idea
    for (int i = 0; i < 3; i++)
      if (ideas[i] == -1 && !contains(idea)) {
        ideas[i] = idea;
        return true;
      }
    return false;
  }
  // removes an idea
  // Precondition: ideas is an array of ints with ideas, can be empty or full
  // Postcondition: idea is removed from ideas if it was in it, the hole is filled
  boolean removeIdea(int idea) {
    if (ideas[0] == idea) {
      ideas[0] = ideas[1];
      ideas[1] = ideas[2];
      ideas[2] = -1;
      percentages[0] = percentages[1];
      percentages[1] = percentages[2];
      percentages[2] = 50;
    }
    else if (ideas[1] == idea) {
      ideas[1] = ideas[2];
      ideas[2] = -1;
      percentages[1] = percentages[2];
      percentages[2] = 50;
    }
    else if (ideas[2] == idea) {
      ideas[2] = -1;
      percentages[2] = 50;
    }
    else
      return false;
    return true;
  }



  // Find average socialism rating of this Bill
  // Precondition: each idea has a socialism and liberalism value, percentages says how strong each idea will be
  // Postcondition: a Socialism rating is given, 0-100
  float avgSoc() {
    int x = 100;// Temparary values, I just hate going into Ideas
    int y = 25;//
    int z = 75;// ===========
    x *= percentages[0];
    y *= percentages[1];
    z *= percentages[2];
    return (x+y+z)/percentages[0]+percentages[1]+percentages[2];
  }
  // Find average liberalism rating of this Bill
  // Precondition: each idea has a socialism and liberalism value, percentages says how strong each idea will be
  // Postcondition: a Liberalism rating is given, 0-100
  float avgLib() {
    int x = 100;// Still also temp
    int y = 25;//
    int z = 75;// ===========
    x *= percentages[0];
    y *= percentages[1];
    z *= percentages[2];
    return (x+y+z)/percentages[0]+percentages[1]+percentages[2];
  }
}
