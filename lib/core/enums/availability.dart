import 'package:flutter/material.dart';

enum Availability { autumn, spring, summer }

extension Properties on Availability {
  String get label {
    switch (this) {
      case Availability.autumn:
        return 'Autumn session';
      case Availability.spring:
        return 'Spring session';
      case Availability.summer:
        return 'Summer session';
    }
  }

  Color get color {
    switch (this) {
      case Availability.autumn:
        return Colors.cyan;
      case Availability.spring:
        return Colors.orangeAccent;
      case Availability.summer:
        return Colors.limeAccent;
    }
  }
}
