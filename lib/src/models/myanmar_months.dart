import 'package:flutter/foundation.dart';

/// Myanmar Months List for Specific Myanmar Year
class MyanmarMonths {
  const MyanmarMonths({
    required this.indices,
    required this.monthNameList,
    required this.currentIndex,
  });

  /// Month index list
  final List<int> indices;

  /// Myanmar month name list
  final List<String> monthNameList;

  /// Current index of the list
  final int currentIndex;

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
  bool operator ==(covariant MyanmarMonths other) {
    if (identical(this, other)) return true;

    return listEquals(other.indices, indices) &&
        listEquals(other.monthNameList, monthNameList) &&
        other.currentIndex == currentIndex;
  }

  @override
  int get hashCode =>
      indices.hashCode ^ monthNameList.hashCode ^ currentIndex.hashCode;
}
