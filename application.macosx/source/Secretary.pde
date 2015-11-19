class Secretary {
  // This class holds information for each member of your cabinet
  String title;
  String dep;
  int[] events;// events having to do with this dept
  int happiness;// current state of the dept (does it have the capital to be efficient?)
  int funding;
  
  Secretary(String d, String t) {
    dep = d;
    title = t;
    happiness = 90;
  }
  
  void findFunding() {
    funding = 0;
    Table t = loadTable("startingbudget.csv", "header");
    for (TableRow r: t.rows())
      if (cabinet[Utils.convertInt(r.getString(2))].dep == this.dep)
        funding += Utils.convertInt(r.getString(1));
  }
}