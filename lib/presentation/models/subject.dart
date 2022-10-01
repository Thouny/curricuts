import 'package:curricuts/core/enums/relative_relationship.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:equatable/equatable.dart';

class SubjectModel extends Equatable {
  const SubjectModel({
    required this.code,
    required this.name,
    required this.prerequisites,
    required this.antirequisites,
    required this.link,
    required this.relationship,
  });

  final int code;
  final String name;
  final List<int> prerequisites;
  final List<int> antirequisites;
  final String link;
  final RelativeRelationship relationship;

  factory SubjectModel.fromEntity(
    SubjectEntity entity,
    RelativeRelationship relationship,
  ) {
    return SubjectModel(
        code: entity.code,
        name: entity.name,
        prerequisites: entity.prerequisites,
        antirequisites: entity.antirequisites,
        link: entity.link,
        relationship: relationship);
  }

  @override
  List<Object?> get props => [
        code,
        name,
        prerequisites,
        antirequisites,
        link,
        relationship,
      ];
}
