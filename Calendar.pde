String[] days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
int[] daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

class Calendar {
  int year;
  int month;

  int day;
  int cMonth;
  int cYear;

  // Constructor
  // Precondition: year month and day are current values, cyear and cmonth are currently being shown
  // Postcondition: creates the Object
  Calendar() {
    year = cYear = 17;// year is the display year, cYear is game current year
    month = cMonth = 1;
    day = 22;
  }

  //
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

  void display() {
    displayBackground();

    textAlign(RIGHT);
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
      lMonth = months[month-2];
      nMonth = months[month];
      lYear = nYear = year;
    }

    displayDays(lMonth, nMonth, lYear, nYear);
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
      text(days[i-1], width/6-width/21+width*2/21*i, height/6+height/21);
    }
  }

  // Displays the days of the current month
  // Precondition: lMonth = last month, nMonth = next month, lYear = last month year, nYear = next month year
  // Postcondition: The days of the current month are displayed
  void displayDays(String lMonth, String nMonth, int lYear, int nYear) {
    text("<   "+lMonth+" 20"+(lYear), width/2-40, height/6-50);
    textAlign(LEFT);
    text(nMonth+" 20"+(nYear)+"   >", width/2+40, height/6-50);
    int col = 0;
    int row = 0;
    int yearCount = 17;
    int monthCount = 1;
    int dayCount = 1;
    textAlign(CENTER, CENTER);
    text(months[month-1] + " 20"+year, width/2, height/6-25);
    while (yearCount != year || monthCount != month || dayCount < daysInMonth[month-1]) {
      if (yearCount == year && monthCount == month)
        text(dayCount, width/6+width/21+width*2/21*col, height/6+height*2/21+height/21+width/21*row);
        // ^ this needs to be cut down especially the 'y' part
      col++;
      if (col == 7) {
        row++;
        col = 0;
      }
      dayCount++;
      if (dayCount > daysInMonth[monthCount-1]) {
        dayCount = 1;
        monthCount++;
        row = 0;
        if (monthCount > 12) {
          monthCount = 1;
          yearCount++;
        }
      }
    }
    text(dayCount, width/6+width/21+width*2/21*col, height/6+height*2/21+height/21+width/21*row);
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
}
