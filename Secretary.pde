class Secretary extends Politician {
  // This class holds information for each member of your cabinet
  String title;
  String dep;
  int[] events;// events having to do with this dept
  int happiness;// current state of the dept (does it have the capital to be efficient?)
  int deptFunding;

  // Constructor
  // Precondition: d is department of the secretary and t is the title, both found in majordepartments.csv
  // Postcondition: creates the Object
  Secretary(String d, String t) {
    super("", 0);
    dep = d;
    title = t;
    happiness = 90;
  }

  // Sets funding variable from all budget matters of this dep
  // Precondition: startingbudget.csv is the budget at the beginning of the Game
  // Postcondition: funding is the sum of funding in all of this department
  void findFunding() {
    funding = 0;
    Table t = loadTable("startingbudget.csv", "header");
    for (TableRow r: t.rows())
      if (cabinet[Utils.convertInt(r.getString(2))].dep == this.dep)
        funding += Utils.convertInt(r.getString(1));
  }
}