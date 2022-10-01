part of 'graph_bloc.dart';

class GraphState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialGraphState extends GraphState {}

class LoadingGraphState extends GraphState {}

class EmptyGraphState extends GraphState {
  EmptyGraphState(this.selectedSubject);

  final SubjectEntity selectedSubject;

  @override
  List<Object?> get props => [selectedSubject];
}

class LoadedGraphState extends GraphState {
  LoadedGraphState({
    required this.selectedSubject,
    required this.graph,
    required this.builder,
  });

  final SubjectModel selectedSubject;
  final Graph graph;
  final Algorithm builder;

  @override
  List<Object?> get props => [
        graph.nodes.hashCode,
        graph.edges.hashCode,
        graph.hashCode,
        builder,
        selectedSubject,
      ];
}

class FailedGraphState extends GraphState {
  FailedGraphState(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
