/// Language type
///
/// `myanmar` | `english` | `mon` | `zawgyi`
enum Language {
  myanmar("\u104a\u200b", "\u104b\u200b"),
  english("\u104a\u200b", "\u104b\u200b"),
  mon("\u104a\u200b", "\u104b\u200b"),
  zawgyi("\u104a\u200b", "\u104b\u200b"),
  tai("\u104a\u200b", "\u104b\u200b"),
  karen("\u104a\u200b", "\u104b\u200b");

  const Language(this.comma, this.period);

  final String comma;
  final String period;
}
