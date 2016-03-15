static String[] DAYS = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
static String[] MONTHS = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
static int[] daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

class Calendar {
  int year;
  int month;

  int day;
  int cMonth;
  int cYear;

  Table events;

  // Constructor
  // Precondition: year month and day are current values, cyear and cmonth are currently being shown
  // Postcondition: creates the Object
  Calendar() {
    year = cYear = 17;// year is the display year, cYear is game current year
    month = cMonth = 1;
    day = 22;

    events = new Table();
    events.addColumn("day");
    events.addColumn("month");
    events.addColumn("year");
    events.addColumn("event");
  }

  // Constructor
  // Precondition: year month and day to make the first of the calendar
  // Postcondition: creates the object and sets year month and day
  Calendar(int y, int m, int d) {
    year = cYear = y;// year is the display year, cYear is game current year
    month = cMonth = m;
    day = d;

    events = new Table();
    events.addColumn("day");
    events.addColumn("month");
    events.addColumn("year");
    events.addColumn("event");
  }

  // set the month forward or backward
  // Precondition: direction is positive or negative
  // Postcondition: if direction < 0 month goes back, if direction >= 0 month goes forward
  void changeMonth(int direction) {
    if (direction < 0) {
      if (year != 17 || month != 1) {
        month--;
        if (month == 0) {
          month = 12;
          year--;
        }
      }
    }
    else {
      month++;
      if (month == 13) {
        month = 1;
        year++;
      }
    }
  }

  // Display the calendar
  // Precondition: no precondition
  // Postcondition: the calendar is displayed
  void display() {
    displayBackground();

    String lMonth = "";
    String nMonth = "";
    int lYear, nYear;
    if (month == 1) {
      lMonth = "December";
      nMonth = "February";
      lYear = year-1;
      nYear = year;
    }
    else if (month == 12) {
      lMonth = "November";
      nMonth = "January";
      lYear = year;
      nYear = year+1;
    }
    else {
      lMonth = MONTHS[month-2];
      nMonth = MONTHS[month];
      lYear = nYear = year;
    }

    displayDays(lMonth, nMonth, lYear, nYear);
  }


  // returns a list of the days adjusted for leap day
  // Precondition: yearCount is the year displayed
  // Postcondition: returns days in each month with 29 in feb on a leap year
  int[] realDaysInMonth(int yearCount) {
    int[] dIM = new int[12];
    for (int i = 0; i < 12; i++) {
      dIM[i] = daysInMonth[i];
    }
    if (yearCount%4 == 0) {
      dIM[1] = 29;
      // We can't forget about Leap Day William!
    }
    return dIM;
  }

  // creates the background for the Calendar
  // Precondition: There is an empty screen and the boxes need to be 6*7
  // Postcondition: There are boxes to put the days and weekday names on top
  void displayBackground() {
    fill(255);
    rect(width/6, height/6, width*2/3, height*2/3);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    for (int i = 1; i <= 6; i++)
      line(width/6, height/6+height*2/21*i, width*5/6, height/6+height*2/21*i);
    for (int i = 1; i <= 7; i++) {
      if (i != 7)
        line(width/6+width*2/21*i, height/6, width/6+width*2/21*i, height*5/6);
      text(DAYS[i-1], width/6-width/21+width*2/21*i, height/6+height/21);
    }
  }

  // Displays the days of the current month
  // Precondition: lMonth = last month, nMonth = next month, lYear = last month year, nYear = next month year
  // Postcondition: The days of the current month are displayed
  void displayDays(String lMonth, String nMonth, int lYear, int nYear) {
    textAlign(RIGHT);
    text("<   "+lMonth+" 20"+(lYear), width/2-40, height/6-50);
    textAlign(LEFT);
    text(nMonth+" 20"+(nYear)+"   >", width/2+40, height/6-50);
    int col = 0;
    int row = 0;
    int yearCount = 17;
    int monthCount = 1;
    int dayCount = 1;
    textAlign(CENTER, BOTTOM);
    text(MONTHS[month-1] + " 20"+year, width/2, height/6-20);
    textAlign(CENTER, CENTER);
    while (yearCount != year || monthCount != month || dayCount < realDaysInMonth(yearCount)[month-1]) {
      if (yearCount == year && monthCount == month) {
        // Highlight the current date
        if (yearCount == cYear && monthCount == cMonth && dayCount == day) {
          fill(hLColor);
          rect(width/6+width*2/21*col, height/6+height*2/21+height*2/21*row, width*2/21, height*2/21);
        }
        // Events on displayed days
        if (getEventsOn(dayCount, monthCount, yearCount).size() != 0) {
          fill(200, 0, 0);
          textSize(40);
          text("*", width/6+width/21+width*2/21*col, height/6-20+(height*2/3)*3/14+(height*2/3)*row/7);
          textSize(20);
        }
        fill(0);
        text(dayCount, width/6+width/21+width*2/21*col, height/6+(height*2/3)*3/14+(height*2/3)*row/7);
      }
      col++;
      if (col == 7) {
        row++;
        col = 0;
      }
      dayCount++;
      if (dayCount > realDaysInMonth(yearCount)[monthCount-1]) {
        dayCount = 1;
        monthCount++;
        row = 0;
        if (monthCount > 12) {
          monthCount = 1;
          yearCount++;
        }
      }
    }
    // === Repeats for the last day in the month ===
    if (yearCount == cYear && monthCount == cMonth && dayCount == day) {
      fill(hLColor);
      rect(width/6+width*2/21*col, (height/6+(height*2/3)*3/14+(height*2/3)*row/7)-height/21, width*2/21, height*2/21);
    }
    if (getEventsOn(dayCount, monthCount, yearCount).size() != 0) {
      fill(200, 0, 0);
      textSize(40);
      text("*", width/6+width/21+width*2/21*col, height/6-20+(height*2/3)*3/14+(height*2/3)*row/7);
      textSize(20);
    }
    fill(0);
    text(dayCount, width/6+width/21+width*2/21*col, height/6+(height*2/3)*3/14+(height*2/3)*row/7);
    // =============================================
  }

