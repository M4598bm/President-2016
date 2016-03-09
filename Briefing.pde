static final String[] titles = {
  "Results from last turn",
  "Legislation Update",
  "State News",
  "Supreme Court",
  "Intelligence",
  "International Relations",
  "Reminders",
  "Elections",
  "Important Events",
  "Notable quotes from this week"
};
static final int MAX_CURR = 9;

class Briefing {
  Table news;// Holds all news to be told for this briefing
  int curr;// current displayed news

  // [1]: String type, [2]: String message
  // Example: [1]: "Bill", [2]: "Affordable Care Act was passed in the house. it moves to the senate"
  /*
    Types:
      * 0) Result (from last turn)
        - speech
        - UN speech
        -
      * 1) Bill
        - 1
        - 2
        - 3
      * 2) States
        -
      * 3) Supreme court
        -
      * 4) Intelligence
        - Requested
        - Important
      * 5) International correspondence
        - request
        - you request response
      * 6) Reminder
        - New stats
        - Election update
      * 7) Election (Results)
        -
      * 8) Event (Will have a response option)
        -
      * 9) Quotes (from people to see what kinds of things are going on)
        -
  */


  // Constructor
  // Precondition: tons of ArrayLists
  // Postcondition: creates the Object
  Briefing() {
    news = new Table();
    news.addColumn("type");
    news.addColumn("message");
  }

  // returns the curr title
  // Precondition: curr is set
  // Postcondition: Returns title index curr
  String toString() {
    return titles[curr];
  }

  // adds news to the Briefing
  // Precondition: news is set and titles is set
  // Postcondition: returns if it adds an entry titles[t] and msg to news if index t is appropriate
  boolean addNews(int t, String msg) {
    if (t >= 0 && t < titles.length) {
      TableRow r = news.addRow();
      r.addString("type", titles[t]);
      r.addString("message", msg);
      return true;
    }
    return false;
  }

  // gets news pertaining to curr
  // Precondition: news is set and curr is not more than titles.length
  // Postcondition: Returns ArrayList with all messages to be displayed
  ArrayList<String> getNews() {
    ArrayList<String> n = new ArrayList<String>();

    for (TableRow tr : news.rows()) {
      if (tr.getString(0).equals(titles[curr])) {
        n.add(tr.getString(1));
      }
    }
    return n;
  }



}
