import 'package:curricuts/core/utils/injector.dart';
import 'package:flutter/material.dart';

Future<void> initApp() async {
  await Injector.init(appRunner: () {
    runApp(const App());
  });
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(),
    );
  }
}
