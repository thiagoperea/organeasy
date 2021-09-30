import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoneyMask extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String _onlyDigits = newValue.text.replaceAll(RegExp(r"[^0-9]"), "");
    double _asDecimal = double.tryParse(_onlyDigits) ?? 0.0;
    String _newFormatted = NumberFormat.simpleCurrency().format(_asDecimal / 100.0);

    return TextEditingValue(
      selection: TextSelection.collapsed(offset: _newFormatted.length),
      text: _newFormatted,
    );
  }
}
