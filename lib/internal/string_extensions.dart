class StringExtensions {
  const StringExtensions._();

  static String getOnlyDigits(String value) => value.replaceAll(RegExp(r"[^0-9]"), "");

  static double moneyToDouble(String value) => (double.tryParse(getOnlyDigits(value)) ?? 0.0) / 100;
}
