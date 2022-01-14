class CalendarData {
  Month? prev;
  Month? current;
  Month? next;
  int month;
  CalendarData(this.month, {this.prev, this.current, this.next});

  void setPrev (Month month) {
    prev = month;
  }

  void setCurrent (Month month) {
    current = month;
  }

  void setNext (Month month) {
    next = month;
  }
}

class Month {
  int year;
  int month;
  List<Timeslot> days = [];
  Month({required this.year, required this.month});

  void setDays (List<Timeslot> input) {
    days = input;
  }
}

class Timeslot {
  int year;
  int month;
  int day;
  int weekday;
  int available;
  List<String>? user;
  Timeslot({required this.year, required this.month, required this.day, required this.weekday, required this.available, this.user});
}