import 'package:flutter/services.dart';
import 'package:organeasy/internal/double_extensions.dart';
import 'package:organeasy/internal/string_extensions.dart';

class MoneyMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String _onlyDigits = newValue.text.toOnlyDigits();
    double _asDecimal = _onlyDigits.toDouble();
    String _newFormatted = _asDecimal.toMonetary();

    return TextEditingValue(
      selection: TextSelection.collapsed(offset: _newFormatted.length),
      text: _newFormatted,
    );
  }
}
