part of 'graph_bloc.dart';

class GraphState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialGraphState extends GraphState {}

class LoadingGraphState extends GraphState {}

class EmptyGraphState extends GraphState {}

class LoadedGraphState extends GraphState {
  LoadedGraphState({required this.graph, required this.builder});

  final Graph graph;
  final Algorithm builder;

  @override
  List<Object?> get props => [graph, builder];
}

class FailedGraphState extends GraphState {
  FailedGraphState(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
