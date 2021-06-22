library how_old_am_i;

class DateTimeDuration {
  int seconds;
  int minutes;
  int hours;
  int days;
  int weeks;
  int months;
  int years;

  DateTimeDuration(
      {this.seconds = 0,
      this.minutes = 0,
      this.hours = 0,
      this.days = 0,
      this.weeks = 0,
      this.months = 0,
      this.years = 0});

  @override
  String toString() {
    // TODO: implement toString
    return "Years: $years, Months: $months, Weeks: $weeks, Days: $days, Hours: $hours, Minutes: $minutes, Seconds: $seconds";
  }
}

class HowOldAmI {
  static const List<int> _noOfDaysInMonth = [
    31, // Jan
    28, // Feb, it varies from 28 to 29
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31 // Dec
  ];

  /// isLeapYear method
  static bool isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  /// daysInMonth method
  static int noOfDaysInMonth(int year, int month) =>
      (month == DateTime.february && isLeapYear(year))
          ? 29
          : _noOfDaysInMonth[month - 1];

  /// dateDifference method
  static DateTimeDuration dateDifference({
    required DateTime fromDate,
    required DateTime toDate,
  }) {
    // Check if toDate to be included in the calculation
    DateTime endDate = toDate;

    int years = endDate.year - fromDate.year;
    int months = 0;
    int days = 0;

    if (fromDate.month > endDate.month) {
      years--;
      months = (DateTime.monthsPerYear + endDate.month - fromDate.month);

      if (fromDate.day > endDate.day) {
        months--;
        days = noOfDaysInMonth(fromDate.year + years,
                ((fromDate.month + months - 1) % DateTime.monthsPerYear) + 1) +
            endDate.day -
            fromDate.day;
      } else {
        days = endDate.day - fromDate.day;
      }
    } else if (endDate.month == fromDate.month) {
      if (fromDate.day > endDate.day) {
        years--;
        months = DateTime.monthsPerYear - 1;
        days = noOfDaysInMonth(fromDate.year + years,
                ((fromDate.month + months - 1) % DateTime.monthsPerYear) + 1) +
            endDate.day -
            fromDate.day;
      } else {
        days = endDate.day - fromDate.day;
      }
    } else {
      months = (endDate.month - fromDate.month);

      if (fromDate.day > endDate.day) {
        months--;
        days =
            noOfDaysInMonth(fromDate.year + years, (fromDate.month + months)) +
                endDate.day -
                fromDate.day;
      } else {
        days = endDate.day - fromDate.day;
      }
    }
    var currentDateDifference =
        DateTimeDuration(days: days, months: months, years: years);

    return DateTimeDuration(
        seconds: toDate.difference(fromDate).inSeconds,
        minutes: toDate.difference(fromDate).inMinutes,
        hours: toDate.difference(fromDate).inHours,
        days: toDate.difference(fromDate).inDays,
        weeks: (toDate.difference(fromDate).inDays / 7).floor(),
        months: currentDateDifference.months,
        years: currentDateDifference.years);
  }

  /// add method
  static DateTime add(
      {required DateTime date, required DateTimeDuration duration}) {
    int years = date.year + duration.years;
    years += ((date.month + duration.months) ~/ DateTime.monthsPerYear);
    int months = ((date.month + duration.months) % DateTime.monthsPerYear);

    int days = date.day + duration.days - 1;

    return DateTime(years, months, 1).add(Duration(days: days));
  }

  static DateTimeDuration age(DateTime birthdate, {DateTime? today}) {
    var currentDateTime = (today ?? DateTime.now());
    var currentDateDifference =
        dateDifference(fromDate: birthdate, toDate: currentDateTime);

    return DateTimeDuration(
        seconds: currentDateTime.difference(birthdate).inSeconds,
        minutes: currentDateTime.difference(birthdate).inMinutes,
        hours: currentDateTime.difference(birthdate).inHours,
        days: currentDateTime.difference(birthdate).inDays,
        weeks: (currentDateTime.difference(birthdate).inDays / 7).floor(),
        months: currentDateDifference.months,
        years: currentDateDifference.years);
  }

  static DateTimeDuration timeToNextBirthday(DateTime birthdate,
      {DateTime? fromDate}) {
    DateTime endDate = fromDate ?? DateTime.now();
    DateTime tempDate = DateTime(endDate.year, birthdate.month, birthdate.day);
    DateTime nextBirthdayDate = tempDate.isBefore(endDate)
        ? HowOldAmI.add(date: tempDate, duration: DateTimeDuration(years: 1))
        : tempDate;
    var currentDateDifference =
        dateDifference(fromDate: endDate, toDate: nextBirthdayDate);

    return DateTimeDuration(
        seconds: endDate.difference(birthdate).inSeconds,
        minutes: endDate.difference(birthdate).inMinutes,
        hours: endDate.difference(birthdate).inHours,
        days: endDate.difference(birthdate).inDays,
        weeks: (endDate.difference(birthdate).inDays / 7).floor(),
        months: currentDateDifference.months,
        years: currentDateDifference.years);
  }
}
