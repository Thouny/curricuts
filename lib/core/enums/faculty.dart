enum Faculty { engineeringIT, unmapped }

extension FacultyExtension on Faculty {
  String get name {
    switch (this) {
      case Faculty.engineeringIT:
        return 'Engineering and Information Technology';
      default:
        return 'Unmapped';
    }
  }
}

class FacultyTypeConverter {
  static Faculty convertFrom(String name) {
    switch (name) {
      case 'Engineering and Information Technology':
        return Faculty.engineeringIT;
      default:
        return Faculty.unmapped;
    }
  }
}
