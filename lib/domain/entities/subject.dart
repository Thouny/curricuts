import 'package:curricuts/core/enums/availability.dart';
import 'package:equatable/equatable.dart';

class SubjectEntity extends Equatable {
  const SubjectEntity({
    required this.code,
    required this.name,
    required this.prerequisites,
    required this.postrequisites,
    required this.link,
    this.availabilities = const [Availability.autumn, Availability.spring],
    required this.creditPoints,
  });

  factory SubjectEntity.fromJson(Map<String, dynamic> json) {
    return SubjectEntity(
      code: int.tryParse(json['code'] as String) ?? 0,
      name: json['name'],
      prerequisites: _toInt(json['preReq']),
      postrequisites: _toInt(json['tooPer']),
      link: _getLink(json['code']),
      availabilities: _convertToEnum(List<String>.from(json['availabilities'])),
      creditPoints: json['credit_points'],
    );
  }

  final int code;
  final String name;
  final List<int> prerequisites;
  final List<int> postrequisites;
  final String link;
  final List<Availability> availabilities;
  final String creditPoints;

  static String _getLink(String code) {
    return 'http://handbook.uts.edu.au/subjects/$code.html';
  }

  static List<int> _toInt(List<dynamic> json) {
    if (json.isEmpty) return [];
    return json.map((e) => int.parse(e)).toList(growable: false);
  }

  static List<Availability> _convertToEnum(List<String> typicalAvailabilities) {
    if (typicalAvailabilities.isEmpty) {
      return [Availability.autumn, Availability.spring];
    }
    final availabilities = <Availability>[];
    for (final element in typicalAvailabilities) {
      if (element.contains('Autumn')) {
        availabilities.add(Availability.autumn);
      } else if (element.contains('Spring')) {
        availabilities.add(Availability.spring);
      } else if (element.contains('Summer')) {
        availabilities.add(Availability.summer);
      }
    }

    return availabilities;
  }

  @override
  List<Object?> get props => [
        code,
        name,
        prerequisites,
        postrequisites,
        link,
        availabilities,
        creditPoints,
      ];
}
