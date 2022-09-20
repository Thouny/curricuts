import 'package:curricuts/bloc/subjects/subjects_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectsView extends StatelessWidget {
  const SubjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _ContentWidget(),
        ],
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectsBloc, SubjectsState>(
      builder: (context, state) {
        if (state is LoadedSubjectsState) {
          final subjects = state.subjects;
          return Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(subjects[index].name),
                );
              },
              separatorBuilder: (context, indext) => const Divider(),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
