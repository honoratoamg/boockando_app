import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneHelper {
  static Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    var timeZoneName = DateTime.now().timeZoneName;

    if (timeZoneName == 'GMT') {
      timeZoneName = 'Europe/London';
    }

    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  /// Returns today
  static int getToday() {
    return tz.TZDateTime.now(tz.local).day % DateTime.daysPerWeek;
  }

  /// Returns timed duration
  static tz.TZDateTime nowPlusDuration({Duration duration}) {
    return tz.TZDateTime.now(tz.local).add(duration);
  }

  /// Returns the next instace of hour
  static tz.TZDateTime nextInstanceOf({int hour, int minute}) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  /// Returns the next instance of date
  static tz.TZDateTime nextInstanceOfDay({int hour, int minute, int day}) {
    var scheduledDate = nextInstanceOf(hour: hour, minute: minute);

    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
