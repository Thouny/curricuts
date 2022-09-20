import 'dart:convert';
import 'package:curricuts/core/consts/app.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:flutter/services.dart';

class SubjectDao {
  Future<List<SubjectEntity>> getSubjects() async {
    return _loadJson();
  }

  Future<List<SubjectEntity>> _loadJson() async {
    final rawData = await rootBundle.loadString(AppConsts.dataPath);
    final results = json.decode(rawData);
    final subjects = <SubjectEntity>[];
    for (final element in results) {
      subjects.add(SubjectEntity.fromJson(element));
    }
    return subjects;
  }
}
