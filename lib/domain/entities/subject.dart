import 'package:curricuts/core/enums/faculty.dart';
import 'package:curricuts/core/enums/teaching_responsibility.dart';
import 'package:equatable/equatable.dart';

class SubjectEntity extends Equatable {
  const SubjectEntity({
    required this.spkCode,
    required this.name,
    required this.faculty,
    required this.teachingResponsibility,
    required this.creditPoint,
    this.courseMajorAsCoreComponent,
    this.prerequisites = '',
    this.antirequisites = '',
    this.description,
    this.availability,
    this.teachingLearningStrategies,
    this.contentGeneric,
    this.requiredText,
  });

  factory SubjectEntity.fromCSV(List<dynamic> row) {
    final teaching = TeachingResponsibilityTypeConverter.convertFrom(row[4]);
    final faculty = FacultyTypeConverter.convertFrom(row[2]);
    return SubjectEntity(
      spkCode: row[0],
      name: row[1],
      faculty: faculty,
      courseMajorAsCoreComponent: row[3],
      teachingResponsibility: teaching,
      creditPoint: row[5],
      prerequisites: row[6],
      antirequisites: row[7],
      description: row[8],
      availability: row[9],
      teachingLearningStrategies: row[10],
      contentGeneric: row[11],
      requiredText: row[12],
    );
  }

  final int spkCode;
  final String name;
  final Faculty faculty;
  final String? courseMajorAsCoreComponent;
  final TeachingResponsibility teachingResponsibility;
  final int creditPoint;
  final String prerequisites;
  final String antirequisites;
  final String? description;
  final String? availability;
  final String? teachingLearningStrategies;
  final String? contentGeneric;
  final String? requiredText;

  @override
  List<Object?> get props => [
        spkCode,
        name,
        faculty,
        courseMajorAsCoreComponent,
        teachingResponsibility,
        creditPoint,
        prerequisites,
        antirequisites,
        description,
        availability,
        teachingLearningStrategies,
        contentGeneric,
        requiredText,
      ];
}
