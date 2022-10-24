import 'package:curricuts/core/theme/app.dart';
import 'package:flutter/material.dart';

enum RelativeRelationship {
  selectedSubject,
  prequisite,
  postrequisite,
}

extension Properties on RelativeRelationship {
  String get label {
    switch (this) {
      case RelativeRelationship.selectedSubject:
        return 'Selected subject';
      case RelativeRelationship.prequisite:
        return 'Subject pre-requisite';
      case RelativeRelationship.postrequisite:
        return 'Subject post-requisite';
    }
  }

  Color get color {
    switch (this) {
      case RelativeRelationship.selectedSubject:
        return const Color.fromARGB(255, 104, 197, 107);
      case RelativeRelationship.prequisite:
        return const Color.fromARGB(255, 231, 102, 92);
      case RelativeRelationship.postrequisite:
        return AppColors.primaryColor;
    }
  }

  double get nodeHeight {
    switch (this) {
      case RelativeRelationship.selectedSubject:
      case RelativeRelationship.prequisite:
      case RelativeRelationship.postrequisite:
        return 80;
    }
  }

  double get nodeWidth {
    switch (this) {
      case RelativeRelationship.selectedSubject:
      case RelativeRelationship.prequisite:
      case RelativeRelationship.postrequisite:
        return 160;
    }
  }

  double get borderRadius {
    switch (this) {
      case RelativeRelationship.selectedSubject:
      case RelativeRelationship.prequisite:
      case RelativeRelationship.postrequisite:
        return 10;
    }
  }
}
