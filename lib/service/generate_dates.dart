List<DateTime> generateMonthlyDueDates({
  required DateTime startDate,
  required int dayOfMonth,
  int months = 12,
}) {
  return List.generate(months, (i) {
    final year = startDate.year;
    final month = startDate.month + i;

    // Oyning oxirgi kunini aniqlaymiz
    final lastDayOfMonth = DateTime(year, month + 1, 0).day;

    // Agar foydalanuvchi tanlagan sana mavjud bo‘lsa — o‘sha sanani, yo‘q bo‘lsa — oxirgi kunni ol
    final day = dayOfMonth <= lastDayOfMonth ? dayOfMonth : lastDayOfMonth;

    return DateTime(year, month, day);
  });
}
