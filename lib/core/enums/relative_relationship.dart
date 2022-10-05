import 'package:curricuts/core/theme/app.dart';
import 'package:flutter/material.dart';

enum RelativeRelationship {
  selectedSubject,
  selectedSubjectPrerequisite,
  prerequisite,
}

extension Properties on RelativeRelationship {
  String get label {
    switch (this) {
      case RelativeRelationship.selectedSubject:
        return 'Selected subject';
      case RelativeRelationship.selectedSubjectPrerequisite:
        return 'Subject prerequisite';
      case RelativeRelationship.prerequisite:
        return 'Related subject';
    }
  }

  Color get color {
    switch (this) {
      case RelativeRelationship.selectedSubject:
        return const Color.fromARGB(255, 104, 197, 107);
      case RelativeRelationship.selectedSubjectPrerequisite:
        return const Color.fromARGB(255, 231, 102, 92);
      case RelativeRelationship.prerequisite:
        return AppColors.primaryColor;
    }
  }

  double get nodeHeight {
    switch (this) {
      case RelativeRelationship.selectedSubject:
      case RelativeRelationship.selectedSubjectPrerequisite:
      case RelativeRelationship.prerequisite:
        return 80;
    }
  }

  double get nodeWidth {
    switch (this) {
      case RelativeRelationship.selectedSubject:
      case RelativeRelationship.selectedSubjectPrerequisite:
      case RelativeRelationship.prerequisite:
        return 160;
    }
  }

  double get borderRadius {
    switch (this) {
      case RelativeRelationship.selectedSubject:
      case RelativeRelationship.selectedSubjectPrerequisite:
      case RelativeRelationship.prerequisite:
        return 10;
    }
  }
}
