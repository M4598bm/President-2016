class SCJustice extends Politician {
  boolean chief;

  // Constructor
  // Precondition: each of the variables represent the variables that need to be set
  // Postcondition: creates the Object
  SCJustice(String n, int s, int l, char p, boolean leader) {
    super("", 0);
    socialism = s;
    liberalism = l;
    party = p;
    name = n;
    chief = leader;
  }



}