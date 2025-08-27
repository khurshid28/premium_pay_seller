// List<DateTime> generateMonthlyDueDates({
//   required DateTime startDate,
//   required int dayOfMonth,
//   int months = 12,
// }) {
//   return List.generate(months, (i) {
//     final year = startDate.year;
//     final month = startDate.month + i;

//     // Oyning oxirgi kunini aniqlaymiz
//     final lastDayOfMonth = DateTime(year, month + 1, 0).day;

//     // Agar foydalanuvchi tanlagan sana mavjud bo‘lsa — o‘sha sanani, yo‘q bo‘lsa — oxirgi kunni ol
//     final day = dayOfMonth <= lastDayOfMonth ? dayOfMonth : lastDayOfMonth;

//     return DateTime(year, month, day);
//   });
// }



List<DateTime> getMonthlyDates(
  DateTime startDate,
  int targetDay, {
  int months = 12,
}) {
  final List<DateTime> dates = [];

  // startDate ga +5 soat qo‘shamiz
  startDate = startDate.add(const Duration(hours: 5));

  for (int i = 0; i < months; i++) {
    int year = startDate.year;
    int month = startDate.month + i;

    year += (month - 1) ~/ 12;
    month = ((month - 1) % 12) + 1;

    int lastDayOfMonth = DateTime(year, month + 1, 0).day;

    int day = targetDay <= lastDayOfMonth ? targetDay : lastDayOfMonth;

    dates.add(DateTime(year, month, day).add(const Duration(hours: 5)));
  }

  return dates;
}