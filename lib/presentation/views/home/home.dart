import 'package:curricuts/bloc/subjects/subjects_bloc.dart';
import 'package:curricuts/presentation/widgets/error_card.dart';
import 'package:curricuts/presentation/widgets/graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: const [
          _ContentWidget(),
        ],
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: select subject with TextField
    // TODO: create auto-complete
    return BlocBuilder<SubjectsBloc, SubjectsState>(
      builder: (context, state) {
        if (state is LoadedSubjectsState) {
          return Expanded(
            child: GraphWidgetWrapper(
              subjects: state.subjects,
              selectedSubject: state.subjects[0],
            ),
          );
        } else if (state is FailedSubjectsState) {
          return ErrorCardWidget(message: state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
