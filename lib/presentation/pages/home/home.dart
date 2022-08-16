import 'package:curricuts/presentation/pages/curricuts.dart';
import 'package:curricuts/presentation/views/home/home.dart';
import 'package:curricuts/routing/initial_page_routes.dart';
import 'package:flutter/material.dart';

class HomePage extends CurricUTSPage<void> {
  HomePage({
    String keyValue = InitialPageRoutes.home,
    String routeName = InitialPageRoutes.home,
    Map<String, dynamic> arguments = const <String, dynamic>{},
  }) : super(
          keyValue: keyValue,
          routeName: routeName,
          arguments: arguments,
        );

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) {
          return const HomeView();
        });
  }
}
