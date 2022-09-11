import 'package:csv/csv.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:flutter/services.dart';

class SubjectDao {
  Future<List<SubjectEntity>> getSubjects() async {
    return _loadCSV();
  }

  Future<List<SubjectEntity>> _loadCSV() async {
    final rawData = await rootBundle.loadString(
      'assets/csv/SUBJECT Engineering and IT.csv',
    );
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    final List<SubjectEntity> subjects = [];
    for (final row in listData) {
      final subject = SubjectEntity.fromCSV(row);
      subjects.add(subject);
    }
    return subjects;
  }
}
