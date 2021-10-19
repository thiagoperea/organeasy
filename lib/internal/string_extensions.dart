extension StringExtensions on String {
  String toOnlyDigits() => this.replaceAll(RegExp(r"[^0-9]"), "");

  double toDouble() => (double.tryParse(this) ?? 0.0) / 100;
}
