import 'dart:async';

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

void _injectDatabase() {}

void _injectRepositories() {}

void _injectServices() {}
