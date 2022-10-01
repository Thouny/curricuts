import 'package:curricuts/bloc/subjects/subjects_bloc.dart';
import 'package:curricuts/core/utils/responsive.dart';
import 'package:curricuts/presentation/widgets/error_card.dart';
import 'package:curricuts/presentation/widgets/graph.dart';
import 'package:curricuts/presentation/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // We want this side menu only for large screen
          if (Responsive.isDesktop(context))
            const Expanded(
              // default flex = 1
              // and it takes 1/6 part of the screen
              child: SideMenu(),
            ),
          const Expanded(
            // It takes 5/6 part of the screen
            flex: 5,
            child: _ContentWidget(),
          ),
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GraphWidgetWrapper(subjects: state.subjects),
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
