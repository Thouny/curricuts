part of 'subjects_bloc.dart';

abstract class SubjectsState extends Equatable {
  const SubjectsState();

  @override
  List<Object?> get props => [];
}

class InitialSubjectsState extends SubjectsState {}

class LoadedSubjectsState extends SubjectsState {
  const LoadedSubjectsState({required this.subjects});

  final List<SubjectEntity> subjects;

  @override
  List<Object> get props => [subjects];
}

class FailedSubjectsState extends SubjectsState {
  const FailedSubjectsState(this.message);

  final String message;

  @override
  List<Object?> get props => [];
}
