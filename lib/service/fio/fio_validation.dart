bool isValidFio(String input) {
  if (input.trim().isEmpty) return false;

  final parts = input.trim().split(RegExp(r'\s+'));


  if (parts.length < 2) return false;

  for (final part in parts) {
    if (part.length < 3) return false;
  }

  return true;
}

String? fioValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'F.I.O kiritilishi kerak';
  }
  if (!isValidFio(value)) {
    return 'F.I.O noto‘g‘ri (Aliyev Ali)';
  }
  return null;
}
