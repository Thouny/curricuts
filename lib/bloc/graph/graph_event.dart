part of 'graph_bloc.dart';

class GraphEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadGraphEvent extends GraphEvent {
  LoadGraphEvent({required this.subject});

  final SubjectEntity subject;

  @override
  List<Object?> get props => [subject];
}
