import 'package:curricuts/bloc/subjects/subjects_bloc.dart';
import 'package:curricuts/presentation/pages/curricuts.dart';
import 'package:curricuts/presentation/views/subjects/subjects.dart';
import 'package:curricuts/routing/initial_page_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectsPage extends CurricUTSPage<void> {
  SubjectsPage({
    String keyValue = InitialPageRoutes.subjects,
    String routeName = InitialPageRoutes.subjects,
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
        return BlocProvider(
          create: (context) => SubjectsBloc()..add(const LoadSubjectsEvent()),
          child: const SubjectsView(),
        );
      },
    );
  }
}
