import 'package:curricuts/bloc/graph/graph_bloc.dart';
import 'package:curricuts/core/theme/app.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:curricuts/presentation/widgets/error_card.dart';
import 'package:curricuts/presentation/widgets/subject_overview_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphview/GraphView.dart';
import 'package:searchable_listview/searchable_listview.dart';

class GraphWidgetWrapper extends StatelessWidget {
  const GraphWidgetWrapper({super.key, required this.subjects});

  final List<SubjectEntity> subjects;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GraphBloc(subjects),
      child: Column(
        children: [
          _SearchSubjectWidget(subjects: subjects),
          const GraphWidget(),
        ],
      ),
    );
  }
}

class _SearchSubjectWidget extends StatelessWidget {
  const _SearchSubjectWidget({required this.subjects});

  final List<SubjectEntity> subjects;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<GraphBloc>(context);
    return SizedBox(
      height: 200,
      child: SearchableList<SubjectEntity>.seperated(
        initialList: const [],
        builder: (subject) {
          return ListTile(
            title: Text(subject.name),
            onTap: () => bloc.add(LoadGraphEvent(subject: subject)),
          );
        },
        filter: (value) {
          final filteredSubjects = subjects.where((element) {
            return element.name.toLowerCase().contains(value.toLowerCase());
          }).toList();
          return filteredSubjects;
        },
        inputDecoration: InputDecoration(
          labelText: "Search a subject",
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        seperatorBuilder: (context, indext) => const Divider(),
      ),
    );
  }
}

class GraphWidget extends StatelessWidget {
  const GraphWidget({super.key});

  Widget _generateNodeWidget(
    BuildContext context,
    SubjectEntity selectedSubject,
    SubjectEntity currentSubject,
  ) {
    final isSelected = selectedSubject == currentSubject;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: InkWell(
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (context) {
              return SubjectOverviewDialog(subject: currentSubject);
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 80,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isSelected ? 100 : 10),
            boxShadow: [
              BoxShadow(
                color: isSelected ? Colors.green : AppColors.blue,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              currentSubject.name,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphBloc, GraphState>(
      builder: (context, state) {
        if (state is LoadedGraphState) {
          return InteractiveViewer(
            // constrained: false,
            // boundaryMargin: const EdgeInsets.all(100),
            minScale: 0.001,
            maxScale: 100,
            child: GraphView(
              graph: state.graph,
              algorithm: state.builder,
              paint: Paint()
                ..color = Colors.green
                ..strokeWidth = 1
                ..style = PaintingStyle.fill,
              builder: (Node node) {
                // I can decide what widget should be shown here based on the id
                final subject = node.key!.value as SubjectEntity;
                return _generateNodeWidget(
                  context,
                  state.selectedSubject,
                  subject,
                );
              },
            ),
          );
        } else if (state is LoadingGraphState) {
          return const CircularProgressIndicator();
        } else if (state is EmptyGraphState) {
          return Text(
            'No subject has ${state.selectedSubject.name} as a prerequisite',
          );
        } else if (state is FailedGraphState) {
          return ErrorCardWidget(message: state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}