  // get the next day after the one inputed
  // Precondition: the day inputed is a real day
  // Postcondition: the next day exists (exception for doomsday?)
  int[] getNextDay(int d, int m, int y) {
    d++;
    if (d > realDaysInMonth(y)[m-1]) {
      d = 1;
      m++;
      if (m > 12) {
        m = 1;
        y++;
      }
    }
    int[] date = {d, m, y};
    return date;
  }

  // sets to the next day
  // Precondition: no precondition
  // Postcondition: the calendar contains the next day
  void setNextDay() {
    int[] nDay = getNextDay(day, month, year);
    day = nDay[0];
    month = cMonth = nDay[1];
    year = cYear = nDay[2];
  }
  // returns the current date
  // Precondition: no precondition
  // Postcondition: the current day in an array
  int[] getDate() {
    int[] date = {day, month, year};
    return date;
  }

  // add an event
  // Precondition: day month year is the date, and the event is a string that will be displayed
  // Postcondition: the date and event is stored in a table
  void addEvent(int d, int m, int y, String event) {
    TableRow r = events.addRow();
    r.setInt("day", d);
    r.setInt("month", m);
    r.setInt("year", y);
    r.setString("event", event);
  }
  // returns what events there are on that Day
  // Precondition: day month and year testing for
  // Postcondition: ArrayList of events on that day
  ArrayList<String> getEventsOn(int d, int m, int y) {
    ArrayList<String> eventList = new ArrayList<String>();
    for (TableRow r: events.rows()) {
      if (r.getInt(0) == d && r.getInt(1) == m && r.getInt(2) == y) {
        eventList.add(r.getString(3));
      }
    }
    return eventList;
  }

  // Change the month if the buttons are clicked
  // Precondition: The button at the top exists and the longest it could be is sept.
  // Postcondition: The month is either forward or backward
  void clickMonth(float mX, float mY) {
    textSize(20);
    if (mY > height/6-70 && mY < height/6-50) {
      if (mX < width/2-40 && mX > width/2-40-textWidth("<   September 2020"))
        changeMonth(-1);
      else if (mX > width/2-40 && mX < width/2-40+textWidth("September 2020   >"))
        changeMonth(1);
    }
    displayAll();
  }

  // This moves time forward once each turn
  // Precondition: the current date is outdated
  // Postcondition: the day, month, and year are up to date and forward DAYS_PER_TURN days
  void setDayNewTurn() {
    for (int i = 0; i < DAYS_PER_TURN; i++) {// uses the above variable (will be a constant)
      day++;
      if (day > daysInMonth[cMonth-1]) {
        day = 1;
        cMonth++;
        if (cMonth > 12) {
          cMonth = 1;
          cYear++;
        }
      }
    }
  }

  // adds the events on one calendar to this one
  // Precondition: Calendar c
  // Postcondition: Calendar c's events are added to this one if they don't exist here
  void syncFrom(Calendar c) {
    Table e = c.events;
    Table newE = events;
    for (TableRow oth : e) {
      boolean notThere = true;
      for (TableRow th : events) {
        if (oth.getInt(0) == th.getInt(0)
          && oth.getInt(1) == th.getInt(1)
          && oth.getInt(2) == th.getInt(2)
          && oth.getString(3) == th.getString(3)) {
          notThere = false;
        }
      }
      if (notThere) {
        newE.addRow(oth);
      }
    }
    events = newE;
  }
}
