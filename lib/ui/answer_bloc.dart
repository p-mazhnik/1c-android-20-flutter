import 'dart:async';

import 'package:android_course_20_flutter/data/model/answer.dart';
import 'package:android_course_20_flutter/data/repository/question_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'answer_event.dart';
part 'answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  final QuestionRepository questionRepository;

  AnswerBloc({@required this.questionRepository}) : assert(questionRepository != null), super(AnswersInitial());

  @override
  Stream<AnswerState> mapEventToState(
    AnswerEvent event,
  ) async* {
    if(event is AnswerListRequested) {
      try {
        yield AnswersInitial();
        final List<Answer> answers = await questionRepository.getAnswers(
            event.questionId);
        yield AnswersLoadSuccess(answers: answers);
      } catch (_) {
        yield AnswersLoadSuccess(answers: []);
      }
    }
  }
}
