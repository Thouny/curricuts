import 'package:curricuts/core/enums/availability.dart';
import 'package:curricuts/core/enums/relative_relationship.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:equatable/equatable.dart';

class SubjectModel extends Equatable {
  const SubjectModel({
    required this.code,
    required this.name,
    required this.prerequisites,
    required this.postrequisites,
    required this.link,
    required this.relationship,
    this.availabilities = const [
      Availability.autumn,
      Availability.spring,
      Availability.summer,
    ],
    required this.creditPoints,
  });

  final int code;
  final String name;
  final List<int> prerequisites;
  final List<int> postrequisites;
  final String link;
  final RelativeRelationship relationship;
  final List<Availability> availabilities;
  final String creditPoints;

  factory SubjectModel.fromEntity(
    SubjectEntity entity,
    RelativeRelationship relationship,
  ) {
    return SubjectModel(
      code: entity.code,
      name: entity.name,
      prerequisites: entity.prerequisites,
      postrequisites: entity.postrequisites,
      link: entity.link,
      relationship: relationship,
      availabilities: entity.availabilities,
      creditPoints: entity.creditPoints,
    );
  }

  @override
  List<Object?> get props => [
        code,
        name,
        prerequisites,
        postrequisites,
        link,
        relationship,
        availabilities,
        creditPoints,
      ];
}
