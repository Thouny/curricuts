import 'dart:async';

import 'package:curricuts/core/extensions/iterable.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:curricuts/domain/repositories/subject.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graphview/GraphView.dart';

part 'graph_event.dart';
part 'graph_state.dart';

class GraphBloc extends Bloc<GraphEvent, GraphState> {
  GraphBloc(this.subjects) : super(InitialGraphState()) {
    on<LoadGraphEvent>(_onLoadGraph);
  }

  final List<SubjectEntity> subjects;
  final subjectRepo = GetIt.I<SubjectRepository>();

  FutureOr<void> _onLoadGraph(
    LoadGraphEvent event,
    Emitter<GraphState> emit,
  ) async {
    try {
      emit(LoadingGraphState());
      final graph = Graph();
      final builder = FruchtermanReingoldAlgorithm(
        renderer: ArrowEdgeRenderer(),
      );

      final subjectsMap = subjects.groupBy((subject) => subject.code);

      // TODO: Modify the algo, search for subjects where current subject is prereq
      //DO the opposite, right now it is taking prerequisites but should
      // be the inverse
      final currentSubject = event.subject;
      final currentNode = Node.Id(currentSubject);
      // if (currentSubject.prerequisites.isNotEmpty) {
      //   final currentNode = Node.Id(currentSubject);
      //   for (final element in currentSubject.prerequisites) {
      //     if (subjectsMap[element] != null) {
      //       final subject = subjectsMap[element]!.first;
      //       graph.addEdge(currentNode, Node.Id(subject));
      //     }
      //   }

      //   emit(LoadedGraphState(graph: graph, builder: builder));
      // } else {
      //   emit(EmptyGraphState());
      // }
      final nextSubjects = <SubjectEntity>[];

      for (var element in subjects) {
        final isNext = element.prerequisites.contains(currentSubject.code);
        if (isNext) {
          nextSubjects.add(element);
        }
      }

      if (nextSubjects.isNotEmpty) {
        for (final element in nextSubjects) {
          final currentSubject = element;
          // subjects.firstWhere((element) => element.code == currentSubject.code);
          // if (subjectsMap[element.code] != null) {
          final subject = subjectsMap[element.code]!.first;
          graph.addEdge(currentNode, Node.Id(subject));
          // }
        }
        emit(LoadedGraphState(graph: graph, builder: builder));
      } else {
        emit(EmptyGraphState());
      }
    } catch (err) {
      emit(FailedGraphState(err.toString()));
      // ignore: avoid_print
      print('ERROR: $err');
    }
  }
}

extension _GraphHelpers on GraphBloc {
  Node _generateNode(Graph graph, SubjectEntity subject) {
    return Node.Id(subject);
  }

  void _generatesEdges(
    Graph graph, {
    required SubjectEntity from,
    required SubjectEntity to,
  }) {}
}
