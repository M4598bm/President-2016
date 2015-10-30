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
  
  ArrayList<String> departmentNames(int d) {
    ArrayList<String> list = new ArrayList<String>();
    for (int i = 0; i < names.length; i++)
      if (Utils.convertInt(ideaTable.getRow(i).getString(1)) == d)
        list.add(names[i]);
    return list;
  }
  
  int nameToInd(String s) {
    for (int i = 0; i < names.length; i++)
      if (names[i].equals(s))
        return i;
    return 0;
  }
}