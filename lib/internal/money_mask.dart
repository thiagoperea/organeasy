import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:organeasy/internal/string_extensions.dart';

class MoneyMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    double _asDecimal = StringExtensions.moneyToDouble(newValue.text);
    String _newFormatted = NumberFormat.simpleCurrency().format(_asDecimal);

    return TextEditingValue(
      selection: TextSelection.collapsed(offset: _newFormatted.length),
      text: _newFormatted,
    );
  }
}
