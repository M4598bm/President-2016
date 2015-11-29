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
    String[] inputs = input.toLowerCase().split(" ");
    /* Each word of the string will be searched to see if they are:
        * a state (and if it satisfies the person) 
        * first 3 or more letters of a first name (and if it is the person's first or last name)
        * party, 'd', or 'r' (and if it's the person's party)
        * position (and if it's the person's position)
    */
    
    
    ArrayList<Congressman> r = new ArrayList<Congressman>();
    Congressman[] con = new Congressman[house.length+senate.length];
    for (int i = 0; i < house.length; i++)
      con[i] = house[i];
    for (int i = 0; i < senate.length; i++)
      con[house.length+i] = senate[i];
      
    for (int i = 0; i < con.length; i++) {
      
      boolean done = true;
      for (String s : inputs) {
        // Goes through each input and has to find a way to satisfy, otherwise it is out
        boolean satisf = false;
        
      // * state search:
        if (s.equals(con[i].state.toLowerCase()))
          satisf = true;
          //=== Eventually add longer state names ===//
    
      // * name search:
        if (s.length() > 2) {
          String[] n = con[i].name.toLowerCase().split(" ");
          if (s.equals(n[0].substring(0, min(s.length(), n[0].length()))) || s.equals(n[1].substring(0, min(s.length(), n[1].length()))))
            satisf = true;
        }
        
      // * party search:
        if (s.equals("d") || s.equals("democrat"))
          if (con[i].party == 'D')
            satisf = true;
        if (s.equals("r") || s.equals("republican"))
          if (con[i].party == 'R')
            satisf = true;
      
      // * position search:
        if (s.equals("leader") && con[i].leadership == 1)
          satisf = true;
        if (s.equals("whip") && con[i].leadership == 2)
          satisf = true;
        if (s.equals("speaker") && con[i].leadership == 1)
          satisf = true;
          
      // 0 is none, 1 is leader, 2 is whip, 3 is speaker. 1 and 2 have majority or minority and senate or house

                  
        if (!satisf)
          done = false;
      }
      if (done)
        r.add(con[i]);
    }
    return r;
  }
}