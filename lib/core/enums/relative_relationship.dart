import 'package:curricuts/core/theme/app.dart';
import 'package:flutter/material.dart';

enum RelativeRelationship {
  selectedSubject,
  selectedSubjectPrerequisite,
  prerequisite,
}

extension Properties on RelativeRelationship {
  Color get color {
    switch (this) {
      case RelativeRelationship.selectedSubject:
        return Colors.green;
      case RelativeRelationship.selectedSubjectPrerequisite:
        return Colors.red;
      case RelativeRelationship.prerequisite:
        return AppColors.primaryColor;
    }
  }

  double get nodeHeight {
    switch (this) {
      case RelativeRelationship.selectedSubject:
        return 120;
      case RelativeRelationship.selectedSubjectPrerequisite:
      case RelativeRelationship.prerequisite:
        return 80;
    }
  }

  double get nodeWidth {
    switch (this) {
      case RelativeRelationship.selectedSubject:
        return 120;
      case RelativeRelationship.selectedSubjectPrerequisite:
      case RelativeRelationship.prerequisite:
        return 160;
    }
  }

  double get borderRadius {
    switch (this) {
      case RelativeRelationship.selectedSubject:
        return 100;
      case RelativeRelationship.selectedSubjectPrerequisite:
      case RelativeRelationship.prerequisite:
        return 10;
    }
  }
}
