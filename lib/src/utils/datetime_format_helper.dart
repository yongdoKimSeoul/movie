
import 'package:intl/intl.dart';

class DateTimeFormatHelper {

  static String convertToYmdDash(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }
}
