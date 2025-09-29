/// Contains astronomical and astrological information for a Myanmar date
class AstroInfo {
  /// Astrological days
  final List<String> astrologicalDays;

  /// Sabbath
  final String sabbath;

  /// Yatyaza
  final String yatyaza;

  /// Pyathada
  final String pyathada;

  /// Naga head direction
  final String nagahle;

  /// Mahabote
  final String mahabote;

  /// Nakhat
  final String nakhat;

  /// Year name
  final String yearName;

  /// Create a new astro info
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
