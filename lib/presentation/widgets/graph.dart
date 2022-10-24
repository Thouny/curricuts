import 'package:curricuts/bloc/graph/graph_bloc.dart';
import 'package:curricuts/core/consts/app.dart';
import 'package:curricuts/core/enums/availability.dart';
import 'package:curricuts/core/enums/relative_relationship.dart';
import 'package:curricuts/core/theme/app.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:curricuts/presentation/models/subject.dart';
import 'package:curricuts/presentation/widgets/error_card.dart';
import 'package:curricuts/presentation/widgets/header.dart';
import 'package:curricuts/presentation/widgets/legend.dart';
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
          const Header(title: AppConsts.dashboard),
          _SearchSubjectWidget(subjects: subjects),
          const Expanded(child: GraphWidget()),
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
    return Padding(
      padding: const EdgeInsets.only(top: AppPaddingValues.smallPadding),
      child: SizedBox(
        height: 200,
        child: SearchableList<SubjectEntity>.seperated(
          initialList: const [],
          builder: (subject) {
            return ListTile(
              title: Text('${subject.code} - ${subject.name}'),
              onTap: () => bloc.add(LoadGraphEvent(subject: subject)),
            );
          },
          filter: (value) {
            final filteredSubjects = subjects.where((element) {
              return '${element.code} - ${element.name}'
                  .toLowerCase()
                  .contains(value.toLowerCase());
            }).toList();
            return filteredSubjects;
          },
          inputDecoration: InputDecoration(
            labelText: "Search a subject",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          seperatorBuilder: (context, indext) => const Divider(),
        ),
      ),
    );
  }
}

class GraphWidget extends StatelessWidget {
  const GraphWidget({super.key});

  Widget _generateNodeWidget(
    BuildContext context,
    SubjectModel currentSubject,
  ) {
    final bodySmall = Theme.of(context).textTheme.bodySmall;
    return InkWell(
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (context) {
            return SubjectOverviewDialog(subject: currentSubject);
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppPaddingValues.smallPadding),
        height: currentSubject.relationship.nodeHeight,
        width: currentSubject.relationship.nodeWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            currentSubject.relationship.borderRadius,
          ),
          boxShadow: [
            BoxShadow(
              color: currentSubject.relationship.color,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                '${currentSubject.code} - ${currentSubject.name}',
                style: bodySmall?.copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            Row(
              children: [
                ..._generateIcons(currentSubject.availabilities),
                const Spacer(),
                Text(
                  currentSubject.creditPoints,
                  style: bodySmall?.copyWith(
                    color: Colors.white,
                    // fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateIcons(List<Availability> availabilities) {
    final widgets = <Widget>[];
    for (final element in availabilities) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(right: AppPaddingValues.xxSmalPadding),
          child: Container(
            width: AppSizeValues.xSmallIcon,
            height: AppSizeValues.xSmallIcon,
            decoration: BoxDecoration(
              color: element.color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphBloc, GraphState>(
      builder: (context, state) {
        if (state is LoadedGraphState) {
          return Stack(
            children: [
              InteractiveViewer(
                constrained: false,
                minScale: 0.8,
                maxScale: 5,
                child: Container(
                  alignment: Alignment.center,
                  child: GraphView(
                    graph: state.graph,
                    algorithm: state.builder,
                    paint: Paint()
                      ..color = Colors.black87
                      ..strokeWidth = 2
                      ..style = PaintingStyle.fill,
                    builder: (Node node) {
                      final subject = node.key?.value as SubjectModel;
                      return _generateNodeWidget(context, subject);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 500, width: 500),
              const Positioned(right: 50, bottom: 0, child: LegendWidget()),
            ],
          );
        } else if (state is LoadingGraphState) {
          return const Center(child: CircularProgressIndicator());
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
