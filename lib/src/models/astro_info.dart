/// Contains astronomical and astrological information for a Myanmar date
class AstroInfo {
  final List<String> astrologicalDays;
  final String sabbath;
  final String yatyaza;
  final String pyathada;
  final String nagahle;
  final String mahabote;
  final String nakhat;
  final String yearName;

  const AstroInfo({
    required this.astrologicalDays,
    required this.sabbath,
    required this.yatyaza,
    required this.pyathada,
    required this.nagahle,
    required this.mahabote,
    required this.nakhat,
    required this.yearName,
  });

  @override
  String toString() {
    return 'AstroInfo(astrologicalDays: $astrologicalDays, sabbathInfo: $sabbath, yatyaza: $yatyaza, pyathada: $pyathada, nagahle: $nagahle, mahabote: $mahabote, nakhat: $nakhat, yearName: $yearName)';
  }
}
