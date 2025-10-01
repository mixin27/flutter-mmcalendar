/// Chronicle entry data.
class ChronicleEntryData {
  ///
  final String id;

  /// Start Julian day number.
  final double startJdn;

  /// End Julian day number.
  final double? endJdn;

  /// Title.
  final Map<String, String> title; // 'my', 'en', etc.
  /// Summary.
  final Map<String, String>? summary;

  /// Tags.
  final List<String> tags;

  /// Dynasty ID.
  final String? dynastyId;

  /// Ruler ID.
  final String? rulerId;

  /// Create a new Chronicle entry data.
  const ChronicleEntryData({
    required this.id,
    required this.startJdn,
    this.endJdn,
    required this.title,
    this.summary,
    this.tags = const [],
    this.dynastyId,
    this.rulerId,
  });

  /// Check if the entry includes a Julian day number.
  bool includesJdn(double jdn) =>
      jdn >= startJdn && (endJdn == null || jdn <= endJdn!);
}

/// Dynasty data.
class DynastyData {
  ///
  final String id;

  /// Name.
  final Map<String, String> name;

  /// Start Julian day number.
  final double startJdn;

  /// End Julian day number.
  final double endJdn;

  /// Create a new Dynasty data.
  const DynastyData({
    required this.id,
    required this.name,
    required this.startJdn,
    required this.endJdn,
  });
}

/// Ruler data.
class RulerData {
  /// ID
  final String id;

  /// Dynasty ID.
  final String dynastyId;

  /// Name.
  final Map<String, String> name;

  /// Start Julian day number.
  final double startJdn;

  /// End Julian day number.
  final double endJdn;

  /// Create a new Ruler data.
  const RulerData({
    required this.id,
    required this.dynastyId,
    required this.name,
    required this.startJdn,
    required this.endJdn,
  });
}
