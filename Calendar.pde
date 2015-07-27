String[] days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
int[] daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

class Calendar {
  int year;
  int month;
  int day;
  
  int cYear;
  int cMonth;
  
  Calendar() {
    year = cYear = 17;// year is the display year, cYear is game current year
    month = cMonth = 1;
    day = 22;
  }
  
  void display() {
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
    
    textAlign(RIGHT);
    String lMonth = "";
    String nMonth = "";
    if (month == 1) {
      lMonth = "December";
      nMonth = "February";
    }
    else if (month == 12) {
      lMonth = "November";
      nMonth = "January";
    }
    else {
      lMonth = months[month-2];
      nMonth = months[month];
    }
    text("<   "+lMonth+" 20"+(year-1), width/2-40, height/6-50);
    textAlign(LEFT);
    text(nMonth+" 20"+(year+1)+"   >", width/2+40, height/6-50);
    int col = 0;
    int row = 0;
    int yearCount = 17;
    int monthCount = 1;
    int dayCount = 1;
    textAlign(CENTER, CENTER);
    text(months[month-1], width/2, height/6-25);
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
  
  
}