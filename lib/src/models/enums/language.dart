/// Language type
///
/// `myanmar` | `english` | `mon` | `zawgyi` | `karen` | `tai`
enum Language {
  english(0, ", ", "."),
  myanmar(1, "၊ ", "။ "),
  mon(2, "၊ ", "။ "),
  zawgyi(3, "၊ ", "။ "),
  tai(4, "၊ ", "။ "),
  karen(5, "၊ ", "။ ");

  const Language(this.languageIndex, this.punctuationMark, this.punctuation);

  final int languageIndex;
  final String punctuationMark;
  final String punctuation;
}
