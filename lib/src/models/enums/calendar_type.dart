/// Calendar type
///
/// `0=English` | `1=Gregorian` | `2=Julian`
enum CalendarType {
  english(0, "English"),
  gregorian(1, "Gregorian"),
  julian(2, "Julian");

  const CalendarType(this.number, this.label);

  final int number;
  final String label;
}
