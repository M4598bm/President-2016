class SCJustice {
  String name;
  int socialism;// 0 capitalist, 100 socialist
  int liberalism;// 0 conservative, 100 liberal
  char party;
  boolean chief;

  // Constructor
  // Precondition: each of the variables represent the variables that need to be set
  // Postcondition: creates the Object
  SCJustice(String n,int s, int l, char p, boolean leader) {
    socialism = s;
    liberalism = l;
    party = p;
    name = n;
    chief = leader;
  }



}
