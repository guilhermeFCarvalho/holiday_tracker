abstract class AppPipes {
  static const weekDays = [
    "Segunda",
    "Terça",
    "Quarta",
    "Quinta",
    "Sexta",
    "Sábado",
    "Domingo",
  ];

  static String getCurrentYear() {
    final today = DateTime.now();
    if (today.isAfter(
      DateTime(
        today.year,
        12,
        25,
        23,
        59,
      ),
    )) {
      return (today.year + 1).toString();
    }
    return today.year.toString();
  }
}
