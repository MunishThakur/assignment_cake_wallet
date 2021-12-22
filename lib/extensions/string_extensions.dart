extension StringExtension on String {
  String lastChars(int n) => length >= n ? substring(length - n) : this;
  String removeChar() => length > 0 ? substring(0, length - 1) : this;
}
