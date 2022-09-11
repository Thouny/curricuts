import 'dart:async';

import 'package:curricuts/domain/repositories/subject.dart';
import 'package:curricuts/infrastructure/database/subject_dao.dart';
import 'package:get_it/get_it.dart';

typedef AppRunner = void Function();

class Injector {
  static Future<void> init({required AppRunner appRunner}) async {
    await _initDependencies();
    appRunner();
  }

  static Future<void> _initDependencies() async {
    _injectUtils();
    _injectDatabase();
    _injectRepositories();
    _injectServices();
  }
}

/// Register utils and misc tools.
void _injectUtils() {}

void _injectDatabase() {
  GetIt.I.registerLazySingleton<SubjectDao>(() => SubjectDao());
}

void _injectRepositories() {
  GetIt.I.registerLazySingleton<SubjectRepository>(() {
    return SubjectRepositoryImpl();
  });
}

void _injectServices() {}
