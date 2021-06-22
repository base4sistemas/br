/// Extracts only numeric digits from the string content.
String digitsOf(String content) {
  return content.replaceAll(RegExp(r'[^0-9]'), '');
}

/// Extract only numeric digits from the string content as a list of integers.
List<int> intListFromDigitsOf(String content) {
  String digits = digitsOf(content);
  return List.generate(
      digits.length, (int index) => int.parse(digits[index])
  );
}