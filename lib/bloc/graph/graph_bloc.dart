import 'dart:async';

import 'package:curricuts/core/enums/relative_relationship.dart';
import 'package:curricuts/core/extensions/iterable.dart';
import 'package:curricuts/core/utils/stack.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:curricuts/domain/repositories/subject.dart';
import 'package:curricuts/presentation/models/subject.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
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
      final builder = SugiyamaConfiguration()
        ..bendPointShape = CurvedBendPointShape(curveLength: 20)
        ..nodeSeparation = 50
        ..orientation = SugiyamaConfiguration.ORIENTATION_LEFT_RIGHT;

      final subjectsMap = subjects.groupBy((subject) => subject.code);

      final currentSubject = SubjectModel.fromEntity(
        event.subject,
        RelativeRelationship.selectedSubject,
      );

      final graph = _generateGraphWithDFS(
        currentSubject,
        subjects,
        subjectsMap,
      );

      if (graph.nodes.isNotEmpty) {
        emit(LoadedGraphState(
          graph: graph,
          builder: SugiyamaAlgorithm(builder),
          selectedSubject: currentSubject,
        ));
      } else {
        emit(EmptyGraphState(event.subject));
      }
    } catch (err) {
      emit(FailedGraphState(err.toString()));
      // ignore: avoid_print
      print('ERROR: $err');
    }
  }
}

extension _DepthFirstSearch on GraphBloc {
  Graph _generateGraphWithDFS(
    SubjectModel source,
    List<SubjectEntity> subjects,
    Map<int, List<SubjectEntity>> subjectsMap,
  ) {
    final graph = Graph();
    final sourceNode = Node.Id(source);
    graph.addNode(sourceNode);
    final stack = Stack<SubjectModel>();
    final pushed = <Edge>{};
    final visited = <SubjectModel>[];

    stack.push(source);
    visited.add(source);

    if (source.prerequisites.isNotEmpty) {
      final prerequisites = _getCurrentSubjectPrerequisites(
        source,
        subjects,
        subjectsMap,
      );
      for (final subject in prerequisites) {
        graph.addEdge(Node.Id(subject), sourceNode);
        visited.add(subject);
      }
    }

    outerloop:
    while (stack.isNotEmpty) {
      final currentNode = stack.peek;
      final neighbors = _getPostrequisites(
        currentNode,
        subjects,
        subjectsMap,
      );

      for (final currentNeighbor in neighbors) {
        final edge = _getTempEdge(currentNode, currentNeighbor);
        if (!pushed.contains(edge)) {
          graph.addEdge(Node.Id(currentNode), Node.Id(currentNeighbor));
          stack.push(currentNeighbor);
          pushed.add(edge);
          visited.add(currentNeighbor);

          continue outerloop;
        }
      }

      stack.pop();
    }

    return graph;
  }
}

extension _GraphHelpers on GraphBloc {
  List<SubjectModel> _getCurrentSubjectPrerequisites(
    SubjectModel currentSubject,
    List<SubjectEntity> subjects,
    Map<int, List<SubjectEntity>> subjectsMap,
  ) {
    final prerequisites = <SubjectModel>[];
    for (final element in currentSubject.prerequisites) {
      if (subjectsMap[element] != null) {
        final subject = subjectsMap[element]!.first;
        final subjectModel = SubjectModel.fromEntity(
          subject,
          RelativeRelationship.prequisite,
        );
        prerequisites.add(subjectModel);
      }
    }
    return prerequisites;
  }

  List<SubjectModel> _getPostrequisites(
    SubjectModel currentSubject,
    List<SubjectEntity> subjects,
    Map<int, List<SubjectEntity>> subjectsMap,
  ) {
    final postRequisites = <SubjectModel>[];
    for (final element in currentSubject.postrequisites) {
      if (subjectsMap[element] != null) {
        final subject = subjectsMap[element]!.first;
        final subjectModel = SubjectModel.fromEntity(
          subject,
          RelativeRelationship.postrequisite,
        );
        postRequisites.add(subjectModel);
      }
    }

    return postRequisites;
  }

  Edge _getTempEdge(
    SubjectModel source,
    SubjectModel destination, {
    Paint? paint,
  }) {
    final sourceNode = Node.Id(source);
    final destinationNode = Node.Id(destination);
    return Edge(sourceNode, destinationNode, paint: paint);
  }
}
