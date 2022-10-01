import 'dart:async';

import 'package:curricuts/core/enums/relative_relationship.dart';
import 'package:curricuts/core/extensions/iterable.dart';
import 'package:curricuts/domain/entities/subject.dart';
import 'package:curricuts/domain/repositories/subject.dart';
import 'package:curricuts/presentation/models/subject.dart';
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
      final builder = SugiyamaConfiguration()
        ..bendPointShape = CurvedBendPointShape(curveLength: 20)
        ..nodeSeparation = 15
        ..orientation = SugiyamaConfiguration.ORIENTATION_LEFT_RIGHT;

      final subjectsMap = subjects.groupBy((subject) => subject.code);

      // TODO: Modify the algo, search for subjects where current subject is prereq
      //DO the opposite, right now it is taking prerequisites but should
      // be the inverse
      final currentSubject = SubjectModel.fromEntity(
        event.subject,
        RelativeRelationship.selectedSubject,
      );

      final currentNode = Node.Id(currentSubject);
      graph.addNode(currentNode);

      if (currentSubject.prerequisites.isNotEmpty) {
        final prerequisites = _getCurrentSubjectPrerequisites(
          currentSubject,
          subjects,
          subjectsMap,
        );
        for (final element in prerequisites) {
          graph.addEdge(Node.Id(element), currentNode);
        }
      }

      final nextPrequisites = _buildNextPrerequisite(
        currentSubject,
        subjects,
        subjectsMap,
      );
      if (nextPrequisites.isNotEmpty) {
        for (final element in nextPrequisites) {
          graph.addEdge(currentNode, Node.Id(element));
        }
      }
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
          RelativeRelationship.selectedSubjectPrerequisite,
        );
        prerequisites.add(subjectModel);
      }
    }
    return prerequisites;
  }

  List<SubjectModel> _buildNextPrerequisite(
    SubjectModel currentSubject,
    List<SubjectEntity> subjects,
    Map<int, List<SubjectEntity>> subjectsMap,
  ) {
    final nextSubjects = <SubjectEntity>[];
    final nextPrerequisites = <SubjectModel>[];
    for (var element in subjects) {
      final isNext = element.prerequisites.contains(currentSubject.code);
      if (isNext) {
        nextSubjects.add(element);
      }
    }

    if (nextSubjects.isNotEmpty) {
      for (final element in nextSubjects) {
        final subject = subjectsMap[element.code]!.first;
        final subjectModel = SubjectModel.fromEntity(
          subject,
          RelativeRelationship.prerequisite,
        );
        nextPrerequisites.add(subjectModel);
      }
    }

    return nextPrerequisites;
  }
}
