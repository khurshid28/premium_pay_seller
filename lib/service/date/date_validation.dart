bool isValidDate(String input) {
  if (input.trim().isEmpty) return false;

  final reg = RegExp(r'^(\d{1,2})\/(\d{1,2})\/(\d{4})$');
  final match = reg.firstMatch(input.trim());
  if (match == null) return false;

  final day = int.tryParse(match.group(1)!)!;
  final month = int.tryParse(match.group(2)!)!;
  final year = int.tryParse(match.group(3)!)!;

  if (year < 1925 || year > 2025) return false;
  if (month < 1 || month > 12) return false;

  final daysInMonth = DateTime(year, month + 1, 0).day;
  if (day < 1 || day > daysInMonth) return false;

  return true;
}

String? dateFormValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Sana kiritilishi kerak';
  }
  if (!isValidDate(value)) {
    return 'Sana noto‘g‘ri (format dd/MM/yyyy,1925–2025)';
  }
  return null;
}
