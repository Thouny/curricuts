import 'dart:async';

import 'package:curricuts/domain/entities/subject.dart';
import 'package:curricuts/domain/repositories/subject.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'subjects_event.dart';
part 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectsEvent, SubjectsState> {
  SubjectsBloc() : super(InitialSubjectsState()) {
    on<LoadSubjectsEvent>(_onLoad);
  }

  final _repo = GetIt.I<SubjectRepository>();

  FutureOr<void> _onLoad(
    LoadSubjectsEvent event,
    Emitter<SubjectsState> emit,
  ) async {
    try {
      final subjects = await _repo.getSubjects();
      emit(LoadedSubjectsState(subjects: subjects));
    } catch (err, stack) {
      // ignore: avoid_print
      print('ERROR: ${err.toString()}, Strackstrace: $stack');
      emit(FailedSubjectsState(err.toString()));
    }
  }
}
