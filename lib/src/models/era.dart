import 'package:equatable/equatable.dart';

class Era extends Equatable {
  final double eid;
  final int begin;
  final int end;
  final double wo;
  final int nm;
  final List<List<int>> fme;
  final List<List<int>> wte;

  const Era({
    required this.eid,
    required this.begin,
    required this.end,
    required this.wo,
    required this.nm,
    required this.fme,
    required this.wte,
  });

  @override
  List<Object?> get props => [eid, begin, end, wo, nm, fme, wte];

  Era copyWith({
    double? eid,
    int? begin,
    int? end,
    double? wo,
    int? nm,
    List<List<int>>? fme,
    List<List<int>>? wte,
  }) {
    return Era(
      eid: eid ?? this.eid,
      begin: begin ?? this.begin,
      end: end ?? this.end,
      wo: wo ?? this.wo,
      nm: nm ?? this.nm,
      fme: fme ?? this.fme,
      wte: wte ?? this.wte,
    );
  }

  @override
  String toString() {
    return 'Era(eid: $eid, begin: $begin, end: $end, wo: $wo, nm: $nm, fme: $fme, wte: $wte)';
  }
}
