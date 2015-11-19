static class Utils {

  // converts numbers from String to int //
  static int convertInt(String num) {
    int n = 0;
    for (int i = 0; i < num.length (); i++)
      n += ((int)num.charAt(num.length()-1-i)-(int)'0')*pow(10, i);
    return n;
  }
  
  static int findDems(int rating, float r) {
    int dems = 0;
    if (rating == 2 && r < 2)
      dems = 1;
    else if (rating == 3) {
      if (r < 2)
        dems = 1;
      else if (r < 4)
        dems = 2;
    }
    else if (rating == 4) {
      dems = 1;
      if (r < 2)
        dems = 2;
    }
    else if (rating == 5)
      dems = 2;
    return dems;
  }
  
  static ArrayList<Congressman> searchThrough(String input, Congressman[] house, Congressman[] senate) {
    // +====== Returns an arraylist of congressmen that satisfy String input ======+
    input = input.toLowerCase();
    ArrayList<Congressman> r = new ArrayList<Congressman>();
    Congressman[] con = new Congressman[house.length+senate.length];
    for (int i = 0; i < house.length; i++)
      con[i] = house[i];
    for (int i = 0; i < senate.length; i++)
      con[house.length+i] = senate[i];
      
    for (int i = 0; i < con.length; i++) {
      boolean done = false;
      
      // * state search:
      if (input.indexOf(con[i].state.toLowerCase()) != -1)
        r.add(con[i]);
      //Table s = loadTable("states.csv", "header");
      //for (TableRow r : s.rows())
      //  if (con[i].state.equals(r.getString(1)))
      //    if (input.indexOf(r.getString(0).toLowerCase()) != -1)
      //      r.add(con[i]);
    
      // * name search:
      for (int j = 2; i < con[i].name.length() && !done; j++) {
        if (input.indexOf(con[i].name.substring(0, j).toLowerCase()) != -1) {// checking if they have full name in there
          done = true;
          r.add(con[i]);
        }
        if (!done && con[i].name.substring(0, j).indexOf(" ") != -1) {// is there a last name? Is that there?
          if (input.indexOf(con[i].name.substring(con[i].name.indexOf(" ")+1, j).toLowerCase()) != -1) {
            done = true;
            r.add(con[i]);
          }
        }
      }
    
      // * party search:
      if (!done && con[i].party == 'D' && (input.indexOf("d") != -1 || input.indexOf("democrat") != -1)) {
        done = true;
        r.add(con[i]);
      }
      if (!done && con[i].party == 'R' && (input.indexOf("r") != -1 || input.indexOf("republican") != -1)) {
        done = true;
        r.add(con[i]);
      }
    
      // * position search:
      //   0 is none, 1 is leader, 2 is whip, 3 is speaker. 1 and 2 have majority or minority and senate or house
      if (!done) {
        if (input.indexOf("leader") != -1 && con[i].leadership == 1) {
          done = true;
          r.add(con[i]);
        }
        else if (input.indexOf("whip") != -1 && con[i].leadership == 2) {
          done = true;
          r.add(con[i]);
        }
        else if (input.indexOf("speaker") != -1 && con[i].leadership == 3) {
          done = true;
          r.add(con[i]);
        }
      }
    }
    return r;
  }
}