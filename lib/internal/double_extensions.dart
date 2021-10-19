import 'package:intl/intl.dart';

extension NumberExtensions on double {
  String toMonetary() => NumberFormat.simpleCurrency().format(this);
}
