import 'package:intl/intl.dart';
class DateUtility {
  static String formatToHumanReadable(String isoDateString) {
    try {
      DateTime dateTime = DateTime.parse(isoDateString);
      return DateFormat('MMM d, y – h:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
}