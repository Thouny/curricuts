import 'package:curricuts/presentation/pages/curricuts.dart';
import 'package:curricuts/presentation/views/loading.dart';
import 'package:curricuts/routing/initial_page_routes.dart';
import 'package:flutter/material.dart';

class LoadingPage extends CurricUTSPage<void> {
  LoadingPage()
      : super(
          keyValue: InitialPageRoutes.loading,
          routeName: InitialPageRoutes.loading,
        );

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const LoadingView(),
    );
  }
}
