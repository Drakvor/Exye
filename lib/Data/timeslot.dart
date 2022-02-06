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
  String id;
  int year;
  int month;
  int day;
  int weekday;
  int available;
  List<String>? slots;
  List<String>? deliveries;
  int? deliverCount;
  Timeslot({required this.id, required this.year, required this.month, required this.day, required this.weekday, required this.available, this.slots, this.deliveries, this.deliverCount});

  int isValid (int type) {
    if (type == 0) {
      if (DateTime.now().year == year && DateTime.now().month == month && DateTime.now().day == day) {
        return -1;
      }
      if (available == 0) {
        return 0;
      }
      if (DateTime(year, month, day).isBefore(DateTime.now())) {
        return 0;
      }
      return 1;
    }
    if (type == 1) {
      if (DateTime.now().year == year && DateTime.now().month == month && DateTime.now().day == day) {
        return -1;
      }
      if (!((available > 0) && (deliverCount! < 2))) {
        return 0;
      }
      if (DateTime(year, month, day).isBefore(DateTime.now())) {
        return 0;
      }
      return 1;
    }
    return 0;
  }
}