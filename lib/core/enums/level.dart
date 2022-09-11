enum Level { undergraduate, postgraduate, unmapped }

extension LevelExtension on Level {
  String get name {
    switch (this) {
      case Level.undergraduate:
        return 'Undergraduate';
      case Level.postgraduate:
        return 'Postgraduate';
      default:
        return 'Unmapped';
    }
  }
}

class LevelTypeConverter {
  static Level convertFrom(String name) {
    switch (name) {
      case 'Undergraduate':
        return Level.undergraduate;
      case 'Postgraduate':
        return Level.postgraduate;
      default:
        return Level.unmapped;
    }
  }
}
