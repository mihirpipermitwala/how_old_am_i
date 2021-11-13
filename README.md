# how_old_am_i
[![pub package](https://img.shields.io/pub/v/how_old_am_i.svg)](https://pub.dev/packages/how_old_am_i)

A Flutter package to calculate someone's age in days, months, and years; in addition, it can be used to find the difference between two dates.


## Installtion

1. Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  how_old_am_i: any
```

## Example


```dart
import 'package:how_old_am_i/how_old_am_i.dart';

void main() {
  DateTime dateOfBirth = DateTime(1992, 7, 31);

  DateTimeDuration dateTimeDuration;

  // Find out your age as of today's date
  dateTimeDuration = HowOldAmI.age(dateOfBirth);
  print('Your age is ' + dateTimeDuration.toString());

  //Find out your age on any given date
  dateTimeDuration = HowOldAmI.age(dateOfBirth, today: DateTime(2030, 5, 1));
  print('Your age is $dateTimeDuration');

  // Find out when your next birthday will be
  dateTimeDuration = HowOldAmI.timeToNextBirthday(dateOfBirth);
  print('You next birthday will be in $dateTimeDuration');

  // Find out when your next birthday will be on any given date
  dateTimeDuration =
      HowOldAmI.timeToNextBirthday(dateOfBirth, fromDate: DateTime(2022, 8, 2));
  print('You next birthday will be in $dateTimeDuration');

  // Find out the difference between two dates
  dateTimeDuration = HowOldAmI.dateDifference(
    fromDate: DateTime.now(),
    toDate: DateTime(2025, 5, 2),
  );
  print('The difference is $dateTimeDuration');

  // Add time to any date
  DateTime date = HowOldAmI.add(
      date: DateTime.now(),
      duration: DateTimeDuration(years: 5, months: 2, days: 1));
  print(date);
}
```
