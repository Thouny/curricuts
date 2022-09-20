import 'package:equatable/equatable.dart';

class SubjectEntity extends Equatable {
  const SubjectEntity({
    required this.code,
    required this.name,
    required this.prerequisites,
    required this.antirequisites,
    required this.link,
  });

  factory SubjectEntity.fromJson(Map<String, dynamic> json) {
    return SubjectEntity(
      code: int.tryParse(json['code'] as String) ?? 0,
      name: json['name'],
      prerequisites: _toInt(json['preReq']),
      antirequisites: _toInt(json['tooPer']),
      link: _getLink(json['code']),
    );
  }

  final int code;
  final String name;
  final List<int> prerequisites;
  final List<int> antirequisites;
  final String link;

  static String _getLink(String code) {
    return 'http://handbook.uts.edu.au/subjects/$code.html';
  }

  static List<int> _toInt(List<dynamic> json) {
    if (json.isEmpty) return [];
    return json.map((e) => int.parse(e)).toList(growable: false);
  }

  @override
  List<Object?> get props => [
        code,
        name,
        prerequisites,
        antirequisites,
        link,
      ];
}
