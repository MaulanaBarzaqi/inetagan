import 'package:intl/intl.dart';

class AppFormat {
  static String shortPrice(num number) {
    return NumberFormat.compactCurrency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(number);
  }

  static String longPrice(num number) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(number);
  }

  static String justDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String fullDate(source) {
    switch (source) {
      case String s:
        return DateFormat('dd MMM yyyy kk:mm').format(DateTime.parse(s));
      case DateTime d:
        return DateFormat('dd MMM yyyy kk:mm').format(d);
      default:
        return 'not valid';
    }
  }

  static String shortDate(source) {
    switch (source) {
      case String s:
        return DateFormat('EEEE, d MMM yy').format(DateTime.parse(s));
      case DateTime d:
        return DateFormat('EEEE, d MMM yy').format(d);
      default:
        return 'not valid';
    }
  }
}
