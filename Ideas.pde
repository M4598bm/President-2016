class Ideas {
  Table ideaTable;
  String[] names;

  Ideas() {
    ideaTable = loadTable("ideas.csv", "header");
    names = new String[ideaTable.getRowCount()];
    for (int i = 0; i < names.length; i++)
      names[i] = ideaTable.getRow(i).getString(0);
    //println(departmentNames(11));
    //println(loadTable("majordepartments.csv").getRow(11).getString(0));
  }

  // an ArrayList of the names of ideas in a department int d
  // Precondition: int d is a department number and names is the names of every idea
  // Postcondition: returns an ArrayList with the names of all ideas in this department
  ArrayList<String> departmentNames(int d) {
    ArrayList<String> list = new ArrayList<String>();
    for (int i = 0; i < names.length; i++)
      if (Utils.convertInt(ideaTable.getRow(i).getString(1)) == d)
        list.add(names[i]);
    return list;
  }

  // finds the index of the name of an idea given
  // Precondition: names is an array of all of the names and indexes of ideas
  // Postcondition: Returns the int index of the idea with name String s
  int nameToInd(String s) {
    for (int i = 0; i < names.length; i++)
      if (names[i].equals(s))
        return i;
    return 0;
  }
}
