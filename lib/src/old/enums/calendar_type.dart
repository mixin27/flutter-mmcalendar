enum CalendarType {
  english(0, "English"),
  gregorian(1, "Gregorian"),
  julian(2, "Julian");

  const CalendarType(this.number, this.label);

  final int number;
  final String label;

  int getNumber() => number;

  String getLabel() => label;
}
