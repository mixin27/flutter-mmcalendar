import 'package:flutter/foundation.dart';

/// Represents the Myanmar months for a specific Myanmar year.
class MyanmarMonths {
  /// List of month indices.
  final List<int> indices;

  /// List of Myanmar month names corresponding to the indices.
  final List<String> monthNameList;

  /// Current selected index in the list.
  final int currentIndex;

  const MyanmarMonths({
    required this.indices,
    required this.monthNameList,
    required this.currentIndex,
  });

  /// Creates a copy of this object with optional new values.
  MyanmarMonths copyWith({
    List<int>? indices,
    List<String>? monthNameList,
    int? currentIndex,
  }) {
    return MyanmarMonths(
      indices: indices ?? this.indices,
      monthNameList: monthNameList ?? this.monthNameList,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  String toString() =>
      'MyanmarMonths(indices: $indices, monthNameList: $monthNameList, currentIndex: $currentIndex)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyanmarMonths &&
          runtimeType == other.runtimeType &&
          listEquals(other.indices, indices) &&
          listEquals(other.monthNameList, monthNameList) &&
          other.currentIndex == currentIndex;

  @override
  int get hashCode =>
      indices.hashCode ^ monthNameList.hashCode ^ currentIndex.hashCode;
}
