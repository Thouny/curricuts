import 'package:curricuts/domain/entities/subject.dart';
import 'package:curricuts/infrastructure/database/subject_dao.dart';
import 'package:get_it/get_it.dart';

abstract class SubjectRepository {
  Future<List<SubjectEntity>> getSubjects();
}

class SubjectRepositoryImpl implements SubjectRepository {
  final _dao = GetIt.I<SubjectDao>();

  @override
  Future<List<SubjectEntity>> getSubjects() {
    return _dao.getSubjects();
  }
}
