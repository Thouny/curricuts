import 'package:flutter/material.dart';

enum Availability { autumn, spring, summer }

extension Properties on Availability {
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
