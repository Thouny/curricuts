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
        return const Color.fromARGB(255, 104, 197, 107);
      case RelativeRelationship.selectedSubjectPrerequisite:
        return const Color.fromARGB(255, 231, 102, 92);
      case RelativeRelationship.prerequisite:
        return Colors.grey;
    }
  }

  double get nodeHeight {
    switch (this) {
      case RelativeRelationship.selectedSubject:
      // return 120;
      case RelativeRelationship.selectedSubjectPrerequisite:
      case RelativeRelationship.prerequisite:
        return 80;
    }
  }

  double get nodeWidth {
    switch (this) {
      case RelativeRelationship.selectedSubject:
      // return 120;
      case RelativeRelationship.selectedSubjectPrerequisite:
      case RelativeRelationship.prerequisite:
        return 160;
    }
  }

  double get borderRadius {
    switch (this) {
      case RelativeRelationship.selectedSubject:
      // return 100;
      case RelativeRelationship.selectedSubjectPrerequisite:
      case RelativeRelationship.prerequisite:
        return 10;
    }
  }
}
