import 'package:intl/intl.dart';

String formatMinorMoney(int minorUnits, String currency) {
  final amount = minorUnits / 100;
  return NumberFormat.simpleCurrency(name: currency).format(amount);
}
