static class Utils {

  // converts numbers from String to int
  // precondition: String num that contains only digits as chars
  // postcondition: returns an int version of String num
  static int convertInt(String num) {
    int n = 0;
    int negate = 1;
    if (num.contains("-")) {
      negate = -1;
      num = num.substring(1, num.length());
    }
    for (int i = 0; i < num.length (); i++)
      n += ((int)num.charAt(num.length()-1-i)-(int)'0')*pow(10, i);
    return n*negate;
  }

  // reverses a String
  // precondition: String str
  // postcondition: String str reversed
  static String reverseString(String str) {
    String s = "";
    for (int i = str.length()-1; i >= 0; i--)
      s += str.charAt(i);
    return s;
  }


  // Used for CSV file reading to replace commas
  // Precondition: The String s may have a comma in it marked by its HTML number, &#44;
  // Postcondition: Returns String s where &#44; is replaced by a comma
  static String returnCommas(String s) {
    return s.replace("&#44;", ",");
  }


  // Find congressmen in the house and senate who satisfy the input
  // Precondition: String input is a search separated by spaces, house and senate are Congressman[] from President.pde
  // Postcondition: Returns ArrayList of Congressman objects that satisfy the search input
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
          if (con[i].party == 'd')
            satisf = true;
        if (s.equals("r") || s.equals("republican"))
          if (con[i].party == 'r')
            satisf = true;

      // * position search:
        if (s.equals("leader") && con[i].leadership == 1)
          satisf = true;
        if (s.equals("whip") && con[i].leadership == 2)
          satisf = true;
        if (s.equals("speaker") && con[i].leadership == 3)
          satisf = true;



        if (!satisf)
          done = false;
      }
      if (done)
        r.add(con[i]);
    }
    return r;
  }
}